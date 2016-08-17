#line 1 "D:/Projects/ROV 2016/Codes/Control/UART-ETHERNET.c"
#line 1 "d:/projects/rov 2016/codes/control/definitions.h"
#line 24 "d:/projects/rov 2016/codes/control/definitions.h"
bit L_HIGH;
bit R_HIGH;
bit VER_HIGH;
bit G_HIGH;
bit A_HIGH;

char Received_Data [] = {0, 0, 0, 0, 0};

int Low_Time = 1000;
int Low_Time_L = 0;
int Low_Time_R = 0;
int Low_Time_VER = 0;

char DUTY_L = 0;
char DUTY_R = 0;
char DUTY_VER = 0;

char Freq = 125;
char DUTY_G = 0;
char DUTY_A = 0;

char Temp;
char Depth;
#line 4 "D:/Projects/ROV 2016/Codes/Control/UART-ETHERNET.c"
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
  RB7_bit  = 1;
  RB6_bit  = 1;
  RB5_bit  = 1;
 delay_us(1500);
  RB7_bit  = 0;
  RB6_bit  = 0;
  RB5_bit  = 0;
 delay_ms(20);
 }
}

void Motors_Signal()
{
 if(Low_Time_L == Low_Time) { L_HIGH = 1;  RB7_bit  = 1; }
 if(Low_Time_R == Low_Time) { R_HIGH = 1;  RB6_bit  = 1; }
 if(Low_Time_VER == Low_Time) { VER_HIGH = 1;  RB5_bit  = 1; }

 if(DUTY_L == Received_Data[0]) { L_HIGH = 0;  RB7_bit  = 0; }
 if(DUTY_R == Received_Data[1]) { R_HIGH = 0;  RB6_bit  = 0; }
 if(DUTY_VER == Received_Data[2]) { VER_HIGH = 0;  RB5_bit  = 0; }
}

void InitTimer0()
{
 T0CON = 0xC8;
 TMR0L = 0x10;
 GIE_bit = 1;
 TMR0IE_bit = 1;
}

void Init()
{
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
