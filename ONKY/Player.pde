class Player {

  long trailspawnTimer;
  Powerup usedPowerup  ;
  PImage SpriteSheetRunning, FrontFlip, Life, Jump, DownDash, Slide; //setup
  PImage cell;
  float x, y, w=100, h=90, vx=5, vy, ax, ay=0.9, angle, decayFactor=0.95;
  final int MAX_LIFE=20, MAX_JUMP=2, PUNCH_MAX_CD=20, SMASH_MAX_CD=50;
  int cooldown, health, maxHealth=100, jumpCount=MAX_JUMP, lives= MAX_LIFE;
  int  punchCooldown=PUNCH_MAX_CD, punchRange=100;
  float punchTime, invis;
  int duckTime, duckCooldown;
  int smashTime, smashCooldown =SMASH_MAX_CD, smashRange=100;
  boolean dead, onGround, punching, smashing, ducking;
  color playerColor= color(255, 0, 0);

  Player() {
    trailspawnTimer=millis();
  }

  void update() {
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    vx+=ax*speedFactor;
    vy+=ay*speedFactor;

    if (vx<1 && vx>-1) vx=1;
    if (vx<speedLevel && vx>0)vx*=1+0.08*speedFactor;
    if (vx<0)vx*= decayFactor*speedFactor;

    if (punchTime<=0 && punchCooldown>0)punchCooldown--;
    if (jumpCount==0)angle+=15*speedFactor;

    if (0<invis) {
      recover();
    }
    cutSprite(int(x/40));

    checkIfGround();

    checkDuck();

    if (millis()> trailspawnTimer+80/speedFactor) {
      entities.add(new TrailParticle(int(x), int(y), cell));
      trailspawnTimer=millis();
    }

    spawnSpeedEffect();

    if (usedPowerup!=null) {  
      usedPowerup.use();
       usedPowerup.displayIcon();
      if (usedPowerup.dead)usedPowerup=null;
    }
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

    if (invis>1 && invis % 4 <=1) {
      cell.filter(INVERT);
    }

    if (ducking && onGround) { 
      cell=Slide;
      image(cell, -100*0.3, -80*0.5, 100, 80);
    } else {
      if (jumpCount==2) { 
        image(cell, -w*0.5, -h*0.5, w, h);
      } else if (jumpCount==1) {
        cell=Jump;
        image(Jump, -w*0.5, -h*0.5, 100, 80);
      } else {
        cell=FrontFlip;
        image(cell, -w*0.5, -h*0.5, 100, 80);
      }
    }
    popMatrix();
    if (punching && punchCooldown==0)punch();
    // smash();
  }
  void collision() {
    if (invis==0) {
      lives--;
      playSound(ughSound);
      screenAngle=-6;
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
      playSound(jumpSound);
      if (jumpCount==1) particles.add( new SpinParticle( this));
      jumpCount--;
      vy=-20;
    }
  }

  void accel() {
    if (vx<MAX_SPEED)vx++;
  }
  void deAccel() {
    if (vx>0)vx--;
  }
  void duck() {
    if (!onGround) { 
      vy=24;
      entities.add(new LineParticle(int(x+w*0.5), int(y+h), 10, 0));
    }
    if (jumpCount<2 && !ducking)entities.add(new LineParticle(int(x+w), int(y+h*2), 60, 80));
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
    invis-=1*speedFactor;
    if (invis<1)invis=0;
    //angle=-22;
  }
  void startPunch() {
    if (punchCooldown<=0 && !punching) {
      playSound(sliceSound);
      if (ducking) { 
        entities.add(new slashParticle(int(p.x), int(p.y), 2));
              punchTime=20;

      } else if( jumpCount==0 ){
            entities.add(new slashParticle(int(p.x), int(p.y), 3));
              punchTime=40;
      } 
      
      else {
        entities.add(new slashParticle(int(p.x), int(p.y), 0));
              punchTime=30;

      }
      punching=true;
    }
  }
  void punch() {

    //   fill(255, 0, 0);  // hitbox
    //  rect(x+w, y, punchRange, 75);
    if (punchTime<0) {
      punching=false;
      punchCooldown=PUNCH_MAX_CD;
    } else {
      punchTime-= 1*speedFactor;
      if (ducking) {
      } else {
        if (int(punchTime)==15 ) {
          entities.add(new slashParticle(int(p.x), int(p.y), 1));
          playSound(diceSound);
        }
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
    usedPowerup=null;
  }

  void spawnSpeedEffect() {
    if (int(random(60/speedFactor))<vx)particles.add(new speedParticle(int(x+w), int(random(90)+p.y)));
  }
}

