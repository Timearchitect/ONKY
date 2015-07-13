void keyPressed() {
  if (key== '1') {
    p.usedPowerup.add( new LaserPowerup(0, 0, 300));
    UpdatePowerupGUILife();
  }
  if (key== '2') {
    p.usedPowerup.add( new InvisPowerup(0, 0, 300));
    UpdatePowerupGUILife();
  }
  if (key== '3') {
    p.usedPowerup.add( new TeleportPowerup(int(p.x), int(p.y), 200, true));
    UpdatePowerupGUILife();
  }
  if (key== '4') {
    p.usedPowerup.add( new SlowPowerup(int(p.x), int(p.y), 300, true));
    UpdatePowerupGUILife();
  }
  if (key== '5') {
    p.usedPowerup.add( new MagnetPowerup(int(p.x), int(p.y), 300, true));
    UpdatePowerupGUILife();
  }
  if (key== '6') {
    p.usedPowerup.add( new LaserPowerup(int(p.x), int(p.y), 300, false));
    p.usedPowerup.add( new InvisPowerup(int(p.x), int(p.y), 300, false));
    p.usedPowerup.add( new TeleportPowerup(int(p.x), int(p.y), 300, false));
    p.usedPowerup.add( new SlowPowerup(int(p.x), int(p.y), 300, false));
    p.usedPowerup.add( new MagnetPowerup(int(p.x), int(p.y), 300, false));
    UpdatePowerupGUILife();
  }
  if (keyCode== DELETE ) {

    p.usedPowerup.clear();
  }

  if (key== '#') {
    debug=!debug;
  }
  if (key== '0') {
    if (debug)p.lives=99;
  }
  if (key== '¤') {
    mute=!mute;
    BGM.pause();
    if (!mute) BGM.play();
  }
  if (key== '-') {
    if (targetSpeedFactor>0.1)targetSpeedFactor-=0.1;
  }
  if (key== '+') {

    if (targetSpeedFactor<1)targetSpeedFactor+=0.1;
  }
  if (key== 'r') {
    gameReset();
  }
  if (!automate) {
  
  if (keyCode == UP) {
    p.jump();
  }
  if (keyCode == DOWN) {
    p.duck();
   // p.startSmash();
  }
  if (keyCode == LEFT) {
    //  p.deAccel();
  }
  if (keyCode == RIGHT) {
    // p.accel();
  }
  if (key== 'a') {
    //p.deAccel();
  }
  if (key== 'd') {
    //p.accel();
  }
  if (key==' ') {
    p.jump();
  }
  if (key=='w') {
    p.jump();
  }
  if (key=='s') {
    p.duck();
   // p.startSmash();
  }
  if (key=='x') {
    p.startPunch();
  }
  if (key=='0') {
    p.startPunch();
  }
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

