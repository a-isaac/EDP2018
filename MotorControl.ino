// connect motor controller pins to Arduino digital pins
// motor one

void straightPath() {
  analogWrite(enA,100);
  //Wheel  Rear Right 
  analogWrite(enB, 100);
  //delay(20);
  //Front Left
  analogWrite(enC, 200);
  //Rear left
  analogWrite(enD, 100);
}

void circlePath() {
  
  analogWrite(enA,100);
  //Wheel  Rear Right 
  analogWrite(enB, 100);
  //delay(20);
  //Front Left
  analogWrite(enC, 0);
  //Rear left
  analogWrite(enD, 65);
}

void MotorControl(int FL, int FR,int RL,int RR) {
  // Front Left
  analogWrite(enA,FL);
  // Front Right
  analogWrite(enB,FR);
  // Rear Left
  analogWrite(enC,RL);
  //Rear Right
  analogWrite(enD,RR);
}

void demoTwo()
{
  // this function will run the motors across the range of possible speeds
  // note that maximum speed is determined by the motor itself and the operating voltage
  // the PWM values sent by analogWrite() are fractions of the maximum speed possible 
  // by your hardware
  // turn on motors
  // accelerate from zero to maximum speed
  int count = 50;
  int j= 10;
 
    for (int i =65; i < 256  ; i +=6)
    {      
   if (i >65 && i<80){
      //Wheel Front Right
     analogWrite(enA,i);
      //Wheel  Rear Right 
      analogWrite(enB, i);
      //delay(20);
      //Front Left
     analogWrite(enC, i);
      //Rear left
     analogWrite(enD, i);
      
    }

   
    if (i >85 && i<91)
    {
      //Wheel Front Right
     analogWrite(enA,0);
      //Wheel  Rear Right 
      analogWrite(enB, 0);
      //delay(20);
      //Front Left
     analogWrite(enC, 70);
      //Rear left
     analogWrite(enD, 70);

   
      
    }
      if (i >95 && i<120){
      //Wheel Front Right
     analogWrite(enA,i);
      //Wheel  Rear Right 
      analogWrite(enB, i);
      //delay(20);
      //Front Left
     analogWrite(enC, i);
      //Rear left
     analogWrite(enD, i);
      
    }   

       if (i >120 && i<135){
      //Wheel Front Right
     analogWrite(enA,i);
      //Wheel  Rear Right 
      analogWrite(enB, i);
      //delay(20);
      //Front Left
     analogWrite(enC, i);
      //Rear Right
     analogWrite(enD, i);
      
    }

       if (i >135){
      //Wheel Front Right
     analogWrite(enA,i);
      //Wheel  Rear Right 
      analogWrite(enB, i);
      //delay(20);
      //Front Left
     analogWrite(enC, i);
      //Rear Right
     analogWrite(enD, i);
      
    }
      Serial.print("Current Duty Cycle:");
      Serial.print(i);
      Serial.println("\r");
      delay(1000);
      
    } 
}
