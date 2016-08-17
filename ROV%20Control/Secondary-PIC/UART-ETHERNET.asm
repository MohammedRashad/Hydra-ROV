
_interrupt:

;UART-ETHERNET.c,4 :: 		void interrupt()
;UART-ETHERNET.c,6 :: 		TMR0IE_bit = 0;
	BCF         TMR0IE_bit+0, 5 
;UART-ETHERNET.c,7 :: 		if (TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;UART-ETHERNET.c,9 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, 2 
;UART-ETHERNET.c,10 :: 		if(Low_Time_L < Low_Time) Low_Time_L++;
	MOVLW       128
	XORWF       _Low_Time_L+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Low_Time+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt22
	MOVF        _Low_Time+0, 0 
	SUBWF       _Low_Time_L+0, 0 
L__interrupt22:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
	INFSNZ      _Low_Time_L+0, 1 
	INCF        _Low_Time_L+1, 1 
L_interrupt1:
;UART-ETHERNET.c,11 :: 		if(Low_Time_R < Low_Time) Low_Time_R++;
	MOVLW       128
	XORWF       _Low_Time_R+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Low_Time+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt23
	MOVF        _Low_Time+0, 0 
	SUBWF       _Low_Time_R+0, 0 
L__interrupt23:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt2
	INFSNZ      _Low_Time_R+0, 1 
	INCF        _Low_Time_R+1, 1 
L_interrupt2:
;UART-ETHERNET.c,12 :: 		if(Low_Time_VER < Low_Time) Low_Time_VER++;
	MOVLW       128
	XORWF       _Low_Time_VER+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Low_Time+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt24
	MOVF        _Low_Time+0, 0 
	SUBWF       _Low_Time_VER+0, 0 
L__interrupt24:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt3
	INFSNZ      _Low_Time_VER+0, 1 
	INCF        _Low_Time_VER+1, 1 
L_interrupt3:
;UART-ETHERNET.c,14 :: 		if(L_HIGH) DUTY_L++;
	BTFSS       _L_HIGH+0, BitPos(_L_HIGH+0) 
	GOTO        L_interrupt4
	INCF        _DUTY_L+0, 1 
L_interrupt4:
;UART-ETHERNET.c,15 :: 		if(R_HIGH) DUTY_R++;
	BTFSS       _R_HIGH+0, BitPos(_R_HIGH+0) 
	GOTO        L_interrupt5
	INCF        _DUTY_R+0, 1 
L_interrupt5:
;UART-ETHERNET.c,16 :: 		if(VER_HIGH) DUTY_VER++;
	BTFSS       _VER_HIGH+0, BitPos(_VER_HIGH+0) 
	GOTO        L_interrupt6
	INCF        _DUTY_VER+0, 1 
L_interrupt6:
;UART-ETHERNET.c,19 :: 		DUTY_G++;
	INCF        _DUTY_G+0, 1 
;UART-ETHERNET.c,20 :: 		DUTY_A++;
	INCF        _DUTY_A+0, 1 
;UART-ETHERNET.c,22 :: 		}
L_interrupt0:
;UART-ETHERNET.c,23 :: 		TMR0L = 0x10;
	MOVLW       16
	MOVWF       TMR0L+0 
;UART-ETHERNET.c,24 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, 5 
;UART-ETHERNET.c,25 :: 		}
L__interrupt21:
	RETFIE      1
; end of _interrupt

_Init_Motors:

;UART-ETHERNET.c,27 :: 		void Init_Motors()
;UART-ETHERNET.c,29 :: 		char cnt = 0;
	CLRF        Init_Motors_cnt_L0+0 
;UART-ETHERNET.c,30 :: 		for(cnt = 0; cnt<210; cnt++)
	CLRF        Init_Motors_cnt_L0+0 
L_Init_Motors7:
	MOVLW       210
	SUBWF       Init_Motors_cnt_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Init_Motors8
;UART-ETHERNET.c,32 :: 		LEFT = 1;
	BSF         RB7_bit+0, 7 
;UART-ETHERNET.c,33 :: 		RIGHT = 1;
	BSF         RB6_bit+0, 6 
;UART-ETHERNET.c,34 :: 		VERTICAL = 1;
	BSF         RB5_bit+0, 5 
;UART-ETHERNET.c,35 :: 		delay_us(1500);
	MOVLW       24
	MOVWF       R12, 0
	MOVLW       95
	MOVWF       R13, 0
L_Init_Motors10:
	DECFSZ      R13, 1, 0
	BRA         L_Init_Motors10
	DECFSZ      R12, 1, 0
	BRA         L_Init_Motors10
;UART-ETHERNET.c,36 :: 		LEFT = 0;
	BCF         RB7_bit+0, 7 
;UART-ETHERNET.c,37 :: 		RIGHT = 0;
	BCF         RB6_bit+0, 6 
;UART-ETHERNET.c,38 :: 		VERTICAL = 0;
	BCF         RB5_bit+0, 5 
;UART-ETHERNET.c,39 :: 		delay_ms(20);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       56
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Init_Motors11:
	DECFSZ      R13, 1, 0
	BRA         L_Init_Motors11
	DECFSZ      R12, 1, 0
	BRA         L_Init_Motors11
	DECFSZ      R11, 1, 0
	BRA         L_Init_Motors11
;UART-ETHERNET.c,30 :: 		for(cnt = 0; cnt<210; cnt++)
	INCF        Init_Motors_cnt_L0+0, 1 
;UART-ETHERNET.c,40 :: 		}
	GOTO        L_Init_Motors7
L_Init_Motors8:
;UART-ETHERNET.c,41 :: 		}
	RETURN      0
; end of _Init_Motors

_Motors_Signal:

;UART-ETHERNET.c,43 :: 		void Motors_Signal()
;UART-ETHERNET.c,45 :: 		if(Low_Time_L == Low_Time)   { L_HIGH = 1;      LEFT = 1; }
	MOVF        _Low_Time_L+1, 0 
	XORWF       _Low_Time+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Motors_Signal25
	MOVF        _Low_Time+0, 0 
	XORWF       _Low_Time_L+0, 0 
L__Motors_Signal25:
	BTFSS       STATUS+0, 2 
	GOTO        L_Motors_Signal12
	BSF         _L_HIGH+0, BitPos(_L_HIGH+0) 
	BSF         RB7_bit+0, 7 
L_Motors_Signal12:
;UART-ETHERNET.c,46 :: 		if(Low_Time_R == Low_Time)   { R_HIGH = 1;      RIGHT = 1; }
	MOVF        _Low_Time_R+1, 0 
	XORWF       _Low_Time+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Motors_Signal26
	MOVF        _Low_Time+0, 0 
	XORWF       _Low_Time_R+0, 0 
L__Motors_Signal26:
	BTFSS       STATUS+0, 2 
	GOTO        L_Motors_Signal13
	BSF         _R_HIGH+0, BitPos(_R_HIGH+0) 
	BSF         RB6_bit+0, 6 
L_Motors_Signal13:
;UART-ETHERNET.c,47 :: 		if(Low_Time_VER == Low_Time) { VER_HIGH = 1;    VERTICAL = 1; }
	MOVF        _Low_Time_VER+1, 0 
	XORWF       _Low_Time+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Motors_Signal27
	MOVF        _Low_Time+0, 0 
	XORWF       _Low_Time_VER+0, 0 
L__Motors_Signal27:
	BTFSS       STATUS+0, 2 
	GOTO        L_Motors_Signal14
	BSF         _VER_HIGH+0, BitPos(_VER_HIGH+0) 
	BSF         RB5_bit+0, 5 
L_Motors_Signal14:
;UART-ETHERNET.c,49 :: 		if(DUTY_L == Received_Data[0])  { L_HIGH = 0;   LEFT = 0; }
	MOVF        _DUTY_L+0, 0 
	XORWF       _Received_Data+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Motors_Signal15
	BCF         _L_HIGH+0, BitPos(_L_HIGH+0) 
	BCF         RB7_bit+0, 7 
L_Motors_Signal15:
;UART-ETHERNET.c,50 :: 		if(DUTY_R == Received_Data[1])   { R_HIGH = 0;   RIGHT = 0; }
	MOVF        _DUTY_R+0, 0 
	XORWF       _Received_Data+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Motors_Signal16
	BCF         _R_HIGH+0, BitPos(_R_HIGH+0) 
	BCF         RB6_bit+0, 6 
L_Motors_Signal16:
;UART-ETHERNET.c,51 :: 		if(DUTY_VER == Received_Data[2]) { VER_HIGH = 0; VERTICAL = 0; }
	MOVF        _DUTY_VER+0, 0 
	XORWF       _Received_Data+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Motors_Signal17
	BCF         _VER_HIGH+0, BitPos(_VER_HIGH+0) 
	BCF         RB5_bit+0, 5 
L_Motors_Signal17:
;UART-ETHERNET.c,52 :: 		}
	RETURN      0
; end of _Motors_Signal

_InitTimer0:

;UART-ETHERNET.c,54 :: 		void InitTimer0()
;UART-ETHERNET.c,56 :: 		T0CON = 0xC8;
	MOVLW       200
	MOVWF       T0CON+0 
;UART-ETHERNET.c,57 :: 		TMR0L = 0x10;
	MOVLW       16
	MOVWF       TMR0L+0 
;UART-ETHERNET.c,58 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, 7 
;UART-ETHERNET.c,59 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, 5 
;UART-ETHERNET.c,60 :: 		}
	RETURN      0
; end of _InitTimer0

_Init:

;UART-ETHERNET.c,62 :: 		void Init()
;UART-ETHERNET.c,64 :: 		ADCON1 = 0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;UART-ETHERNET.c,65 :: 		CMCON = 7;
	MOVLW       7
	MOVWF       CMCON+0 
;UART-ETHERNET.c,66 :: 		TRISB = 0;
	CLRF        TRISB+0 
;UART-ETHERNET.c,67 :: 		PORTB = 0;
	CLRF        PORTB+0 
;UART-ETHERNET.c,69 :: 		UART1_Init(9600);
	MOVLW       77
	MOVWF       SPBRG+0 
	BCF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;UART-ETHERNET.c,70 :: 		Delay_100ms();
	CALL        _Delay_100ms+0, 0
;UART-ETHERNET.c,72 :: 		Init_Motors();
	CALL        _Init_Motors+0, 0
;UART-ETHERNET.c,73 :: 		Delay_ms(2000);
	MOVLW       122
	MOVWF       R11, 0
	MOVLW       193
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_Init18:
	DECFSZ      R13, 1, 0
	BRA         L_Init18
	DECFSZ      R12, 1, 0
	BRA         L_Init18
	DECFSZ      R11, 1, 0
	BRA         L_Init18
	NOP
	NOP
;UART-ETHERNET.c,76 :: 		}
	RETURN      0
; end of _Init

_main:

;UART-ETHERNET.c,78 :: 		void main()
;UART-ETHERNET.c,80 :: 		Init();
	CALL        _Init+0, 0
;UART-ETHERNET.c,81 :: 		while(1)
L_main19:
;UART-ETHERNET.c,83 :: 		Motors_Signal();
	CALL        _Motors_Signal+0, 0
;UART-ETHERNET.c,84 :: 		}
	GOTO        L_main19
;UART-ETHERNET.c,85 :: 		}
	GOTO        $+0
; end of _main
