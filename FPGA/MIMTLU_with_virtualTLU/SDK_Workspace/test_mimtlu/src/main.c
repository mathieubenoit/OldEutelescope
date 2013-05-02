/*
 * Copyright (c) 2009-2010 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

#include <stdio.h>

#include "xparameters.h"

#include "netif/xadapter.h"

#include "platform.h"
#include "platform_config.h"
#include "xbasic_types.h"
#include "microblaze_interrupts_i.h"
#include "xintc.h"
#include "xil_exception.h"
#include "xbasic_types.h"
#include "xstatus.h"
#include "xintc_l.h"
#include "xintc_i.h"

#include <string.h>

#include "lwip/err.h"
#include "lwip/tcp.h"
#include "xparameters.h"


/* defined by each RAW mode application */
void print_app_header();
int start_application();
int transfer_data();
int itr_cnt;
Xboolean msg_recvd,itr_rcvd;
struct tcp_pcb *Gpcb;


/* missing declaration in lwIP */
void lwip_init();

struct packet {
	char msg[4];
	u32 data;
};



void
print_ip(char *msg, struct ip_addr *ip) 
{
	print(msg);
	xil_printf("%d.%d.%d.%d\n\r", ip4_addr1(ip), ip4_addr2(ip), 
			ip4_addr3(ip), ip4_addr4(ip));
}

void
print_ip_settings(struct ip_addr *ip, struct ip_addr *mask, struct ip_addr *gw)
{

	print_ip("Board IP: ", ip);
	print_ip("Netmask : ", mask);
	print_ip("Gateway : ", gw);
}

void MyTimestampInterruptHandler(void)
{

	//xil_printf("interrupt \r\n");
	//xil_printf("%d \r \n",itr_cnt);
	itr_cnt+=1;
	itr_rcvd=1;
//	err_t err;
//
//	u32 *timestamp=0;
//	timestamp = (u32*)XPAR_MIMTLU_0_BASEADDR;
//	xil_printf("Timestamp : %d \r\n",*timestamp);
//	tcp_sndbuf(tpcb);
//	err = tcp_write(tpcb,timestamp,4, 0x01 & 0x02);
//	err = tcp_output(tpcb);
//
//	xil_printf("%d \r \n",err);

}


void SetBusyLength(u32 length){

	u32 *reg;
	reg=XPAR_MIMTLU_0_BASEADDR+0x4;
	*reg=length;

	//memcpy(XPAR_MIMTLU_0_BASEADDR+0x4,0xF,sizeof(0xF));

}



int transfer_data() {

	if(msg_recvd==1 && itr_rcvd==1){

		struct pbuf * pbuf_to_be_sent = pbuf_alloc(PBUF_TRANSPORT, 4, PBUF_POOL);
		u32 *timestamp=0;
		if (!pbuf_to_be_sent) {
			xil_printf("error allocating pbuf to send\r\n");
			return 0;
		}
		else {
			//fill the payload here !!
			timestamp = (u32*)XPAR_MIMTLU_0_BASEADDR;
			memcpy(pbuf_to_be_sent->payload,timestamp,4);
		}

		err_t err = tcp_write(Gpcb, pbuf_to_be_sent->payload,pbuf_to_be_sent->len,0x01 & 0x02);
		err = tcp_output(Gpcb);
		if (err != ERR_OK) {
			xil_printf("Error on udp_send: %d\r\n", err);
			pbuf_free(pbuf_to_be_sent);
			msg_recvd=0;
			itr_rcvd=0;
			return -1;
		}
		else {
			//printf("just sent that %d \r\n",timestamp);
			msg_recvd=0;
			itr_rcvd=0;
		}

		pbuf_free(pbuf_to_be_sent);



	}


	return 0;
}

void print_app_header()
{
	xil_printf("\n\r\n\r-----lwIP TCP MIMTLU Server ------\n\r");
	xil_printf("TCP packets sent to port 6001 will be echoed back\n\r");
}

err_t recv_callback(void *arg, struct tcp_pcb *tpcb,
                               struct pbuf *p, err_t err)
{
	/* do not read the packet if we are not in ESTABLISHED state */
	if (!p) {
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
		return ERR_OK;
	}

	/* indicate that the packet has been received */
	tcp_recved(tpcb, p->len);

	/* echo back the payload */
	/* in this case, we assume that the payload is < TCP_SND_BUF */

	//print("packet received, waiting for interrupt \r \n");

	char *msg;
	char *a;
	u32 b;

	//printf("%s \r\n",p->payload);
	sscanf(p->payload,"%s %u",a,&b);


	//printf("packet data %u %s \r\n",b,a);

	if(strncmp(a,"SETB",4)==0){

		SetBusyLength(b);

	}
	else if(strncmp(a,"READ",4)==0){
		msg_recvd=1;
	};

	//msg_recvd=1;
	pbuf_free(p);


	return ERR_OK;
}

err_t accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err)
{
	static int connection = 1;



	/* set the receive callback for this connection */
	tcp_recv(newpcb, recv_callback);

	/* just use an integer number indicating the connection id as the
	   callback argument */
	tcp_arg(newpcb, (void*)connection);

	/* increment for subsequent accepted connections */
	connection++;
	Gpcb= newpcb;

	return ERR_OK;
}


int start_application()
{
	struct tcp_pcb *pcb;
	err_t err;
	unsigned port = 7;

	msg_recvd=0;
	itr_rcvd=0;

	/* create new TCP PCB structure */
	pcb = tcp_new();
	if (!pcb) {
		xil_printf("Error creating PCB. Out of Memory\n\r");
		return -1;
	}

	/* bind to specified @port */
	err = tcp_bind(pcb, IP_ADDR_ANY, port);
	if (err != ERR_OK) {
		xil_printf("Unable to bind to port %d: err = %d\n\r", port, err);
		return -2;
	}

	/* we do not need any arguments to callback functions */
	tcp_arg(pcb, NULL);

	/* listen for connections */
	pcb = tcp_listen(pcb);
	if (!pcb) {
		xil_printf("Out of memory while tcp_listen\n\r");
		return -3;
	}

	/* specify callback to use for incoming connections */
	tcp_accept(pcb, accept_callback);

	xil_printf("TCP echo server started @ port %d\n\r", port);

	XIntc_RegisterHandler(XPAR_MICROBLAZE_0_INTC_BASEADDR,XPAR_MICROBLAZE_0_INTC_MIMTLU_0_DATA_ITR_INTR,(XInterruptHandler)MyTimestampInterruptHandler,0);

	Gpcb=pcb;

	return 0;
}


int main()
{

	struct netif *netif, server_netif;
	struct ip_addr ipaddr, netmask, gw;

	/* the mac address of the board. this should be unique per board */
	unsigned char mac_ethernet_address[] = { 0x00, 0x0a, 0x35, 0x00, 0x01, 0x02 };

	netif = &server_netif;

	init_platform();


	/* initliaze IP addresses to be used */
	IP4_ADDR(&ipaddr,  192, 168,   1, 10);
	IP4_ADDR(&netmask, 255, 255, 255,  0);
	IP4_ADDR(&gw,      192, 168,   1,  1);

	print_app_header();
	print_ip_settings(&ipaddr, &netmask, &gw);

	lwip_init();

  	/* Add network interface to the netif_list, and set it as default */
	if (!xemac_add(netif, &ipaddr, &netmask, &gw, mac_ethernet_address, PLATFORM_EMAC_BASEADDR)) {
		xil_printf("Error adding N/W interface\n\r");
		return -1;
	}
	netif_set_default(netif);
	
	/* Create a new DHCP client for this interface.
	 * Note: you must call dhcp_fine_tmr() and dhcp_coarse_tmr() at
	 * the predefined regular intervals after starting the client.
	 */
	/* dhcp_start(netif); */

	/* now enable interrupts */
	platform_enable_interrupts();


	/* specify that the network if is up */
	netif_set_up(netif);


	//interrupt counter
	itr_cnt=0;


	/* start the application (web server, rxtest, txtest, etc..) */
	start_application();

	/* receive and process packets */

	//microblaze_enable_interrupts();




	while (1) {
		xemacif_input(netif);
		transfer_data();
	}
  
	/* never reached */
	cleanup_platform();

	return 0;
}
