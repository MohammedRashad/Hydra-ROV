
_SPI_Ethernet_UserTCP:

;ROV Control.c,48 :: 		unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags) {
;ROV Control.c,49 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
;ROV Control.c,50 :: 		}
L_end_SPI_Ethernet_UserTCP:
	RETURN      0
; end of _SPI_Ethernet_UserTCP

_SPI_Ethernet_UserUDP:

;ROV Control.c,56 :: 		unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags) {
;ROV Control.c,60 :: 		if (destPort != 9876) {
	MOVF        FARG_SPI_Ethernet_UserUDP_destPort+1, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP24
	MOVLW       148
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+0, 0 
L__SPI_Ethernet_UserUDP24:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP0
;ROV Control.c,62 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserUDP
;ROV Control.c,63 :: 		}
L_SPI_Ethernet_UserUDP0:
;ROV Control.c,66 :: 		while( reqLength-- ){
L_SPI_Ethernet_UserUDP1:
	MOVF        FARG_SPI_Ethernet_UserUDP_reqLength+0, 0 
	MOVWF       R0 
	MOVF        FARG_SPI_Ethernet_UserUDP_reqLength+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       FARG_SPI_Ethernet_UserUDP_reqLength+0, 1 
	MOVLW       0
	SUBWFB      FARG_SPI_Ethernet_UserUDP_reqLength+1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP2
;ROV Control.c,68 :: 		recievedData[reqLength - 1] = SPI_Ethernet_getByte();
	MOVLW       1
	SUBWF       FARG_SPI_Ethernet_UserUDP_reqLength+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_SPI_Ethernet_UserUDP_reqLength+1, 0 
	MOVWF       R1 
	MOVLW       _recievedData+0
	ADDWF       R0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+0 
	MOVLW       hi_addr(_recievedData+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+1 
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVFF       FLOC__SPI_Ethernet_UserUDP+0, FSR1
	MOVFF       FLOC__SPI_Ethernet_UserUDP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ROV Control.c,70 :: 		}
	GOTO        L_SPI_Ethernet_UserUDP1
L_SPI_Ethernet_UserUDP2:
;ROV Control.c,72 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
;ROV Control.c,74 :: 		}
L_end_SPI_Ethernet_UserUDP:
	RETURN      0
; end of _SPI_Ethernet_UserUDP

_motorUp:

;ROV Control.c,77 :: 		void motorUp(char direction , char speed){
;ROV Control.c,81 :: 		if(direction == 1){
	MOVF        FARG_motorUp_direction+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_motorUp3
;ROV Control.c,83 :: 		PORTB.B5 = 1;
	BSF         PORTB+0, 5 
;ROV Control.c,84 :: 		PORTB.B4 = 0;
	BCF         PORTB+0, 4 
;ROV Control.c,86 :: 		PORTD.B7 = 1;
	BSF         PORTD+0, 7 
;ROV Control.c,87 :: 		PORTB.B7 = 0;
	BCF         PORTB+0, 7 
;ROV Control.c,89 :: 		}
L_motorUp3:
;ROV Control.c,91 :: 		PWMsetting[0] = speed;
	MOVF        FARG_motorUp_speed+0, 0 
	MOVWF       _PWMsetting+0 
;ROV Control.c,92 :: 		PWMsetting[1] = speed;
	MOVF        FARG_motorUp_speed+0, 0 
	MOVWF       _PWMsetting+1 
;ROV Control.c,93 :: 		PWMsetting[2] = 0;
	CLRF        _PWMsetting+2 
;ROV Control.c,94 :: 		PWMsetting[3] = 0;
	CLRF        _PWMsetting+3 
;ROV Control.c,96 :: 		UART1_Write(PWMsetting[0]);
	MOVF        _PWMsetting+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,97 :: 		UART1_Write(PWMsetting[1]);
	MOVF        _PWMsetting+1, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,98 :: 		UART1_Write(PWMsetting[2]);
	MOVF        _PWMsetting+2, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,99 :: 		UART1_Write(PWMsetting[3]);
	MOVF        _PWMsetting+3, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,101 :: 		}
L_end_motorUp:
	RETURN      0
; end of _motorUp

_motorDown:

;ROV Control.c,104 :: 		void motorDown(char direction , char speed){
;ROV Control.c,106 :: 		if(direction == 0){
	MOVF        FARG_motorDown_direction+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_motorDown4
;ROV Control.c,108 :: 		PORTB.B5 = 0;
	BCF         PORTB+0, 5 
;ROV Control.c,109 :: 		PORTB.B4 = 1;
	BSF         PORTB+0, 4 
;ROV Control.c,111 :: 		PORTD.B7 = 0;
	BCF         PORTD+0, 7 
;ROV Control.c,112 :: 		PORTB.B7 = 1;
	BSF         PORTB+0, 7 
;ROV Control.c,115 :: 		PWMsetting[0] = speed;
	MOVF        FARG_motorDown_speed+0, 0 
	MOVWF       _PWMsetting+0 
;ROV Control.c,116 :: 		PWMsetting[1] = speed;
	MOVF        FARG_motorDown_speed+0, 0 
	MOVWF       _PWMsetting+1 
;ROV Control.c,117 :: 		PWMsetting[2] = 0;
	CLRF        _PWMsetting+2 
;ROV Control.c,118 :: 		PWMsetting[3] = 0;
	CLRF        _PWMsetting+3 
;ROV Control.c,120 :: 		UART1_Write(PWMsetting[0]);
	MOVF        _PWMsetting+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,121 :: 		UART1_Write(PWMsetting[1]);
	MOVF        _PWMsetting+1, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,122 :: 		UART1_Write(PWMsetting[2]);
	MOVF        _PWMsetting+2, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,123 :: 		UART1_Write(PWMsetting[3]);
	MOVF        _PWMsetting+3, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,125 :: 		}
L_motorDown4:
;ROV Control.c,126 :: 		}
L_end_motorDown:
	RETURN      0
; end of _motorDown

_motorLeft:

;ROV Control.c,128 :: 		void motorLeft(char direction , char speed){
;ROV Control.c,130 :: 		if(direction == 1){
	MOVF        FARG_motorLeft_direction+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_motorLeft5
;ROV Control.c,132 :: 		PORTB.B0 = 1;
	BSF         PORTB+0, 0 
;ROV Control.c,133 :: 		PORTB.B1 = 0;
	BCF         PORTB+0, 1 
;ROV Control.c,135 :: 		PORTD.B4 = 1;
	BSF         PORTD+0, 4 
;ROV Control.c,136 :: 		PORTD.B2 = 0;
	BCF         PORTD+0, 2 
;ROV Control.c,138 :: 		PWMsetting[2] = 0;
	CLRF        _PWMsetting+2 
;ROV Control.c,139 :: 		PWMsetting[3] = speed;
	MOVF        FARG_motorLeft_speed+0, 0 
	MOVWF       _PWMsetting+3 
;ROV Control.c,140 :: 		PWMsetting[1] = 0;
	CLRF        _PWMsetting+1 
;ROV Control.c,141 :: 		PWMsetting[0] = 0;
	CLRF        _PWMsetting+0 
;ROV Control.c,143 :: 		UART1_Write(PWMsetting[0]);
	CLRF        FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,144 :: 		UART1_Write(PWMsetting[1]);
	MOVF        _PWMsetting+1, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,145 :: 		UART1_Write(PWMsetting[2]);
	MOVF        _PWMsetting+2, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,146 :: 		UART1_Write(PWMsetting[3]);
	MOVF        _PWMsetting+3, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,148 :: 		}
L_motorLeft5:
;ROV Control.c,150 :: 		}
L_end_motorLeft:
	RETURN      0
; end of _motorLeft

_motorRight:

;ROV Control.c,152 :: 		void motorRight(char direction , char speed){
;ROV Control.c,154 :: 		if(direction == 0){
	MOVF        FARG_motorRight_direction+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_motorRight6
;ROV Control.c,156 :: 		PORTB.B0 = 0;
	BCF         PORTB+0, 0 
;ROV Control.c,157 :: 		PORTB.B1 = 1;
	BSF         PORTB+0, 1 
;ROV Control.c,159 :: 		PORTD.B4 = 0;
	BCF         PORTD+0, 4 
;ROV Control.c,160 :: 		PORTD.B2 = 1;
	BSF         PORTD+0, 2 
;ROV Control.c,163 :: 		PWMsetting[2] = speed;
	MOVF        FARG_motorRight_speed+0, 0 
	MOVWF       _PWMsetting+2 
;ROV Control.c,164 :: 		PWMsetting[3] = 0;
	CLRF        _PWMsetting+3 
;ROV Control.c,165 :: 		PWMsetting[1] = 0;
	CLRF        _PWMsetting+1 
;ROV Control.c,166 :: 		PWMsetting[0] = 0;
	CLRF        _PWMsetting+0 
;ROV Control.c,168 :: 		UART1_Write(PWMsetting[0]);
	CLRF        FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,169 :: 		UART1_Write(PWMsetting[1]);
	MOVF        _PWMsetting+1, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,170 :: 		UART1_Write(PWMsetting[2]);
	MOVF        _PWMsetting+2, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,171 :: 		UART1_Write(PWMsetting[3]);
	MOVF        _PWMsetting+3, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,173 :: 		}
L_motorRight6:
;ROV Control.c,175 :: 		}
L_end_motorRight:
	RETURN      0
; end of _motorRight

_gearMotor:

;ROV Control.c,177 :: 		void gearMotor(char direction){
;ROV Control.c,179 :: 		if(direction == 0){
	MOVF        FARG_gearMotor_direction+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_gearMotor7
;ROV Control.c,181 :: 		PORTB.B6= 0;
	BCF         PORTB+0, 6 
;ROV Control.c,182 :: 		PORTB.B7 = 1;
	BSF         PORTB+0, 7 
;ROV Control.c,184 :: 		}
L_gearMotor7:
;ROV Control.c,186 :: 		if(direction == 1){
	MOVF        FARG_gearMotor_direction+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_gearMotor8
;ROV Control.c,188 :: 		PORTB.B7= 0;
	BCF         PORTB+0, 7 
;ROV Control.c,189 :: 		PORTB.B6 = 1;
	BSF         PORTB+0, 6 
;ROV Control.c,191 :: 		}
L_gearMotor8:
;ROV Control.c,193 :: 		}
L_end_gearMotor:
	RETURN      0
; end of _gearMotor

_motorForward:

;ROV Control.c,197 :: 		void motorForward(char direction , char speed){
;ROV Control.c,199 :: 		if(direction == 1){
	MOVF        FARG_motorForward_direction+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_motorForward9
;ROV Control.c,201 :: 		PORTB.B0 = 1;
	BSF         PORTB+0, 0 
;ROV Control.c,202 :: 		PORTB.B1 = 0;
	BCF         PORTB+0, 1 
;ROV Control.c,204 :: 		PORTD.B4 = 1;
	BSF         PORTD+0, 4 
;ROV Control.c,205 :: 		PORTD.B2 = 0;
	BCF         PORTD+0, 2 
;ROV Control.c,207 :: 		PWMsetting[0] = speed;
	MOVF        FARG_motorForward_speed+0, 0 
	MOVWF       _PWMsetting+0 
;ROV Control.c,208 :: 		PWMsetting[1] = speed;
	MOVF        FARG_motorForward_speed+0, 0 
	MOVWF       _PWMsetting+1 
;ROV Control.c,209 :: 		PWMsetting[2] = 0;
	CLRF        _PWMsetting+2 
;ROV Control.c,210 :: 		PWMsetting[3] = 0;
	CLRF        _PWMsetting+3 
;ROV Control.c,212 :: 		UART1_Write(PWMsetting[0]);
	MOVF        _PWMsetting+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,213 :: 		UART1_Write(PWMsetting[1]);
	MOVF        _PWMsetting+1, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,214 :: 		UART1_Write(PWMsetting[2]);
	MOVF        _PWMsetting+2, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,215 :: 		UART1_Write(PWMsetting[3]);
	MOVF        _PWMsetting+3, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,218 :: 		}
L_motorForward9:
;ROV Control.c,220 :: 		}
L_end_motorForward:
	RETURN      0
; end of _motorForward

_motorBackward:

;ROV Control.c,223 :: 		void motorBackward(char direction , char speed){
;ROV Control.c,225 :: 		if(direction == 0){
	MOVF        FARG_motorBackward_direction+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_motorBackward10
;ROV Control.c,227 :: 		PORTB.B0 = 0;
	BCF         PORTB+0, 0 
;ROV Control.c,228 :: 		PORTB.B1 = 1;
	BSF         PORTB+0, 1 
;ROV Control.c,230 :: 		PORTD.B4 = 0;
	BCF         PORTD+0, 4 
;ROV Control.c,231 :: 		PORTD.B2 = 1;
	BSF         PORTD+0, 2 
;ROV Control.c,233 :: 		PWMsetting[0] = speed;
	MOVF        FARG_motorBackward_speed+0, 0 
	MOVWF       _PWMsetting+0 
;ROV Control.c,234 :: 		PWMsetting[1] = speed;
	MOVF        FARG_motorBackward_speed+0, 0 
	MOVWF       _PWMsetting+1 
;ROV Control.c,235 :: 		PWMsetting[2] = 0;
	CLRF        _PWMsetting+2 
;ROV Control.c,236 :: 		PWMsetting[3] = 0;
	CLRF        _PWMsetting+3 
;ROV Control.c,238 :: 		UART1_Write(PWMsetting[0]);
	MOVF        _PWMsetting+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,239 :: 		UART1_Write(PWMsetting[1]);
	MOVF        _PWMsetting+1, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,240 :: 		UART1_Write(PWMsetting[2]);
	MOVF        _PWMsetting+2, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,241 :: 		UART1_Write(PWMsetting[3]);
	MOVF        _PWMsetting+3, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ROV Control.c,243 :: 		}
L_motorBackward10:
;ROV Control.c,246 :: 		}
L_end_motorBackward:
	RETURN      0
; end of _motorBackward

_servo:

;ROV Control.c,249 :: 		void servo(char direction){
;ROV Control.c,254 :: 		}
L_end_servo:
	RETURN      0
; end of _servo

_main:

;ROV Control.c,264 :: 		void main() {
;ROV Control.c,266 :: 		ADCON1 = 0x0F;      //No Analog
	MOVLW       15
	MOVWF       ADCON1+0 
;ROV Control.c,267 :: 		CMCON  = 7;         //no Comparator
	MOVLW       7
	MOVWF       CMCON+0 
;ROV Control.c,270 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;ROV Control.c,271 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;ROV Control.c,272 :: 		PORTB = 0;
	CLRF        PORTB+0 
;ROV Control.c,273 :: 		PORTD = 0;
	CLRF        PORTD+0 
;ROV Control.c,276 :: 		PORTB.B0 = 0;
	BCF         PORTB+0, 0 
;ROV Control.c,277 :: 		PORTB.B1 = 0;
	BCF         PORTB+0, 1 
;ROV Control.c,280 :: 		PORTB.B2 = 0;
	BCF         PORTB+0, 2 
;ROV Control.c,281 :: 		PORTB.B3 = 0;
	BCF         PORTB+0, 3 
;ROV Control.c,284 :: 		PORTB.B4 = 0;
	BCF         PORTB+0, 4 
;ROV Control.c,285 :: 		PORTB.B5 = 0;
	BCF         PORTB+0, 5 
;ROV Control.c,287 :: 		PORTC.B1 = 0;
	BCF         PORTC+0, 1 
;ROV Control.c,288 :: 		PORTC.B2 = 0;
	BCF         PORTC+0, 2 
;ROV Control.c,291 :: 		PORTB.B6 = 0;
	BCF         PORTB+0, 6 
;ROV Control.c,292 :: 		PORTB.B7 = 0;
	BCF         PORTB+0, 7 
;ROV Control.c,295 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;ROV Control.c,297 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;ROV Control.c,298 :: 		Delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	DECFSZ      R11, 1, 1
	BRA         L_main11
	NOP
;ROV Control.c,301 :: 		while(1) {
L_main12:
;ROV Control.c,303 :: 		SPI_Ethernet_doPacket();
	CALL        _SPI_Ethernet_doPacket+0, 0
;ROV Control.c,307 :: 		if(recievedData[0] == 10){
	MOVF        _recievedData+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
;ROV Control.c,309 :: 		motorUp(recievedData[1] , recievedData[2]);
	MOVF        _recievedData+1, 0 
	MOVWF       FARG_motorUp_direction+0 
	MOVF        _recievedData+2, 0 
	MOVWF       FARG_motorUp_speed+0 
	CALL        _motorUp+0, 0
;ROV Control.c,311 :: 		}
L_main14:
;ROV Control.c,314 :: 		if(recievedData[0] == 20){
	MOVF        _recievedData+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
;ROV Control.c,316 :: 		motorDown(recievedData[1] , recievedData[2]);
	MOVF        _recievedData+1, 0 
	MOVWF       FARG_motorDown_direction+0 
	MOVF        _recievedData+2, 0 
	MOVWF       FARG_motorDown_speed+0 
	CALL        _motorDown+0, 0
;ROV Control.c,318 :: 		}
L_main15:
;ROV Control.c,321 :: 		if(recievedData[0] == 30) {
	MOVF        _recievedData+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;ROV Control.c,323 :: 		motorLeft(recievedData[1] , recievedData[2]);
	MOVF        _recievedData+1, 0 
	MOVWF       FARG_motorLeft_direction+0 
	MOVF        _recievedData+2, 0 
	MOVWF       FARG_motorLeft_speed+0 
	CALL        _motorLeft+0, 0
;ROV Control.c,325 :: 		}
L_main16:
;ROV Control.c,328 :: 		if(recievedData[0] == 40){
	MOVF        _recievedData+0, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
;ROV Control.c,330 :: 		motorRight(recievedData[1] , recievedData[2]);
	MOVF        _recievedData+1, 0 
	MOVWF       FARG_motorRight_direction+0 
	MOVF        _recievedData+2, 0 
	MOVWF       FARG_motorRight_speed+0 
	CALL        _motorRight+0, 0
;ROV Control.c,332 :: 		}
L_main17:
;ROV Control.c,335 :: 		if(recievedData[0] == 50) {
	MOVF        _recievedData+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;ROV Control.c,337 :: 		gearMotor(recievedData[1]);
	MOVF        _recievedData+1, 0 
	MOVWF       FARG_gearMotor_direction+0 
	CALL        _gearMotor+0, 0
;ROV Control.c,339 :: 		}
L_main18:
;ROV Control.c,342 :: 		if(recievedData[0] == 60){
	MOVF        _recievedData+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
;ROV Control.c,344 :: 		servo(recievedData[1]);
	MOVF        _recievedData+1, 0 
	MOVWF       FARG_servo_direction+0 
	CALL        _servo+0, 0
;ROV Control.c,346 :: 		}
L_main19:
;ROV Control.c,348 :: 		if(recievedData[0] == 70){
	MOVF        _recievedData+0, 0 
	XORLW       70
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
;ROV Control.c,350 :: 		motorForward(recievedData[1], recievedData[2]);
	MOVF        _recievedData+1, 0 
	MOVWF       FARG_motorForward_direction+0 
	MOVF        _recievedData+2, 0 
	MOVWF       FARG_motorForward_speed+0 
	CALL        _motorForward+0, 0
;ROV Control.c,353 :: 		}
L_main20:
;ROV Control.c,355 :: 		if(recievedData[0] == 80){
	MOVF        _recievedData+0, 0 
	XORLW       80
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
;ROV Control.c,357 :: 		motorBackward(recievedData[1], recievedData[2]);
	MOVF        _recievedData+1, 0 
	MOVWF       FARG_motorBackward_direction+0 
	MOVF        _recievedData+2, 0 
	MOVWF       FARG_motorBackward_speed+0 
	CALL        _motorBackward+0, 0
;ROV Control.c,360 :: 		}
L_main21:
;ROV Control.c,362 :: 		}
	GOTO        L_main12
;ROV Control.c,366 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
