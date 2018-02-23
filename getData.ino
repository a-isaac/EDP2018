void getData() {
  mpu.readAccelData(f_accelCount); // Read the accelerometer data
  // Divide each of the components of the acceleration by the scale factor for the accelerometer
  for (int i = 0; i < 3; i++) {
    f_accelCount[i] /= AccelScale;
  }

  // Divide each of the components of the gyro by the scale factor for the gyro
  mpu.readGyroData(f_gyroCount);
  for (int i = 0; i < 3; i++) {
    f_gyroCount[i] /= GyroScale;
  }
}

