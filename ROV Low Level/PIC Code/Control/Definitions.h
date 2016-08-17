/*
--------------------- MOTORS DEFINITIONS ---------------------
*/

#define   LEFT        RB7_bit
#define   RIGHT       RB6_bit
#define   VERTICAL    RB5_bit
#define   GRIP        RB4_bit
#define   REVERSE     RB3_bit
#define   FORWARD     RB2_bit
#define   ARM         RB1_bit

/*
--------------------- SENSORS DEFINITIONS ---------------------
*/

#define   PRESSURE    RA0_bit
#define   TEMPERATURE RA1_bit

/*
-------------------- Variables Declarations --------------------
*/

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