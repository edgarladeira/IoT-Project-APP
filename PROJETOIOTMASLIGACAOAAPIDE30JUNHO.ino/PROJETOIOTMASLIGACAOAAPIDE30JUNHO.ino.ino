#include <Stepper.h> //INCLUSÃO DE BIBLIOTECA
#define MAX_JSON_LENGTH 200

#include <SPI.h>
#include <Ethernet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int stepsPerRevolution = 100; //NÚMERO DE PASSOS POR VOLTA
 
const int ldr = A0;
int valorldr = 0;

//Arduino - Sensor de humidade do solo e Sensor de chuva

int sensorHumidadeSolo = A1;   // Sensor de humidade pino A0 conectado no A0 do Arduino
int valorLimiteHumidade = 500; // valor da tensão de comparação (valor máximo = 1024)
bool soloHumido;               // condição de solo Húmido 

Stepper myStepper(stepsPerRevolution, 8,10,9,11); //INICIALIZA O MOTOR UTILIZANDO OS PINOS DIGITAIS 8, 9, 10, 11

int DHpin = 12; // input/output pin
byte dat[5];   

char server[] = "192.168.0.112:8080";    // name address for Google (using DNS)

char server2[] = "192.168.0.112";    // name address for Google (using DNS)

const char* resource = "/arduino/sendData";

byte mac[] = {0x90, 0xA2, 0xDA, 0x0D, 0x21, 0x9D};
IPAddress ip(192, 168, 0, 115);
IPAddress myDns(192, 168, 0, 1);

// Initialize the Ethernet client library
// with the IP address and port of the server
// that you want to connect to (port 80 is default for HTTP):
EthernetClient client;

unsigned long beginMicros, endMicros;
unsigned long byteCount = 0;
bool printWebData = true;  // set to false for better speed measurement


//float tempAr = 22;
//float humSolo = 80;
//float luz = 500;
//bool maduro = false;
//float humAr = 90;



byte read_data()
{
  byte i = 0;
  byte result = 0;
  for (i = 0; i < 8; i++) {
      while (digitalRead(DHpin) == LOW); // wait 50us
      delayMicroseconds(30); //The duration of the high level is judged to determine whether the data is '0' or '1'
      if (digitalRead(DHpin) == HIGH)
        result |= (1 << (8 - i)); //High in the former, low in the post
    while (digitalRead(DHpin) == HIGH); //Data '1', waiting for the next bit of reception
    }
  return result;
}
void start_test () {
  digitalWrite (DHpin, LOW); // bus down, send start signal
  delay (30); // delay greater than 18ms, so DHT11 start signal can be detected
 
  digitalWrite (DHpin, HIGH);
  delayMicroseconds (40); // Wait for DHT11 response
 
  pinMode (DHpin, INPUT);
  if (digitalRead (DHpin) == HIGH);
    delayMicroseconds (80); // DHT11 response, pulled the bus 80us
  if (digitalRead (DHpin) == LOW);
    delayMicroseconds (80); // DHT11 80us after the bus pulled to start sending data
 
  for (int i = 0; i < 4; i ++) // receive temperature and humidity data, the parity bit is not considered
    dat[i] = read_data ();
 
  pinMode (DHpin, OUTPUT);
  digitalWrite (DHpin, HIGH); // send data once after releasing the bus, wait for the host to open the next Start signal
}

float SensorDeHumidade () {
 int valorSensorHumidadeSolo = analogRead(sensorHumidadeSolo); // faz a leitura do Sensor
 Serial.print(" Sensor de humidade do solo = ");               // imprime mensagem
 Serial.print(valorSensorHumidadeSolo);                        // imprime o valor do sensor
 if (valorSensorHumidadeSolo < valorLimiteHumidade) {          // se valor < limite
   Serial.println("  => O solo está húmido");                  // imprime mensagem
   soloHumido = 1 ;                                            // o solo está húmido 
 } else {                                                      // senão
   Serial.println("  => O solo está seco");                   // imprime mensagem
   soloHumido = 0 ;                                            // o solo está seco 
 }   
 return valorSensorHumidadeSolo;              // imprime mensagem 
}



void setup(){
  Serial.begin(9600);
    while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  myStepper.setSpeed(300); //VELOCIDADE DO MOTOR
  pinMode(ldr, INPUT);
  pinMode(DHpin, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(sensorHumidadeSolo, INPUT); // Sensor de humidade - porta A0 é entrada

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




void loop(){ //sensor de luminancia
  valorldr = analogRead(ldr); 
  Serial.print("Valor lido pelo LDR= ");
  Serial.print(valorldr);

  //Sensor de humidade/temperatura no ambiente -------- VERR e tratar humidade e temperatura para enviar

  //start_test();
  Serial.print("| Humdity = ");
  Serial.print(dat[0], DEC); //Displays the integer bits of humidity;
  Serial.print('.');
  Serial.print(dat[1], DEC); //Displays the decimal places of the humidity;
  Serial.print('%');
  Serial.print("Temperature = ");
  Serial.print(dat[2], DEC); //Displays the integer bits of temperature;
  Serial.print('.');
  Serial.print(dat[3], DEC); //Displays the decimal places of the temperature;
  Serial.println('C');
  byte checksum = dat[0] + dat[1] + dat[2] + dat[3];
  if (dat[4] != checksum) 
    Serial.println("-- Checksum Error!");
  else
    Serial.println("-- OK");
  digitalWrite(13, HIGH);
  
  //Sensor de Humidade no Solo
  float valorhumsolo = 0.0;

 // contagem de 1 a 4320 ( 4320 x 5 segundos = 6 horas)
   valorhumsolo = SensorDeHumidade(); 
   


 if (client.connect(server2, 8080)) {
    Serial.print("connected to ");
    Serial.println(client.remoteIP());

    char json[MAX_JSON_LENGTH];


    float temperature = 12.5;
    char tempAr[10];
    float humArf = 22.5;
    char humAr[10];   
    float humSolof = 22.5;

    char humSolo[10];

    char luz[10];
    
    char maduro[10];
    char m[] = "false";

    // Inicializar a string JSON como um objeto vazio
    strcpy(json, "");

    // Converter os valores inteiros para strings
    //snprintf(tempAr, sizeof(tempAr), "%f", 12.5);
    // Converter os valores inteiros para strings
    snprintf(tempAr, sizeof(tempAr), "%d", (int)temperature);
    snprintf(humAr, sizeof(humAr), "%d", (int)humArf);
    snprintf(humSolo, sizeof(humSolo), "%d", (int)humSolof);
    snprintf(luz, sizeof(luz), "%d", valorldr);


    // Adicionar os dados ao objeto JSON
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

  
    Serial.print(json);
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
      
    //while(soloHumido == 0)
    //myStepper.step(stepsPerRevolution); //GIRA O MOTOR NO SENTIDO ANTI-HORÁRIO

    for(int i = 0; i < 50; i++){ //PARA "i" IGUAL A 0, ENQUANTO "i" MENOR QUE 50 INCREMENTA "i"
          myStepper.step(stepsPerRevolution); //GIRA O MOTOR NO SENTIDO ANTI-HORÁRIO
  }
   //LAÇO "for" QUE LIMITA O TEMPO EM QUE O MOTOR GIRA NO SENTIDO HORÁRIO
  for(int i = 0; i < 50; i++){//PARA "i" IGUAL A 0, ENQUANTO "i" MENOR QUE 50 INCREMENTA "i"
          myStepper.step(-stepsPerRevolution); //GIRA O MOTOR NO SENTIDO HORÁRIO
  }

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
    delay(500);
  }

  delay(30000);
}