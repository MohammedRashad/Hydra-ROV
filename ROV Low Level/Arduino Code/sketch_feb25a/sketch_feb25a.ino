
#include <Servo.h>
#include <OneWire.h>

OneWire ds(10);
Servo esc1 , esc2 , esc3;

String Str;
int16_t raw;
float celsius , fahrenheit , depth , voltage;
byte cfg , i , type_s , data[12] , addr[8], present = 0;
int raw0 , speed0 = 0 , x = 220 , minPulseRate = 1100 , maxPulseRate = 1900 , y = 1700 , z = 1300;


void setup() {

  Serial.begin(115200);
  Serial.setTimeout(50);

  pinMode(6, OUTPUT); //arm1
  pinMode(5, OUTPUT); //arm1
  pinMode(8, OUTPUT); //arm2
  pinMode(9, OUTPUT); //arm2
  pinMode(52 , OUTPUT);
  esc1.attach(2, minPulseRate, maxPulseRate);
  esc2.attach(3, minPulseRate, maxPulseRate);
  esc3.attach(4, minPulseRate, maxPulseRate);


}

void loop() {

  if (Serial.available() > 0) {

    Str = Serial.readString();

    if (Str == "d") {

      esc1.writeMicroseconds(1600);
      Serial.print(Str);

    } else if (Str == "u" ) {

//      esc1.writeMicroseconds(1400);
      Serial.print(Str);

    } else if (Str == "l" ) {

      esc3.writeMicroseconds(1700);
      esc2.writeMicroseconds(1300);
      Serial.print(Str);

    } else if (Str == "r" ) {

      esc2.writeMicroseconds(1700);
      esc3.writeMicroseconds(1300);
      Serial.print(Str);

    } else if (Str == "b") {

      esc3.writeMicroseconds(1100);
      esc2.writeMicroseconds(1100);
      Serial.print(Str);
      esc3.write(50);
      esc2.write(50);

    } else if (Str == "f") {

      esc2.writeMicroseconds(1600);
      esc3.writeMicroseconds(1600);
      Serial.print(Str);

    } else if (Str == "v") {

      Serial.print(Str);
      digitalWrite(6, LOW);
      digitalWrite(5, HIGH);

      delay(140);

      digitalWrite(6, LOW);
      digitalWrite(5, LOW);

    } else if (Str == "m") {

      Serial.print(Str);
      digitalWrite(6, HIGH);
      digitalWrite(5, LOW);

      delay(140);

      digitalWrite(6, LOW);
      digitalWrite(5, LOW);

    } else if (Str == "c" ) {

      Serial.print(Str);
      digitalWrite(9, HIGH);
      digitalWrite(8, LOW);

      delay(1000);

      digitalWrite(8, LOW);
      digitalWrite(9, LOW);

    } else if (Str == "o") {

      Serial.print(Str);
      digitalWrite(8, HIGH);
      digitalWrite(9, LOW);

      delay(1000);

      digitalWrite(8, LOW);
      digitalWrite(9, LOW);

      Serial.print(Str);

    } else if (Str == "s") {

      digitalWrite(8, LOW);
      digitalWrite(9, LOW);
      digitalWrite(5, LOW);
      digitalWrite(6, LOW);

      esc1.writeMicroseconds(1500);
      esc2.writeMicroseconds(1500);
      esc3.writeMicroseconds(1500);

      Serial.print(Str);

    } else if (Str == "p") {

      float d2 = -1000.00001 ;
      int test = 3 ;

      for ( int a = 0 ; a < 500 ; a++ ) {

        raw = analogRead(A0);
        depth =  (((raw - 101 ) * 2.6875) + .8) ;
        voltage = ((((int) raw * 5.0 / 1024.0) + .02));    // voltage at the pin of the Arduino

        if ( test < raw  &&  d2 < depth ) {

          test = raw ;
          d2 = depth ;

        }

        delay(3);

      }

      float pressure = (d2 * 98.1) ;
      Serial.print("\n");
      Serial.print("\n");
      Serial.print("Pressure (Pascal) = ");
      Serial.print(pressure);
      Serial.print("\n");
      Serial.print("Depth (cm) = ");
      Serial.print(d2);
      Serial.print("\n");
      Serial.print("Raw Value = ") ;
      Serial.print( raw) ;
      Serial.print('\n');
      delay(500) ;

    } else if (Str == "t") {
      Serial.print("\n");
      Serial.print("\n");
      if (!ds.search(addr)) {
        Serial.print("\n");
        Serial.println("No more addresses.\n");
        Serial.println();
        ds.reset_search();
        delay(250);
        return;
      }

      Serial.print("ROM =");
      for ( i = 0; i < 8; i++) {
        Serial.write(' ');
        Serial.print(addr[i], HEX);
      }

      if (OneWire::crc8(addr, 7) != addr[7]) {
        Serial.println("CRC is not valid!");
        return;
      }
 
      Serial.println();

      // the first ROM byte indicates which chip
      switch (addr[0]) {
        case 0x10:
          Serial.println("Chip = DS18S20");  // or old DS1820
          type_s = 1;
          break;
        case 0x28:
          Serial.println("Chip = DS18B20");
          type_s = 0;
          break;
        case 0x22:
          Serial.println("Chip = DS1822");
          type_s = 0;
          break;
        default:
          Serial.println("Device is not a DS18x20 family device.");
          return;
      }

      ds.reset();
      ds.select(addr);
      ds.write(0x44, 1);        // start conversion, with parasite power on at the end

      delay(1000);     // maybe 750ms is enough, maybe not
      // we might do a ds.depower() here, but the reset will take care of it.

      present = ds.reset();
      ds.select(addr);
      ds.write(0xBE);         // Read Scratchpad
//
      Serial.print("Data = ");
      Serial.print(present, HEX);
      Serial.print(" ");
      for ( i = 0; i < 9; i++) {           // we need 9 bytes
        data[i] = ds.read();
        Serial.print(data[i], HEX);
        Serial.print(" ");
      }
      Serial.print("CRC=");
      Serial.print(OneWire::crc8(data, 8), HEX);
      Serial.println();

      // Convert the data to actual temperature
      // because the result is a 16 bit signed integer, it should
      // be stored to an "int16_t" type, which is always 16 bits
      // even when compiled on a 32 bit processor.
      raw = (data[1] << 8) | data[0];

      if (type_s) {

        raw = raw << 3; // 9 bit resolution default

        if (data[7] == 0x10) {

          // "count remain" gives full 12 bit resolution
          raw = (raw & 0xFFF0) + 12 - data[6];

        }
      } else {

        cfg = (data[4] & 0x60);
        // at lower res, the low bits are undefined, so let's zero them
        if (cfg == 0x00) raw = raw & ~7;  // 9 bit resolution, 93.75 ms
        else if (cfg == 0x20) raw = raw & ~3; // 10 bit res, 187.5 ms
        else if (cfg == 0x40) raw = raw & ~1; // 11 bit res, 375 ms
        //// default is 12 bit resolution, 750 ms conversion time

      }
      celsius = (float)raw / 16.0;
      fahrenheit = celsius * 1.8 + 32.0;
      Serial.print("Temperature = ");
      Serial.print(celsius);
      Serial.print(" Celsius");


    } else if (Str == "x") {

      digitalWrite(9, HIGH);
      Serial.print(Str);

    } else if (Str == "y") {

      digitalWrite(9, LOW);
      Serial.print(Str);

    } else {

      int x = Str.toInt();
      y = map(x, 1, 10, 1500, 1100);
      z = map(x, 1, 10, 1500, 1900);

      if (Str == "f") {

        Serial.print(Str);
        esc3.writeMicroseconds(y);
        esc2.writeMicroseconds(y);

      } else if (Str == "b") {

        esc3.writeMicroseconds(z);
        esc2.writeMicroseconds(z);
        Serial.print(Str);

      }


    }

  }
}
