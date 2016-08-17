#line 1 "C:/Documents and Settings/Okba/Desktop/PIC/12C508/MyProject.c"








unsigned short hall;
unsigned char MoveTable[8] = {0, 33, 6, 36, 24, 9, 18, 0};
unsigned dt, dt0;
void Interrupt(){
 if(INTF_bit){
 INTCON = 0;
 PORTB.F2 = 0;
 PORTD = 0;
 PWM1_Stop();
 }
 if (TMR1IF_bit){
 TMR1IF_bit = 0;
 TMR1H = 0x6D;
 TMR1L = 0x84;
 dt = ADC_Read(0);
 if (dt != dt0) {
 dt0 = dt;
 dt0 = dt0 >> 2;
 PWM1_Set_Duty(dt0);
 PWM1_Start(); }
 }
 if (RBIF_bit){
 RBIF_bit = 0;
 hall = PORTB;
 hall = hall & 112;
 hall = hall >> 4;
 PORTD = MoveTable[hall];
 }
}
void InitInterrupts(){
 OPTION_REG = 0;
 T1CON = 0x31;
 TMR1IF_bit = 0;
 TMR1H = 0x6D;
 TMR1L = 0x84;
 TMR1IE_bit = 1;
 INTCON = 0;
}
void main() {
 ADCON1 = 14;
 CMCON = 7;
 PORTB = 0;
 TRISB = 243;
 PORTD = 0;
 TRISD = 0;
 InitInterrupts();
 PWM1_Init(10000);

 while(1){
 while(PORTB.F1);
 while(!PORTB.F1);
 PORTB.F2 = 1;
 hall = PORTB;
 hall = hall & 112;
 hall = hall >> 4;
 PORTD = MoveTable[hall];
 INTCON = 0xD8;
 PWM1_Start();
 }
}
