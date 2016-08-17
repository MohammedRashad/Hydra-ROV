//Sensored BLDC Motor Control Using PIC16F877A
//Used microcontrooler: PIC16F877A @ 12MHz
//Written by: BENCHEROUDA Okba
//http://www.elecnote.blogspot.com
//electronnote@gmail.com
//All rights reserved
//Use at your own risk

unsigned short hall;
unsigned char MoveTable[8] = {0, 33, 6, 36, 24, 9, 18, 0};
unsigned   dt, dt0;

void Interrupt(){

  if(INTF_bit){    //External Interrupt occurred
  INTCON = 0;      //Disable all interrupts
  PORTB.F2 = 0;
  PORTD = 0;
  PWM1_Stop();
  }

  if (TMR1IF_bit){        //Timer1 Interrupt occurred
    TMR1IF_bit = 0;
    TMR1H         = 0x6D;
    TMR1L         = 0x84;
  dt = ADC_Read(0);   //Read analog value

  if (dt != dt0) {
  dt0 = dt;
  dt0 = dt0 >> 2;
  PWM1_Set_Duty(dt0);
  PWM1_Start(); 

  }

 }


  if (RBIF_bit){      //Pin change Interrupt occurred

  RBIF_bit = 0;
  hall = PORTB;
  hall = hall & 112;
  hall = hall >> 4;
  PORTD = MoveTable[hall];

  }
}


void InitInterrupts(){
  OPTION_REG = 0;
  T1CON         = 0x31;
  TMR1IF_bit    = 0;
  TMR1H         = 0x6D;
  TMR1L         = 0x84;
  TMR1IE_bit    = 1;
  INTCON        = 0;     //Disable all interrupts
}



void main() {
 ADCON1 = 14;                // Configure AN0 as analog
 CMCON  = 7;                //Disable comparators
 PORTB = 0; 
 TRISB = 243;
 PORTD = 0;
 TRISD = 0;
 InitInterrupts();
 PWM1_Init(10000);

 while(1){
  while(PORTB.F1);   //wait for start key hit
  while(!PORTB.F1);  // wait till key is released
  PORTB.F2 = 1;
  hall = PORTB;
  hall = hall & 112;
  hall = hall >> 4;
  PORTD = MoveTable[hall];
  INTCON        = 0xD8;   //Enable all interrupts
  PWM1_Start();
 }
}
