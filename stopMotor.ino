void stopMotors() {
  analogWrite(enA,0);
  //Wheel  Rear Right 
  analogWrite(enB, 0);
  //delay(20);
  //Front Left
  analogWrite(enC, 0);
  //Rear left
  analogWrite(enD, 0);
}

