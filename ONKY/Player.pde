class Player {


  Powerup usedPowerup  ;
  PImage SpriteSheetRunning, FrontFlip, Life, Jump, DownDash, Slide; //setup
  PImage cell;
  float x, y, w=100, h=90, vx=5, vy, ax, ay=0.9, angle, decayFactor=0.95;
  final int MAX_LIFE=3, MAX_JUMP=2, PUNCH_MAX_CD=20, SMASH_MAX_CD=50;
  int cooldown, invis=50, health, maxHealth=100;
  int  jumpCount=MAX_JUMP, lives= MAX_LIFE;
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

    if (vx<0 && vx>-1) vx=1;
    if (vx<speedLevel && vx>0)vx*=1.08;
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

    spawnSpeedEffect();
  }

  void display() {
    pushMatrix();
    translate(x+w*0.5, y+h*0.5);
    rotate(radians(angle));
    fill(255);

    /*stroke(0);  
     fill(playerColor);
     rect(-w*0.5, -h*0.5, w, h*0.5);   // hitbox
     fill(255); 
     rect(-w*0.5, 0, w, h*0.5);*/

    if (invis>1 && invis % 4 ==0) {
      cell.filter(INVERT);
    }

    if (ducking && onGround) { 
      image(Slide, -100*0.3, -80*0.5, 100, 80);
    } else {
      if (jumpCount>0) { 
        image(cell, -w*0.5, -h*0.5, w, h);
      } else if (jumpCount==1) {
        image(Jump, -w*0.5, -h*0.5, w, h);
      } else {
        image(FrontFlip, -w*0.5, -h*0.5, w, h);
      }
    }


    if (usedPowerup!=null) {  
      usedPowerup.use();
      if (usedPowerup.dead)usedPowerup=null;
    }

    popMatrix();
    if (punching && punchCooldown==0)punch();
    smash();
  }
  void collision() {
    if (invis==0) {
      lives--;
      playSound(ughSound);
      background(255, 0, 0);
    }
    invis=100;
    vx= -vx*0.5;
  }
  void jump() {
    if (jumpCount>0) {
      onGround=false;
      ducking=false;
      if (jumpCount==2) {
        entities.add(new LineParticle(int(x+w*0.5), int(y+h), 15, 0));
      }
      jumpSound.rewind();
      jumpSound.play();
      if (jumpCount==1) particles.add( new SpinParticle(  int(x), int(y)));

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
    if (!onGround) { 
      vy=25;
      entities.add(new LineParticle(int(x+w*0.5), int(y+h), 15, 0));
    }
    if (jumpCount<2 && !ducking)entities.add(new LineParticle(int(x+w), int(y+h*2), 80, 80));
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
    } else {
      onGround=false;
    }
  }
  void checkIfGround() {
    if (floorHeight<y+h) { 
      if (!onGround)   entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.8), 30, 0));

      jumpCount=MAX_JUMP;
      onGround=true;
      y=floorHeight-h;
      angle=2;
    }
  }
  void recover() {
    invis--;
    angle=-22;
    //  invisTint-=2;
  }
  void startPunch() {
    if (punchCooldown<=0 && !punching) {
      playSound(sliceSound);
      entities.add(new slashParticle(int(p.x), int(p.y), 0));
      punching=true;
      punchTime=30;
    }
  }
  void punch() {

    //   fill(255, 0, 0);  // hitbox
    //  rect(x+w, y, punchRange, 75);
    if (punchTime<0) {
      punching=false;
      punchCooldown=PUNCH_MAX_CD;
    } else {
      punchTime--;
      if (punchTime==15) {
        entities.add(new slashParticle(int(p.x), int(p.y), 1));
        playSound(diceSound);
      }
    }
  }
  void uppercut() {
    fill(255, 0, 0);
    rect(x+w, y, punchRange, 75);   // hitbox
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

    // fill(255, 0, 0);
    // rect(x+w*0.5, y+h, smashRange, smashRange);  // hitbox
    if (smashTime<0) {
      smashing=false;
      smashCooldown=200;
    } else {
      smashTime--;
    }
  }
  void checkDuck() {
    if (duckTime<0) {
      if (ducking)p.y-=45;
      h=90;
      ducking=false;
    } else {
      h=45;
      duckTime--;
    }
  }

  void cutSprite (int index) {
    final int interval= 160, imageWidth=160, imageheight=130;
    index= int(index%16);
    cell = SpriteSheetRunning.get(index*(interval+1)+1, 0, imageWidth, imageheight);
  }
  void reset() {
    y=0;
    vy=0;
    lives=MAX_LIFE;
    x=0;
    vx=10;
  }

  void spawnSpeedEffect() {
    if (int(random(60))<vx)particles.add(new speedParticle(int(x+w), int(random(90)+p.y)));
  }
}

