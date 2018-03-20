// connect motor controller pins to Arduino digital pins
// motor one

void demoTwo(int i)
{
  i = 100;
  // this function will run the motors across the range of possible speeds
  // note that maximum speed is determined by the motor itself and the operating voltage
  // the PWM values sent by analogWrite() are fractions of the maximum speed possible 
  // by your hardware
  // turn on motors
  // accelerate from zero to maximum speed
    analogWrite(enA, i);
    analogWrite(enB, i);
    analogWrite(enC, i);
    analogWrite(enD, i);
}

