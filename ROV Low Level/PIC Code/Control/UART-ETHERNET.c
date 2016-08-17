#include <Definitions.h>


void interrupt()
{
 TMR0IE_bit = 0;
 if (TMR0IF_bit)
 {
  TMR0IF_bit = 0;
  if(Low_Time_L < Low_Time) Low_Time_L++;
  if(Low_Time_R < Low_Time) Low_Time_R++;
  if(Low_Time_VER < Low_Time) Low_Time_VER++;
  
  if(L_HIGH) DUTY_L++;
  if(R_HIGH) DUTY_R++;
  if(VER_HIGH) DUTY_VER++;


  DUTY_G++;
  DUTY_A++;
 
 }
 TMR0L = 0x10;
 TMR0IE_bit = 1;
}

void Init_Motors()
{
 char cnt = 0;
 for(cnt = 0; cnt<210; cnt++)
 {
  LEFT = 1;
  RIGHT = 1;
  VERTICAL = 1;
  delay_us(1500);
  LEFT = 0;
  RIGHT = 0;
  VERTICAL = 0;
  delay_ms(20);
 }
}

void Motors_Signal()
{
 if(Low_Time_L == Low_Time)   { L_HIGH = 1;      LEFT = 1; }
 if(Low_Time_R == Low_Time)   { R_HIGH = 1;      RIGHT = 1; }
 if(Low_Time_VER == Low_Time) { VER_HIGH = 1;    VERTICAL = 1; }

 if(DUTY_L == Received_Data[0])  { L_HIGH = 0;   LEFT = 0; }
 if(DUTY_R == Received_Data[1])   { R_HIGH = 0;   RIGHT = 0; }
 if(DUTY_VER == Received_Data[2]) { VER_HIGH = 0; VERTICAL = 0; }
}

void InitTimer0() {
 T0CON = 0xC8;
 TMR0L = 0x10;
 GIE_bit = 1;
 TMR0IE_bit = 1;
}

void Init() {
 ADCON1 = 0x0E;
 CMCON = 7;
 TRISB = 0;
 PORTB = 0;
 
 UART1_Init(9600);
 Delay_100ms();

 Init_Motors();
 Delay_ms(2000);
 
 
}

void main()
{
 Init();
 while(1)
 {
  Motors_Signal();
 }
}
