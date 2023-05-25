/*
 Web client

 This sketch connects to a website (http://www.google.com)
 using an Arduino WIZnet Ethernet shield.

 Circuit:
 * Ethernet shield attached to pins 10, 11, 12, 13

 created 18 Dec 2009
 by David A. Mellis
 modified 9 Apr 2012
 by Tom Igoe, based on work by Adrian McEwen

 */

#define MAX_JSON_LENGTH 200

#include <SPI.h>
#include <Ethernet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// Enter a MAC address for your controller below.
// Newer Ethernet shields have a MAC address printed on a sticker on the shield

// if you don't want to use DNS (and reduce your sketch size)
// use the numeric IP instead of the name for the server:
//IPAddress server(74,125,232,128);  // numeric IP for Google (no DNS)
char server[] = "192.168.0.112:8080";    // name address for Google (using DNS)

char server2[] = "192.168.0.112";    // name address for Google (using DNS)

const char* resource = "/arduino/sendData";



// Set the static IP address to use if the DHCP fails to assign
byte mac[] = {0x90, 0xA2, 0xDA, 0x0D, 0x21, 0x9D};
IPAddress ip(192, 168, 0, 115);
IPAddress myDns(192, 168, 0, 1);

// Initialize the Ethernet client library
// with the IP address and port of the server
// that you want to connect to (port 80 is default for HTTP):
EthernetClient client;

// Variables to measure the speed
unsigned long beginMicros, endMicros;
unsigned long byteCount = 0;
bool printWebData = true;  // set to false for better speed measurement


float tempAr = 22;
float humSolo = 80;
float luz = 500;
bool maduro = false;
float humAr = 90;


void setup() {
  // You can use Ethernet.init(pin) to configure the CS pin
  //Ethernet.init(10);  // Most Arduino shields
  //Ethernet.init(5);   // MKR ETH Shield
  //Ethernet.init(0);   // Teensy 2.0
  //Ethernet.init(20);  // Teensy++ 2.0
  //Ethernet.init(15);  // ESP8266 with Adafruit FeatherWing Ethernet
  //Ethernet.init(33);  // ESP32 with Adafruit FeatherWing Ethernet

  // Open serial communications and wait for port to open:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  // start the Ethernet connection:
  Serial.println("Initialize Ethernet with DHCP:");
  if (Ethernet.begin(mac) == 0) {
    Serial.println("Failed to configure Ethernet using DHCP");
    // Check for Ethernet hardware present
    if (Ethernet.hardwareStatus() == EthernetNoHardware) {
      Serial.println("Ethernet shield was not found.  Sorry, can't run without hardware. :(");
      while (true) {
        delay(1); // do nothing, no point running without Ethernet hardware
      }
    }
    if (Ethernet.linkStatus() == LinkOFF) {
      Serial.println("Ethernet cable is not connected.");
    }
    // try to configure using IP address instead of DHCP:
    Ethernet.begin(mac, ip, myDns);
  } else {
    Serial.print("  DHCP assigned IP ");
    Serial.println(Ethernet.localIP());
  }
  // give the Ethernet shield a second to initialize:
  delay(1000);
  Serial.print("connecting to ");
  Serial.print(server);
  Serial.println("...");
}

void loop() {

  //HttpClient http(c);

  // if there are incoming bytes available
  // from the server, read them and print them:
 
  //err = http.get(kHostname, kPath);


  //data+="/arduino/sendData?" + tempAr + "&" + humSolo + "&" + luz + "&" + maduro + "&" + humAr;
// if you get a connection, report back via serial:
  if (client.connect(server2, 8080)) {
    Serial.print("connected to ");
    Serial.println(client.remoteIP());

    char json[MAX_JSON_LENGTH];
    char tempAr[10];
    char humAr[10];
    char humSolo[10];
    char luz[10];
    char maduro[10];

    // Inicializar a string JSON como um objeto vazio
    strcpy(json, "");

    // Converter os valores inteiros para strings
    snprintf(tempAr, sizeof(tempAr), "%d", 123);
    snprintf(humAr, sizeof(humAr), "%d", 1351);
    snprintf(humSolo, sizeof(humSolo), "%d", 234);
    snprintf(luz, sizeof(luz), "%d", 23);

    // Adicionar os dados ao objeto JSON
    strcat(json, "{\"tempAr\": ");
    strcat(json, tempAr);
    strcat(json, ",");
    strcat(json, "\"humAr\": ");
    strcat(json, humAr);
    strcat(json, ",");
    strcat(json, "\"humSolo\": ");
    strcat(json, humSolo);
    strcat(json, ",");
    strcat(json, "\"luz\": ");
    strcat(json, luz);
    strcat(json, ",");
    strcat(json, "\"maduro\": \"");
    strcat(json, "false");
    strcat(json, "\"}");

    //String aa ="aaaa";

    //String postData = "{\"name\":\"AX1_02\",\"sector\":\"\",\"ip\":\"BBB mac\":\AAA\"}";

    //client.print("POST /arduino/sendData HTTP/1.1\r\nConnection: Close\r\nContent-Type: application/json\r\nContent-Length: " + postData.length() + "\r\n\r\n" +
             //postData + "\r\n");
  
    // Make a HTTP request:
    client.println("POST /arduino/sendData HTTP/1.1");
    client.println("Host: 192.168.0.112:8080");
    client.println("Connection: close");
    client.println("Content-Type: application/json");
    client.print("Content-Length: ");
    client.println(strlen(json));
    client.println();
    client.println(json);
    Serial.println(json);

  } else {
    // if you didn't get a connection to the server:
    Serial.println("connection failed");
  }
  beginMicros = micros();

  // if the server's disconnected, stop the client:
  if (!client.connected()) {
    endMicros = micros();
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
    Serial.print("Received ");
    Serial.print(byteCount);
    Serial.print(" bytes in ");
    float seconds = (float)(endMicros - beginMicros) / 1000000.0;
    Serial.print(seconds, 4);
    float rate = (float)byteCount / seconds / 1000.0;
    Serial.print(", rate = ");
    Serial.print(rate);
    Serial.print(" kbytes/second");
    Serial.println();

    // do nothing forevermore:
    while (true) {
      delay(1);
    }
    delay(50000);
  }
}
