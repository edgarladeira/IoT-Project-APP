#include <Stepper.h> //INCLUSÃO DE BIBLIOTECA

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
void start_test()
{
  digitalWrite(DHpin, LOW); //Pull down the bus to send the start signal
  delay(30); //The delay is greater than 18 ms so that DHT 11 can detect the start signal
  digitalWrite(DHpin, HIGH);
  delayMicroseconds(40); //Wait for DHT11 to respond
  pinMode(DHpin, INPUT);
  while(digitalRead(DHpin) == HIGH);
  delayMicroseconds(80); //The DHT11 responds by pulling the bus low for 80us;
  
  if(digitalRead(DHpin) == LOW)
    delayMicroseconds(80); //DHT11 pulled up after the bus 80us to start sending data;
  for(int i = 0; i < 5; i++) //Receiving temperature and humidity data, check bits are not considered;
    dat[i] = read_data();
  pinMode(DHpin, OUTPUT);
  digitalWrite(DHpin, HIGH); //After the completion of a release of data bus, waiting for the host to start the next signal
}

void SensorDeHumidade () {
 int valorSensorHumidadeSolo = analogRead(sensorHumidadeSolo); // faz a leitura do Sensor
 Serial.print(" Sensor de humidade do solo = ");               // imprime mensagem
 Serial.print(valorSensorHumidadeSolo);                        // imprime o valor do sensor
 if (valorSensorHumidadeSolo < valorLimiteHumidade) {          // se valor < limite
   Serial.println("  => O solo está húmido");                  // imprime mensagem
   soloHumido = 1 ;                                            // o solo está húmido 
 } else {                                                      // senão
   Serial.println("  => O solo está seco");                    // imprime mensagem
   soloHumido = 0 ;                                            // o solo está seco 
 }                 // imprime mensagem 
}

void setup(){
  myStepper.setSpeed(300); //VELOCIDADE DO MOTOR
  pinMode(ldr, INPUT);
  pinMode(DHpin, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(sensorHumidadeSolo, INPUT); // Sensor de humidade - porta A0 é entrada
  Serial.begin(9600);
}




void loop(){
  valorldr = analogRead(ldr);
  Serial.print("Valor lido pelo LDR= ");
  Serial.print(valorldr);
  //LAÇO "for" QUE LIMITA O TEMPO EM QUE O MOTOR GIRA NO SENTIDO ANTI-HORÁRIO      
  for(int i = 0; i < 50; i++){ //PARA "i" IGUAL A 0, ENQUANTO "i" MENOR QUE 50 INCREMENTA "i"
          myStepper.step(stepsPerRevolution); //GIRA O MOTOR NO SENTIDO ANTI-HORÁRIO
  }
   //LAÇO "for" QUE LIMITA O TEMPO EM QUE O MOTOR GIRA NO SENTIDO HORÁRIO            
  for(int i = 0; i < 50; i++){//PARA "i" IGUAL A 0, ENQUANTO "i" MENOR QUE 50 INCREMENTA "i"
          myStepper.step(-stepsPerRevolution); //GIRA O MOTOR NO SENTIDO HORÁRIO
  }
  start_test();
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
  for (int i = 1; i < 4321; i++) { // contagem de 1 a 4320 ( 4320 x 5 segundos = 6 horas)
   SensorDeHumidade();            // faz a medição do sensor de humidade do solo 
   // o if aciona a bomba d'água a cada 6 horas se o tempo e o solo estiverem secos
   Serial.print(i*5);                             // imprime tempo em segundos 
   Serial.println(" segundos"); Serial.println(); // imprime mensagem e uma linha
   delay(5000);                                   // atraso de 5 segundos
 }

  //delay(1000);
  //digitalWrite(13, LOW);
  //delay(1000);
}