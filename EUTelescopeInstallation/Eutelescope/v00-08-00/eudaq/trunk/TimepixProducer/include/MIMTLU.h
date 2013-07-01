/*
 * MIMTLU.h
 *
 *  Created on: May 7, 2013
 *      Author: mbenoit
 */

#ifndef MIMTLU_H_
#define MIMTLU_H_

#include <iostream>
#include <fstream>
#include <cstring>      // Needed for memset
#include <sys/socket.h> // Needed for the socket functions
#include <netdb.h>      // Needed for the socket functions
#include <time.h>
#include <signal.h>
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

using namespace std;


class MIMTLU {
public:
	MIMTLU();
	int Connect(char* IP,char* port);
	int Arm();
	int GetEvent();


private :

	int status;
	struct addrinfo host_info;       // The struct that getaddrinfo() fills up with data.
	struct addrinfo *host_info_list; // Pointer to the to the linked list of host_info's.
	int socketfd ; // The socket descriptor
	int len, bytes_sent;
	ssize_t bytes_recieved;
	char msg [1024];
	char incoming_data_buffer[1024];
	unsigned int tluevtnr;



};

#endif /* MIMTLU_H_ */