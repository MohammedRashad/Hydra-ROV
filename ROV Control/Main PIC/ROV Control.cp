#line 1 "C:/users/rashad/My Documents/ROV Control.c"
#line 26 "C:/users/rashad/My Documents/ROV Control.c"
sfr sbit SPI_Ethernet_Rst at RC0_bit;
sfr sbit SPI_Ethernet_CS at RC1_bit;
sfr sbit SPI_Ethernet_Rst_Direction at TRISC0_bit;
sfr sbit SPI_Ethernet_CS_Direction at TRISC1_bit;


unsigned char myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f};
unsigned char myIpAddr[4] = { 192 , 168 , 1 , 20 };
unsigned char recievedData[3] = {0 , 0 , 0};
char PWMsetting[4] = {0,0,0,0};



typedef struct {

 unsigned canCloseTCP: 1;
 unsigned isBroadcast: 1;

} TEthPktFlags;



unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags) {
 return 0;
}





unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags) {



 if (destPort != 9876) {

 return 0;
 }


 while( reqLength-- ){

 recievedData[reqLength - 1] = SPI_Ethernet_getByte();

 }

 return 0;

}


void motorUp(char direction , char speed){



 if(direction == 1){

 PORTB.B5 = 1;
 PORTB.B4 = 0;

 PORTD.B7 = 1;
 PORTB.B7 = 0;

 }

 PWMsetting[0] = speed;
 PWMsetting[1] = speed;
 PWMsetting[2] = 0;
 PWMsetting[3] = 0;

 UART1_Write(PWMsetting[0]);
 UART1_Write(PWMsetting[1]);
 UART1_Write(PWMsetting[2]);
 UART1_Write(PWMsetting[3]);

}


void motorDown(char direction , char speed){

 if(direction == 0){

 PORTB.B5 = 0;
 PORTB.B4 = 1;

 PORTD.B7 = 0;
 PORTB.B7 = 1;


 PWMsetting[0] = speed;
 PWMsetting[1] = speed;
 PWMsetting[2] = 0;
 PWMsetting[3] = 0;

 UART1_Write(PWMsetting[0]);
 UART1_Write(PWMsetting[1]);
 UART1_Write(PWMsetting[2]);
 UART1_Write(PWMsetting[3]);

 }
}

void motorLeft(char direction , char speed){

 if(direction == 1){

 PORTB.B0 = 1;
 PORTB.B1 = 0;

 PORTD.B4 = 1;
 PORTD.B2 = 0;

 PWMsetting[2] = 0;
 PWMsetting[3] = speed;
 PWMsetting[1] = 0;
 PWMsetting[0] = 0;

 UART1_Write(PWMsetting[0]);
 UART1_Write(PWMsetting[1]);
 UART1_Write(PWMsetting[2]);
 UART1_Write(PWMsetting[3]);

 }

}

void motorRight(char direction , char speed){

 if(direction == 0){

 PORTB.B0 = 0;
 PORTB.B1 = 1;

 PORTD.B4 = 0;
 PORTD.B2 = 1;


 PWMsetting[2] = speed;
 PWMsetting[3] = 0;
 PWMsetting[1] = 0;
 PWMsetting[0] = 0;

 UART1_Write(PWMsetting[0]);
 UART1_Write(PWMsetting[1]);
 UART1_Write(PWMsetting[2]);
 UART1_Write(PWMsetting[3]);

 }

}

void gearMotor(char direction){

 if(direction == 0){

 PORTB.B6= 0;
 PORTB.B7 = 1;

 }

 if(direction == 1){

 PORTB.B7= 0;
 PORTB.B6 = 1;

 }

}



 void motorForward(char direction , char speed){

 if(direction == 1){

 PORTB.B0 = 1;
 PORTB.B1 = 0;

 PORTD.B4 = 1;
 PORTD.B2 = 0;

 PWMsetting[0] = speed;
 PWMsetting[1] = speed;
 PWMsetting[2] = 0;
 PWMsetting[3] = 0;

 UART1_Write(PWMsetting[0]);
 UART1_Write(PWMsetting[1]);
 UART1_Write(PWMsetting[2]);
 UART1_Write(PWMsetting[3]);


 }

 }


 void motorBackward(char direction , char speed){

 if(direction == 0){

 PORTB.B0 = 0;
 PORTB.B1 = 1;

 PORTD.B4 = 0;
 PORTD.B2 = 1;

 PWMsetting[0] = speed;
 PWMsetting[1] = speed;
 PWMsetting[2] = 0;
 PWMsetting[3] = 0;

 UART1_Write(PWMsetting[0]);
 UART1_Write(PWMsetting[1]);
 UART1_Write(PWMsetting[2]);
 UART1_Write(PWMsetting[3]);

 }


 }


void servo(char direction){




}









void main() {

 ADCON1 = 0x0F;
 CMCON = 7;


 TRISB = 0x00;
 TRISD = 0x00;
 PORTB = 0;
 PORTD = 0;


 PORTB.B0 = 0;
 PORTB.B1 = 0;


 PORTB.B2 = 0;
 PORTB.B3 = 0;


 PORTB.B4 = 0;
 PORTB.B5 = 0;

 PORTC.B1 = 0;
 PORTC.B2 = 0;


 PORTB.B6 = 0;
 PORTB.B7 = 0;


 PORTC.B0 = 0;

 UART1_Init(9600);
 Delay_ms(100);


 while(1) {

 SPI_Ethernet_doPacket();



 if(recievedData[0] == 10){

 motorUp(recievedData[1] , recievedData[2]);

 }


 if(recievedData[0] == 20){

 motorDown(recievedData[1] , recievedData[2]);

 }


 if(recievedData[0] == 30) {

 motorLeft(recievedData[1] , recievedData[2]);

 }


 if(recievedData[0] == 40){

 motorRight(recievedData[1] , recievedData[2]);

 }


 if(recievedData[0] == 50) {

 gearMotor(recievedData[1]);

 }


 if(recievedData[0] == 60){

 servo(recievedData[1]);

 }

 if(recievedData[0] == 70){

 motorForward(recievedData[1], recievedData[2]);


 }

 if(recievedData[0] == 80){

 motorBackward(recievedData[1], recievedData[2]);


 }

 }



}
