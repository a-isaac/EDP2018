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

// Define Motor Pins
int enA = 5;
int enB = 9;
int enC = 10;
int enD = 11;

// Initialize Incoming Serial Commands
int FL, FR, RL, RR;
const byte numChars = 32;
char receivedChars[numChars];
char tempChars[numChars];        // temporary array for use when parsing

// variables to hold the parsed data
char messageFromPC[numChars] = {0};

boolean newData = false;

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
  //** PLEASE SEND INCOMING DATA AS <a,b,c,d>
  //** IT NEEDS TO HAVE THE START MARKER '<' AND END MARKER '>'
  //** OR IT WONT BE READ AT ALL
  
  recvWithStartEndMarkers();
  if (newData == true) {
    strcpy(tempChars, receivedChars); // Used for protection of data
    parseData(); // Motor Control is done here
    showParsedData(); 
    newData = false;
    
  } else {
      getData(); 
      transmitData();      
  }
  delay(150);
}


