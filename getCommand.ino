void getCommand(char *incomingSerialData)
{
  int incomingSerialDataIndex = 0; // Stores the next 'empty space' in the array

  while(Serial.available() > 0)
  {
    incomingSerialData[incomingSerialDataIndex] = Serial.read();
    incomingSerialDataIndex++; // Ensure the next byte is added in the next position
    incomingSerialData[incomingSerialDataIndex] = '\0';
  }

}
