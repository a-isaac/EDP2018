// Define libraries
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <OneWire.h>
#include "MPU9255.h"
#include <SoftwareSerial.h>   //Software Serial Port
#define RxD 6
#define TxD 7

// SDA = A4, SCL = A5
// IMU Acceleration: X(+front/-back) & Z(+left/-right)
// IMU Gyroscope: Y(+CW/-CCW Yaw)

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
const float aOffSet_x = -0.02;
const float aOffSet_y = 1.0;
const float aOffSet_z = -0.1;

const int gOffSet;

// Define packet count
int packet = 0;

// Define time;
unsigned long timer = millis();

// Initialize serial port data
char blueToothData;
char serialData;

// Define Motor Pins
int enA = 5;
int enB = 9;
int enC = 10;
int enD = 11;
int count = 0;

MPU9255 mpu(12, gAccuracy, aAccuracy, mAccuracy); // Create MPU9255 Sensor object

void setup() {

  // Minor environment initialization
  Wire.begin();//initialization of the I2C protocol
  TWBR = 24; // Two Wire Bit Rate Register
  Serial.begin(9600);
  pinMode(RxD, INPUT);
  pinMode(TxD, OUTPUT);

  pinMode(enA, OUTPUT);
  pinMode(enB, OUTPUT);
  pinMode(enC, OUTPUT);
  pinMode(enD, OUTPUT);

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

    // bt to ard

    // ***************************
    // Not sure how to handle the data coming from the bluetooth serial to the arduino.
    // Currently reads char by char and produces output such that it spells out t e s t to give test
    // rather than output one string as 'test'
    //*****************************
 
    
    while (blueToothSerial.available()) { //check if there's any data sent from the remote bluetooth shield
      blueToothData = blueToothSerial.read();
      Serial.println(blueToothData);
    }
    // ard to bt
     if (Serial.available()){ //check if there's any data sent from the local serial terminal, you can add the other applications here
     }

     if (blueToothData == 'G') {
        getData();
        transmitData();
        //demoTwo();
        straightPath();
      } else if (blueToothData == 'C'){
        getData();
        transmitData();
        circlePath();
      } else if (blueToothData == 'S') {
        blueToothSerial.println("Waiting...");
        blueToothData = '0';
        packet = 0;
        stopMotors();
    }
    delay(100);

}


