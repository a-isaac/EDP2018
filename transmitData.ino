//Define index

#define telePacket 0
#define teleTime 1
#define teleA_x 2
#define teleA_y 3
#define teleA_z 4
#define teleG_x 5
#define teleG_y 6
#define teleG_z 7

const int dataSize = 4;
float telemetry[dataSize];
void transmitData() {
  packet++;
  timer = timer + 0.1;
  String toBlue = "";

  toBlue += packet;
  toBlue += ",";
  toBlue += timer;
  toBlue += ",";

  toBlue += f_accelCount[0] + aOffSet_x;
  toBlue += ",";
  toBlue += f_accelCount[1] + aOffSet_y;
  toBlue += ",";
  toBlue += f_accelCount[2] + aOffSet_z;
  toBlue += ",";
  toBlue += f_gyroCount[0];
  toBlue += ",";
  toBlue += f_gyroCount[1];
  toBlue += ",";
  toBlue += f_gyroCount[2];
  
  blueToothSerial.println(toBlue);
}

