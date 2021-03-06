
! Code converted using TO_F90 by Alan Miller
! Date: 2012-03-16  Time: 11:08:48

!> \file
!! MC for simple 100 plane chamber.
!!
!! No B-field, straight tracks. Selected with command line option '-t'.
!!
!! Global parameters:
!! - Position offsets in measurement direction (alignment).
!! - Relative drift velocity corrections (calibration).


!> Parameters and data.
MODULE mptest1
    IMPLICIT NONE
    SAVE

    INTEGER, PARAMETER :: nplan=100

    !     define detector geometry
    REAL, PARAMETER :: detx= 10.0      !< x-value of first plane
    REAL, PARAMETER :: disx= 10.0      !< distance between planes
    REAL, PARAMETER :: thck=  2.0      !< thickness of plane
    REAL, PARAMETER :: heit=100.0      !< height of detector plane
    REAL, PARAMETER :: effp=0.90       !< plane efficiency
    REAL, PARAMETER :: sgmp=0.0150     !< measurement sigma

    ! misalignment
    REAL, DIMENSION(nplan) :: del      !< shift (position deviation) (alignment parameter)
    REAL, DIMENSION(nplan) :: dvd      !< rel. drift velocity deviation (calibration parameter)
    ! track parameter
    REAL :: ynull                      !< track position at vertex
    REAL :: slope                      !< track slope

    INTEGER :: nhits                   !< number of hits
    INTEGER, DIMENSION(nplan) :: ihits !< plane numbers (planes with hits)
    REAL, DIMENSION(nplan) :: eff      !< plane efficiency
    REAL, DIMENSION(nplan) :: sgm      !< measurement sigma (plane)
    REAL, DIMENSION(nplan) :: ydrft    !< signed drift length
    REAL, DIMENSION(nplan) :: xhits    !< position perp. to plane (hit)
    REAL, DIMENSION(nplan) :: yhits    !< measured position in plane (hit)
    REAL, DIMENSION(nplan) :: sigma    !< measurement sigma (hit)

END MODULE mptest1

!> Generate test files.
!!
!! Create text and binary files.
!!
!!      unit  8: textfile mp2str.txt   = steering file
!!      unit  9: textfile mp2con.txt   = constraint file
!!      unit 51: binary file mp2test.bin, written using CALL MILLE(.)
!!      existing file are removed

SUBROUTINE mptest
    USE mptest1

    IMPLICIT NONE
    REAL :: dbar
    REAL :: det
    REAL :: displ
    REAL :: drift
    REAL :: eps
    REAL :: eta
    REAL :: gran
    REAL :: one
    REAL :: ww
    REAL :: x
    REAL :: xbar
    INTEGER :: i
    INTEGER :: icount
    INTEGER :: ios
    INTEGER :: ip
    INTEGER :: ipl
    INTEGER :: labelt
    INTEGER :: luns
    INTEGER :: lunt
    INTEGER :: ncount
    INTEGER :: nrecds
    INTEGER :: nthits

    DOUBLE PRECISION :: s1
    DOUBLE PRECISION :: s2
    DOUBLE PRECISION :: sw
    DOUBLE PRECISION :: sv
    DOUBLE PRECISION :: sum1
    DOUBLE PRECISION :: sum2
    REAL :: derlc(2)
    REAL :: dergl(2)
    INTEGER :: label(2)
    LOGICAL :: ex1
    LOGICAL :: ex2
    LOGICAL :: ex3
    !     ...
    !CC      CALL RNTIME
    INQUIRE(FILE='mp2str.txt',IOSTAT=ios,EXIST=ex1) ! keep, if existing
    INQUIRE(FILE='mp2con.txt',IOSTAT=ios,EXIST=ex2) ! keep, if existing

    INQUIRE(FILE='mp2tst.bin',IOSTAT=ios,EXIST=ex3) ! remove, if existing

    WRITE(*,*) ' '
    WRITE(*,*) 'Generating test data for mp II...'
    WRITE(*,*) ' '
    !     file management
    IF(ex3) CALL system('rm mp2tst.bin')   ! remove old file

    IF(.NOT.ex1) OPEN(UNIT=7,ACCESS='SEQUENTIAL',FORM='FORMATTED',  &
        FILE='mp2str.txt')
    IF(.NOT.ex2) OPEN(UNIT=9,ACCESS='SEQUENTIAL',FORM='FORMATTED',  &
        FILE='mp2con.txt')
    OPEN(UNIT=51,ACCESS='SEQUENTIAL',FORM='UNFORMATTED', FILE='mp2tst.bin')

    DO i=1,nplan
        eff(i)=effp          ! plane efficiency
        sgm(i)=sgmp          ! measurement sigma
        del(i)=0.0           ! true shift is zero
    END DO

    ipl=7                 ! modify one plane (7)
    eff(ipl)=0.1          ! low efficiency
    sgm(ipl)=0.0400       ! bad resolution

    !     misalign detector planes -----------------------------------------

    displ=0.1                        ! displacement 1 mm * N(0,1)
    drift=0.02                       ! Vdrift deviation 2 %  * N(0,1)
    DO i=1,nplan
        del(i)=displ*gran()             ! shift
        dvd(i)=drift*gran()             ! rel. drift velocitu deviation
    END DO
    del(10)=0.0                      ! no shift
    del(90)=0.0                      ! no shift

    !     write text files -------------------------------------------------

    IF(.NOT.ex1) THEN
        luns=7                           ! steerfile
        WRITE(luns,101) '*            Default test steering file'
        WRITE(luns,101) 'fortranfiles ! following bin files are fortran'
        WRITE(luns,101) 'mp2con.txt   ! constraints text file '
        WRITE(luns,101) 'mp2tst.bin   ! binary data file'
        WRITE(luns,101) 'Cfiles       ! following bin files are Cfiles'
        !      WRITE(LUNS,101) '*outlierrejection 100.0 ! reject if Chi^2/Ndf >'
        !      WRITE(LUNS,101) '*outliersuppression 3   ! 3 local_fit iterations'

        WRITE(luns,101) '*hugecut 50.0     !cut factor in iteration 0'
        WRITE(luns,101) '*chisqcut 1.0 1.0 ! cut factor in iterations 1 and 2'
        WRITE(luns,101) '*entries  10 ! lower limit on number of entries/parameter'
        WRITE(luns,101)  &
            '*pairentries 10 ! lower limit on number of parameter pairs',  &
            '                ! (not yet!)'
        WRITE(luns,101) '*printrecord   1  2      ! debug printout for records'
        WRITE(luns,101)  &
            '*printrecord  -1 -1      ! debug printout for bad data records'
        WRITE(luns,101)  &
            '*outlierdownweighting  2 ! number of internal iterations (> 1)'
        WRITE(luns,101) '*dwfractioncut      0.2  ! 0 < value < 0.5'
        WRITE(luns,101) '*presigma           0.01 ! default value for presigma'
        WRITE(luns,101) '*regularisation 1.0      ! regularisation factor'
        WRITE(luns,101) '*regularisation 1.0 0.01 ! regularisation factor, pre-sigma'

        WRITE(luns,101) ' '
        WRITE(luns,101) '*bandwidth 0         ! width of precond. band matrix'
        WRITE(luns,101) 'method diagonalization 3 0.001 ! diagonalization      '
        WRITE(luns,101) 'method fullMINRES       3 0.01 ! minimal residual     '
        WRITE(luns,101) 'method sparseMINRES     3 0.01 ! minimal residual     '
        WRITE(luns,101) '*mrestol      1.0D-8          ! epsilon for MINRES'
        WRITE(luns,101) 'method inversion       3 0.001 ! Gauss matrix inversion'
        WRITE(luns,101) '* last method is applied'
        WRITE(luns,101) '*matiter      3  ! recalculate matrix in iterations'
        WRITE(luns,101) ' '
        WRITE(luns,101) 'end ! optional for end-of-data'
    ENDIF

    lunt=9                           ! constraint file
    one=1.0                          ! shift constraint
    IF(.NOT.ex2) WRITE(lunt,*) 'Constraint  0.0'
    DO i=1,nplan
        labelt=10+i*2
        x=detx+FLOAT(i-1)*disx+0.5*thck
        IF(.NOT.ex2) WRITE(lunt,103) labelt,one
    END DO

    sw=0.0D0                         ! tilt constraint
    sv=0.0D0
    s1=0.0D0
    s2=0.0D0
    IF(.NOT.ex2) WRITE(lunt,*) 'Constraint 0.0'   ! write
    dbar=0.5*FLOAT(nplan-1)*disx
    xbar=detx+0.5*FLOAT(nplan-1)*disx! +0.5*THCK
    DO i=1,nplan
        labelt=10+i*2
        x=detx+FLOAT(i-1)*disx          !+0.5*THCK
        ww=(x-xbar)/dbar
        IF(.NOT.ex2) WRITE(lunt,103) labelt,ww          ! write
        s1=s1+del(i)
        s2=s2+ww*del(i)
        sw=sw+ww
        sv=sv+ww*ww
    END DO


    det=REAL(FLOAT(nplan)*sv-sw*sw)
    eps=REAL(sv*s1-sw*s2)/det
    eta=REAL(FLOAT(nplan)*s2-sw*s1)/det
    DO i=1,nplan
        x=detx+FLOAT(i-1)*disx
        ww=(x-xbar)/dbar
        del(i)=del(i)-eps-eta*ww        ! correct displacement ...
    END DO                           ! ... for constraints

    sum1=0.0
    sum2=0.0
    DO i=1,nplan
        sum1=sum1+del(i)
        x=detx+FLOAT(i-1)*disx          !+0.5*THCK
        ww=(x-xbar)/dbar
        sum2=sum2+del(i)*ww
    END DO
    !      WRITE(*,*) '   Check for constraints ',SUM1,SUM2

    !     record loop ------------------------------------------------------

    ncount=10000
    nthits=0
    nrecds=0

    DO icount=1,ncount
        ip=0
        IF(icount == 8759) ip=1
        !       IF(ICOUNT.EQ.6309) IP=1
        !       IF(ICOUNT.EQ.7468) IP=1
        CALL genlin(ip)      ! generate hits
  
        DO i=1,nhits
            derlc(1)=1.0
            derlc(2)=xhits(i)
            dergl(1)=1.0
            dergl(2)=ydrft(i)
            label(1)=10+ihits(i)*2
            label(2)=500 + ihits(i)
            CALL mille(2,derlc,2,dergl,label,yhits(i),sigma(i))
            nthits=nthits+1  ! count hits
        END DO
        CALL endle
        nrecds=nrecds+1   ! count records
    END DO

    !     ------------------------------------------------------------------
    IF(.NOT.ex1) THEN
        REWIND  (7)
        CLOSE   (7)
    END IF
    IF(.NOT.ex2) THEN
        REWIND  (9)
        CLOSE   (9)
    END IF
    REWIND (51)
    CLOSE  (51)

    !      WRITE(*,*) ' '
    !      WRITE(*,*) 'Shifts and drift velocity deviations:'
    !      DO I=1,NPLAN
    !       WRITE(*,102) I,DEL(I),DVD(I)
    !      END DO


    WRITE(*,*) ' '
    WRITE(*,*) ' '
    WRITE(*,*) ncount,' tracks generated with ',nthits,' hits.'
    WRITE(*,*) nrecds,' records written.'
    WRITE(*,*) ' '
101 FORMAT(a)
    ! 102  FORMAT(I6,2F10.5)
103 FORMAT(i8,f10.5)
END SUBROUTINE mptest                          ! gener

!> Generate line and measurements.
!!
!! \param [in] ip print flag

SUBROUTINE genlin(ip)
    USE mptest1

    IMPLICIT NONE
    REAL :: gr
    REAL :: gran
    REAL :: uran
    REAL :: x
    REAL :: ybias
    REAL :: ydvds
    REAL :: ylin
    REAL :: ymeas
    REAL :: ywire
    INTEGER :: i
    INTEGER :: nwire

    INTEGER, INTENT(IN)                      :: ip

    !     ...
    ynull=0.5*heit+0.1*heit*(uran()-0.5)   ! uniform vertex
    slope=(uran()-0.5)*heit/(FLOAT(nplan-1)*disx)
    IF(ip /= 0) THEN
        WRITE(*,*) ' '
    !         WRITE(*,*) 'YNULL=',YNULL,'    SLOPE=',SLOPE
    END IF
    nhits=0
    DO i=1,nplan
        x=detx+FLOAT(i-1)*disx  !  +0.5*THCK
        IF(uran() < eff(i)) THEN
            ylin        =ynull+slope*x             ! true y value
            ybias       =ylin-del(i)               ! biased value
            nwire=INT(1.0+ybias/4.0)               ! wire number
            IF(nwire <= 0.OR.nwire > 25) EXIT      ! check wire number
            nhits=nhits+1                          ! track hits the plane
            xhits(nhits)=x
            ihits(nhits)=i
            gr=gran()
            ymeas=sgm(i)*gr
            ydvds=0.0
            yhits(nhits)=ybias+ymeas+ydvds     ! measured
            ywire=FLOAT(nwire)*4.0-2.0
            ydrft(nhits)=ybias-ywire           ! signed drift length
            ydvds=ydrft(nhits)*dvd(i)
            yhits(nhits)=ybias+ymeas-ydvds     ! measured
            sigma(nhits)=sgm(i)
            IF(ip /= 0) THEN
            !             WRITE(*,101) NHITS,I,X,YLIN,YBIAS,YMEAS,
            !     +       SGM(I),YHITS(NHITS),GR,DEL(I)
            END IF
        END IF
    END DO
! 101  FORMAT(2I3,F5.0,7F8.4)
END SUBROUTINE genlin
