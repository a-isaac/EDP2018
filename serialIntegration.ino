//============

void recvWithStartEndMarkers() {
    static boolean recvInProgress = false;
    static byte ndx = 0;
    char startMarker = '<';
    char endMarker = '>';
    char rc;
 
    while (blueToothSerial.available() > 0 && newData == false) {
        rc = blueToothSerial.read();

        if (recvInProgress == true) {
            if (rc != endMarker) {
                receivedChars[ndx] = rc;
                ndx++;
                if (ndx >= numChars) {
                    ndx = numChars - 1;
                }
            }
            else {
                receivedChars[ndx] = '\0'; // terminate the string
                recvInProgress = false;
                ndx = 0;
                newData = true;
            }
        }

        else if (rc == startMarker) {
            recvInProgress = true;
        }
    }
}

//============

void parseData() {      // split the data into its parts

    char * strtokIndx; // this is used by strtok() as an index

    strtokIndx = strtok(tempChars,",");      // get the first part - the string
    //strcpy(messageFromPC, strtokIndx); // copy it to messageFromPC
    FL = atoi(strtokIndx);
    
    strtokIndx = strtok(NULL, ","); // this continues where the previous call left off
    FR = atoi(strtokIndx);     // convert this part to an integer

    strtokIndx = strtok(NULL, ",");
    //floatFromPC = atof(strtokIndx);
    RL = atoi(strtokIndx);// convert this part to a float

    strtokIndx = strtok(NULL, ",");
    RR = atoi(strtokIndx);

    MotorControl(FL, FR, RL, RR);
}

void showParsedData() {
    Serial.print("FL ");
    Serial.println(FL);
    Serial.print("FR ");
    Serial.println(FR);
    Serial.print("RL ");
    Serial.println(RL);
    Serial.print("RR ");
    Serial.println(RR);
}

