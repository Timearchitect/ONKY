void keyPressed() {


  if (keyCode == UP) {
    p.jump();
  }
  if (keyCode == DOWN) {
    p.duck();
  }
  if (keyCode == LEFT) {
    p.deAccel();
  }
  if (keyCode == RIGHT) {
    p.accel();
  }
  if (key==' ') {
    p.jump();
  }
  if (key=='w') {
    p.jump();
  }
  if (key=='x') {
    p.punch();
  }

}


void keyReleased() {

  if (keyCode == UP) {
  }
  if (keyCode == DOWN) {
  }
  if (keyCode == LEFT) {
  }
  if (keyCode == RIGHT) {
  }
  if (key==' ') {
  }
  if (key=='w') {
  }
}


