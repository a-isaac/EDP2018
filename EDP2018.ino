// Define libraries
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <OneWire.h>
#include "MPU9255.h"
#include <SoftwareSerial.h>   //Software Serial Port
#define RxD 6
#define TxD 7

// SDA = A4, SCL = A5

SoftwareSerial blueToothSerial(RxD, TxD);
// Define 16bit integers
int16_t accelCount[3];
int16_t gyroCount[3];
int16_t magCount[3];

// Define floats;
float f_accelCount[3]; // Array of size 3 for X Y Z
float f_gyroCount[3];
float f_magCount[3];

// Define scales and accuracy
float AccelScale, GyroScale, MagScale;
int gAccuracy = 250; // degrees per second
int aAccuracy = 2; // +- 2g
int mAccuracy = 6; // 0.6mGauss

// Define Calibration Offsets
const int aOffSet_x = 0;
const int aOffSet_y = 1;
const float aOffSet_z = 0.15;

const int gOffSet;

// Define packet count
int packet = 0;

// Define time;
unsigned long timer = millis();

MPU9255 mpu(12, gAccuracy, aAccuracy, mAccuracy); // Create MPU9255 Sensor object

void setup() {

  // Minor environment initialization
  Wire.begin();//initialization of the I2C protocol
  TWBR = 24; // Two Wire Bit Rate Register
  Serial.begin(9600);
  pinMode(RxD, INPUT);
  pinMode(TxD, OUTPUT);

  // Setup BT Connection
  setupBlueToothConnection();

  mpu.initMPU9250();// // Initalization of MPU Sensor
  float magCalibration[3];
  mpu.initAK8963(magCalibration);// Initialize magnometer

  GyroScale = 131.0;
  AccelScale = 16384.0;
  MagScale = 0.6;
}

void loop() {

  char recvChar;
  while (1) {
    // bt to ard

    // ***************************
    // Not sure how to handle the data coming from the bluetooth serial to the arduino.
    // Currently reads char by char and produces output such that it spells out t e s t to give test
    // rather than output one string as 'test'
    ******************************//
    if (blueToothSerial.available()) { //check if there's any data sent from the remote bluetooth shield
      recvChar = blueToothSerial.read();
      Serial.print(recvChar);
    }
    // ard to bt
    // if (Serial.available()) { //check if there's any data sent from the local serial terminal, you can add the other applications here
    //recvChar  = Serial.read();
    getData();
    transmitData();
    //blueToothSerial.print(recvChar);

    // }
    delay(1000);
  }

}


