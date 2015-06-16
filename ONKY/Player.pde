class Player {
  float x, y, w=50, h=100, vx=5, vy, ax, ay=0.8, angle;
  final int MAX_JUMP=2,PUNCH_MAX_CD=20;
  int cooldown, invis=100, health, maxHealth=100, jumpCount, punchTime,punchCooldown=PUNCH_MAX_CD,punchRange=100;
  boolean dead, onGround, punching;
  color playerColor= color(255, 0, 0);
  Player() {
  }

  void update() {
    x+=vx;
    y+=vy;
    vx+=ax;
    vy+=ay;

    if(punchCooldown>0)punchCooldown--;
    if (0<invis) {
      recover();
    } else {
      playerColor = color(255);
    }
    println(invis);
    checkIfGround();
    if (jumpCount<1)angle+=15; 
    else angle=0;
  }
  void display() {
    pushMatrix();
    translate(x+w*0.5, y+h*0.5);
    rotate(radians(angle));

    fill(playerColor);
    rect(-w*0.5, -h*0.5, w, h*0.5);
    fill(255);
    rect(-w*0.5, 0, w, h*0.5);

    popMatrix();
    if (punching && punchCooldown==0)punch();
  }
  void collision() {
    invis=100;
    vx=0;
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
    vy=20;
  }
  void checkIfObstacle(int top) {
    if (top<y+h) { 
      jumpCount=MAX_JUMP;
      onGround=true;
      y=top-h;
      vy=0;
    }
  }
  void checkIfGround() {
    if (floorHeight<y+h) { 
      jumpCount=MAX_JUMP;
      onGround=true;
      y=floorHeight-h;
      //vy=0;
    }
  }
  void recover() {
    invis--;
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
}

