
#include <SPI.h>
#include <Ethernet.h>
#include "w5100.h"


//Network
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ipMe(10, 20, 0, 3);
IPAddress ipOCS(10, 20, 0, 1);
const int PORT_NUM = 80;
EthernetClient client;

//Pins
const int pinFireLed = 16;
const int pinFireButton = 21;
const int pinFiber = 19;

//Messages
String strEnable = "FIRE ENABLED";
String strDisable = "FIRE DISABLED";

//Signals
int sigEnable = 0;

//Prototypes
void initEthernet();
void firePulse();

//ARMING MESSAGE FROM SERVER
//////////////////////
String ARM = "41524D";     //Value is ARM in HEX
//////////////////////

//////////////////////////////////////////////////

void setup() {
  //Ethernet Shield Reset
  pinMode(9, OUTPUT);
  digitalWrite(9, LOW);    // begin reset the WIZ820io
  pinMode(10, OUTPUT);
  digitalWrite(10, HIGH);  // de-select WIZ820io
  pinMode(4, OUTPUT);
  digitalWrite(4, HIGH);   // de-select the SD Card
  digitalWrite(9, HIGH);   // end reset pulse
  
  //Pins
  pinMode(pinFireLed, OUTPUT);
  pinMode(pinFireButton, INPUT);
  pinMode(pinFiber, OUTPUT);

  sigEnable = 0;
/*
  //Serial
  Serial.begin(9600);
  while (!Serial) {
    ;
  }
  Serial.println("Fire Button");
*/
  //Network
  initEthernet();
}

//////////////////////////////////////////////////

void loop() {
  //Network
  if(!client.connected()) {
    int val = client.connect(ipOCS, PORT_NUM);
/*
    if(val == 1) {
      Serial.print("    connecting...");
      Serial.print(ipOCS);
      Serial.print(":");
      Serial.println(PORT_NUM);
    } else {
      Serial.print("    Server not detected...ERROR: ");
      Serial.println(val);
    }
*/
  } else {
    String out;
    String in;

    //Receiver
    while(client.available() > 0) {
      char c = client.read();
      in += c;
    }

    if(in == ARM) {
      //Serial.println("        ARM CODE");
      sigEnable = (sigEnable * -1) + 1;
    }
    
    if(sigEnable == 1)        { out = strEnable; }
    else if(sigEnable == 0)   { out = strDisable; }

    //Sender
    //Serial.print("        ");
    //Serial.println(out);
    client.println(out);

    delay(1000);
  }

  delay(50);

  //Pins
  //if enable, then light PB
  if(sigEnable == 1) {
    digitalWrite(pinFireLed, HIGH);
  } else if(sigEnable == 0) {
    digitalWrite(pinFireLed, LOW);
  }

  //if fire PB, then send fire
  if(digitalRead(pinFireButton) == HIGH && sigEnable == 1) {
    firePulse();
    //Serial.println("FIRE!!!");
    sigEnable = 0;
    digitalWrite(pinFireLed, LOW);
  } else {
    digitalWrite(pinFireButton, LOW);
  }
}

//////////////////////////////////////////////////

void initEthernet() {
  Ethernet.init(10);
  
  //Serial.print("Initialize Ethernet: ");
  Ethernet.begin(mac, ipMe);
  //Serial.println(Ethernet.localIP());

  W5100.setRetransmissionTime(200);
  W5100.setRetransmissionCount(5);
}

void firePulse() {
  digitalWrite(pinFiber, HIGH);
  delayMicroseconds(5);
  digitalWrite(pinFiber, LOW);
  delayMicroseconds(5);

  digitalWrite(pinFiber, HIGH);
  delayMicroseconds(5);
  digitalWrite(pinFiber, LOW);
  delayMicroseconds(5);

  digitalWrite(pinFiber, HIGH);
  delayMicroseconds(5);
  digitalWrite(pinFiber, LOW);
  delayMicroseconds(5);

  digitalWrite(pinFiber, HIGH);
  delayMicroseconds(5);
  digitalWrite(pinFiber, LOW);
  delayMicroseconds(5);

  digitalWrite(pinFiber, HIGH);
  delayMicroseconds(5);
  digitalWrite(pinFiber, LOW);
  delayMicroseconds(5);
}


