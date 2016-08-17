
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,12 :: 		void Interrupt(){
;MyProject.c,13 :: 		if(INTF_bit){    //External Interrupt occurred
	BTFSS      INTF_bit+0, 1
	GOTO       L_Interrupt0
;MyProject.c,14 :: 		INTCON = 0;      //Disable all interrupts
	CLRF       INTCON+0
;MyProject.c,15 :: 		PORTB.F2 = 0;
	BCF        PORTB+0, 2
;MyProject.c,16 :: 		PORTD = 0;
	CLRF       PORTD+0
;MyProject.c,17 :: 		PWM1_Stop();
	CALL       _PWM1_Stop+0
;MyProject.c,18 :: 		}
L_Interrupt0:
;MyProject.c,19 :: 		if (TMR1IF_bit){        //Timer1 Interrupt occurred
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_Interrupt1
;MyProject.c,20 :: 		TMR1IF_bit = 0;
	BCF        TMR1IF_bit+0, 0
;MyProject.c,21 :: 		TMR1H         = 0x6D;
	MOVLW      109
	MOVWF      TMR1H+0
;MyProject.c,22 :: 		TMR1L         = 0x84;
	MOVLW      132
	MOVWF      TMR1L+0
;MyProject.c,23 :: 		dt = ADC_Read(0);   //Read analog value
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _dt+0
	MOVF       R0+1, 0
	MOVWF      _dt+1
;MyProject.c,24 :: 		if (dt != dt0) {
	MOVF       R0+1, 0
	XORWF      _dt0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt12
	MOVF       _dt0+0, 0
	XORWF      R0+0, 0
L__Interrupt12:
	BTFSC      STATUS+0, 2
	GOTO       L_Interrupt2
;MyProject.c,25 :: 		dt0 = dt;
	MOVF       _dt+0, 0
	MOVWF      _dt0+0
	MOVF       _dt+1, 0
	MOVWF      _dt0+1
;MyProject.c,26 :: 		dt0 = dt0 >> 2;
	MOVF       _dt+0, 0
	MOVWF      R0+0
	MOVF       _dt+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      _dt0+0
	MOVF       R0+1, 0
	MOVWF      _dt0+1
;MyProject.c,27 :: 		PWM1_Set_Duty(dt0);
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,28 :: 		PWM1_Start(); }
	CALL       _PWM1_Start+0
L_Interrupt2:
;MyProject.c,29 :: 		}
L_Interrupt1:
;MyProject.c,30 :: 		if (RBIF_bit){      //Pin change Interrupt occurred
	BTFSS      RBIF_bit+0, 0
	GOTO       L_Interrupt3
;MyProject.c,31 :: 		RBIF_bit = 0;
	BCF        RBIF_bit+0, 0
;MyProject.c,32 :: 		hall = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _hall+0
;MyProject.c,33 :: 		hall = hall & 112;
	MOVLW      112
	ANDWF      _hall+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      _hall+0
;MyProject.c,34 :: 		hall = hall >> 4;
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	MOVWF      _hall+0
;MyProject.c,35 :: 		PORTD = MoveTable[hall];
	MOVF       R0+0, 0
	ADDLW      _MoveTable+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,36 :: 		}
L_Interrupt3:
;MyProject.c,37 :: 		}
L_end_Interrupt:
L__Interrupt11:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_InitInterrupts:

;MyProject.c,38 :: 		void InitInterrupts(){
;MyProject.c,39 :: 		OPTION_REG = 0;
	CLRF       OPTION_REG+0
;MyProject.c,40 :: 		T1CON         = 0x31;
	MOVLW      49
	MOVWF      T1CON+0
;MyProject.c,41 :: 		TMR1IF_bit    = 0;
	BCF        TMR1IF_bit+0, 0
;MyProject.c,42 :: 		TMR1H         = 0x6D;
	MOVLW      109
	MOVWF      TMR1H+0
;MyProject.c,43 :: 		TMR1L         = 0x84;
	MOVLW      132
	MOVWF      TMR1L+0
;MyProject.c,44 :: 		TMR1IE_bit    = 1;
	BSF        TMR1IE_bit+0, 0
;MyProject.c,45 :: 		INTCON        = 0;     //Disable all interrupts
	CLRF       INTCON+0
;MyProject.c,46 :: 		}
L_end_InitInterrupts:
	RETURN
; end of _InitInterrupts

_main:

;MyProject.c,47 :: 		void main() {
;MyProject.c,48 :: 		ADCON1 = 14;                // Configure AN0 as analog
	MOVLW      14
	MOVWF      ADCON1+0
;MyProject.c,49 :: 		CMCON  = 7;                //Disable comparators
	MOVLW      7
	MOVWF      CMCON+0
;MyProject.c,50 :: 		PORTB = 0;
	CLRF       PORTB+0
;MyProject.c,51 :: 		TRISB = 243;
	MOVLW      243
	MOVWF      TRISB+0
;MyProject.c,52 :: 		PORTD = 0;
	CLRF       PORTD+0
;MyProject.c,53 :: 		TRISD = 0;
	CLRF       TRISD+0
;MyProject.c,54 :: 		InitInterrupts();
	CALL       _InitInterrupts+0
;MyProject.c,55 :: 		PWM1_Init(10000);
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      74
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;MyProject.c,57 :: 		while(1){
L_main4:
;MyProject.c,58 :: 		while(PORTB.F1);   //wait for start key hit
L_main6:
	BTFSS      PORTB+0, 1
	GOTO       L_main7
	GOTO       L_main6
L_main7:
;MyProject.c,59 :: 		while(!PORTB.F1);  // wait till key is released
L_main8:
	BTFSC      PORTB+0, 1
	GOTO       L_main9
	GOTO       L_main8
L_main9:
;MyProject.c,60 :: 		PORTB.F2 = 1;
	BSF        PORTB+0, 2
;MyProject.c,61 :: 		hall = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _hall+0
;MyProject.c,62 :: 		hall = hall & 112;
	MOVLW      112
	ANDWF      _hall+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      _hall+0
;MyProject.c,63 :: 		hall = hall >> 4;
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	MOVWF      _hall+0
;MyProject.c,64 :: 		PORTD = MoveTable[hall];
	MOVF       R0+0, 0
	ADDLW      _MoveTable+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,65 :: 		INTCON        = 0xD8;   //Enable all interrupts
	MOVLW      216
	MOVWF      INTCON+0
;MyProject.c,66 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;MyProject.c,67 :: 		}
	GOTO       L_main4
;MyProject.c,68 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
