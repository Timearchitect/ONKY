void keyPressed() {

    
  if (key== 'r') {
    p.x=0;
  }
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
    
  if (key== 'a') {
    p.deAccel();
  }
  if (key== 'd') {
    p.accel();
  }
  if (key==' ') {
    p.jump();
  }
  if (key=='w') {
    p.jump();
  }
  if (key=='x') {
    p.punching=true;
    p.punchTime=30;
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


