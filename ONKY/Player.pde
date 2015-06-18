class Player {
  Powerup usedPowerup  ;
  PImage SpriteSheetRunning ; //setup
  PImage cell;
  float x, y, w=100, h=90, vx=5, vy, ax, ay=0.9, angle, decayFactor=0.95;
  final int MAX_JUMP=2, PUNCH_MAX_CD=20, SMASH_MAX_CD=50;
  int cooldown, invis=50, health, maxHealth=100;
  int  jumpCount;
  int punchTime, punchCooldown=PUNCH_MAX_CD, punchRange=100;
  int duckTime, duckCooldown;
  int smashTime, smashCooldown =SMASH_MAX_CD, smashRange=100;
  boolean dead, onGround, punching, smashing, ducking;
  color playerColor= color(255, 0, 0);
  Player() {
  }

  void update() {
    x+=vx;
    y+=vy;
    vx+=ax;
    vy+=ay;
    if (vx<12 && vx>0)vx*=1.08;
    if (vx<0)vx*= decayFactor;

    if (punchTime<=0 && punchCooldown>0)punchCooldown--;

    if (0<invis) {
      recover();
    } else {
      playerColor = color(255);
    }
    cutSprite(int(x/40));

    checkIfGround();

    checkDuck();

    if (jumpCount<1)angle+=15;
  }


  void display() {
    pushMatrix();
    translate(x+w*0.5, y+h*0.5);
    rotate(radians(angle));

    /*stroke(0);
     fill(playerColor);
     rect(-w*0.5, -h*0.5, w, h*0.5);
     fill(255);
     rect(-w*0.5, 0, w, h*0.5);*/
    image(cell, -w*0.5, -h*0.5, w, h);


    if (usedPowerup!=null)  usedPowerup.use();


    popMatrix();
    if (punching && punchCooldown==0)punch();
    smash();
  }
  void collision() {
    invis=100;
    vx= -vx*0.4;
    playerColor= color(0); // change color on hit to black
  }
  void jump() {
    if (jumpCount>0) {
      jumpCount--;
      vy=-20;
    }
  }
  void accel() {
    vx++;
  }
  void deAccel() {
    vx--;
  }
  void duck() {
    vy=22;
    ducking=true;
    duckTime=50;
  }
  void checkIfObstacle(int top) {
    if (top<y+h) { 
      jumpCount=MAX_JUMP;
      onGround=true;
      y=top-h;
      vy=0;
      angle=5;
    }
  }
  void checkIfGround() {
    if (floorHeight<y+h) { 
      jumpCount=MAX_JUMP;
      onGround=true;
      y=floorHeight-h;
      angle=2;
    }
  }
  void recover() {
    invis--;
    angle=-22;
  }
  void startPunch() {
    if (punchCooldown<=0 && !punching) {
      punching=true;
      punchTime=30;
    }
  }
  void punch() {

    fill(255, 0, 0);
    rect(x+w, y, punchRange, 75);
    if (punchTime<0) {
      punching=false;
      punchCooldown=PUNCH_MAX_CD;
    } else {
      punchTime--;
    }
  }
  void startSmash() {
    if (smashCooldown<=0 && !smashing) {
      smashing=true;
      smashTime=30;
    }
  }
  void smash() {

    fill(255, 0, 0);
    rect(x+w*0.5, y+h, smashRange, smashRange);
    if (smashTime<0) {
      smashing=false;
      smashCooldown=200;
    } else {
      smashTime--;
    }
  }
  void checkDuck() {
    if (duckTime<0) {
      h=90;
      ducking=false;
    } else {
      h=45;
      duckTime--;
    }
  }

  void cutSprite (int index) {
    final int interval= 160, imageWidth=162, imageheight=132;
    index= int(index%16);
    cell = SpriteSheetRunning.get(index*(interval), 0, imageWidth, imageheight);
  }
}

