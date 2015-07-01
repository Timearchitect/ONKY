class Player {

  long trailspawnTimer;
  ArrayList<Powerup> usedPowerup = new ArrayList<Powerup>() ;
  PImage SpriteSheetRunning, FrontFlip, Life, Jump, DownDash, Slide, cell; //setup
  float x, y, w=100, h=90, vx=5, vy, ax, ay=0.9, angle, decayFactor=0.95;
  final int MAX_LIFE=3, MAX_JUMP=2, PUNCH_MAX_CD=20, SMASH_MAX_CD=50, defaultSpeed=10;
  int cooldown, collectCooldown, jumpHeight=20, jumpCount=MAX_JUMP, downDashSpeed=35, lives= MAX_LIFE;
  int  punchCooldown=PUNCH_MAX_CD, punchRange=100, attractRange, stompRange = 150;
  float punchTime, invis, toSlow;
  int duckTime, duckCooldown, duckHeight=45;
  int smashTime, smashCooldown =SMASH_MAX_CD, smashRange=100;
  boolean dead, onGround, punching, smashing, ducking, invincible, respawning;
  int totalJumps, totalAttacks, totalDucks;
  float averageSpeed;
  color defaultWeaponColor= color(255, 0, 0), weaponColor= defaultWeaponColor;
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
    if (jumpCount<MAX_JUMP-1)angle+=15*speedFactor;

    if (invincible|| 0<invis)recover();
    if (0<collectCooldown)collectCooldown--; // cant collect

    cutSprite(int(x*0.025));    //cutSprite(int(x/40));

    checkIfGround();

    checkDuck();

    checkIfStuck();

    if (millis() > trailspawnTimer+80/speedFactor) {
      entities.add(new TrailParticle(int(x), int(y), cell));
      trailspawnTimer=millis();
    }

    spawnSpeedEffect();
    
    if (respawning)respawn() ;

    for (int i=usedPowerup.size ()-1; i>=0; i--) {  // powerup handeling
      usedPowerup.get(i).use();
      if (usedPowerup.get(i).dead)usedPowerup.remove(usedPowerup.get(i));
    }
  }

  void display() {
    pushMatrix();
    translate(int(x+w*0.5), int(y+h*0.5));
    rotate(radians(angle));
    //fill(255);

    /*stroke(0);  
     fill(playerColor);
     rect(-w*0.5, -h*0.5, w, h*0.5);   // hitbox
     fill(255); 
     rect(-w*0.5, 0, w, h*0.5);*/

    if (invis >1 && invis % 4 <=1) {
      cell.filter(INVERT);
    }

    if (ducking && onGround) { 
      cell=Slide;
      image(cell, -100*0.3, -80*0.5, 100, 80);
    } else {
      if (jumpCount==MAX_JUMP-1) {
        cell=Jump;
        image(Jump, -w*0.5, -h*0.5, 100, 80);
      } else   if (jumpCount==MAX_JUMP) {  // jump ability restored
        image(cell, -w*0.5, -h*0.5, w, h);
      } else {
        cell=FrontFlip;
        image(cell, -w*0.5, -h*0.5, 100, 80);
      }
    }
    popMatrix();
    if (punching && punchCooldown==0)punch();
    // smash();
    fill(0);    
    if (debug)text ("averageSpeed:"+averageSpeed +" totalJump:"+totalJumps +" totalducks:"+totalDucks + " totalAttack:"+totalAttacks, p.x+300, p.y-200, 500, -100);
    //  if (debug)text ("invis:"+invis+" jumpcount:"+jumpCount + " ducking:"+ducking+" punching:"+punching, p.x, p.y, 200, -100);
  }
  void collision() {
    if (invis==0) {
      reduceLife();
    }
    invis=100;
    vx*= -0.5;
  }
  void jump() {
    if (jumpCount>0) {
      totalJumps++;
      onGround=false;
      if (ducking)p.y-=duckHeight;
      h=90;
      ducking=false;
      if (jumpCount==2) {
        entities.add(new LineParticle(int(x+w*0.5), int(y+h), 15, 0));
      }
      playSound(jumpSound);
      if (jumpCount<MAX_JUMP) particles.add( new SpinParticle( this));
      jumpCount--;
      vy=-jumpHeight;
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
      vy=downDashSpeed;
      entities.add(new LineParticle(int(x+w*0.5), int(y+h), 10, 0));
    }
    if (jumpCount<MAX_JUMP && !ducking)entities.add(new LineParticle(int(x+w), int(y+h*2), 60, 80));
    duckTime=50;
    if (!ducking) {
      totalDucks++;
      ducking=true;
      y+=duckHeight;
    }
  }
  void checkIfObstacle(int top) {
    if (top<y+h) { 
      if (punching && ducking && !onGround && jumpCount<MAX_JUMP) stomp(); // stomp attack
      jumpCount=MAX_JUMP;
      onGround=true;
      y=top-h;
      vy=0;
      angle=0;
    } else {
      //  onGround=false;
    }
  }
  void checkIfGround() {
    /*if (floorHeight<y+h) { 
     if (!onGround)   entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.8), 30, 0));
     jumpCount=MAX_JUMP;
     if (punching && ! onGround)stomp() ;
     onGround=true;
     y=floorHeight-h;
     angle=2;
     }*/
  }
  void stomp() {
    playSound(blockDestroySound);
    entities.add(new LineParticle(int(x+w*0.5), int(y+h), 50, 0));
    particles.add(new splashParticle(int(x+w)+50, int(y+h), vx*0.5, 0, 35, weaponColor));
    shakeFactor=60;



    //fill(255, 0, 0);
    // rect( p.x,p.y-50,range,300);
    //rect( p.x-100,p.y+p.h-50  ,(p.x-100)-(p.x+p.w+100), 500);
    for (Obstacle o : obstacles) {
      if (o.x+o.w  > p.x && o.x < p.x+stompRange &&   o.y > p.y-50 &&   o.y+o.h < p.y+250) {
        o.hit();
        o.death();
      }
    }
  }
  void recover() {
    invis-=1*speedFactor;
    if (invis<1) {
      invis=0;
      if (invincible) {  
        p.vx=speedLevel; 
        changeMusic(regularSong);
      }
      invincible=false;
    }
    //angle=-22;
  }
  void startPunch() {
    if (punchCooldown<=0 && !punching) {
      totalAttacks++;
      playSound(sliceSound);
      if (ducking && jumpCount<MAX_JUMP) {      // down dash attack
        entities.add(new slashParticle(int(p.x), int(p.y), 4));
        punchTime=30;
      } else if (ducking) {    // slide attack
        entities.add(new slashParticle(int(p.x), int(p.y), 2));
        punchTime=20;
      } else if ( jumpCount==0 ) {   // jump attack
        entities.add(new slashParticle(int(p.x), int(p.y), 3));
        punchTime=40;
      } else {      // normal attack
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
      if (ducking)p.y-=duckHeight;
      h=90;
      ducking=false;
    } else { // ducking
      h=duckHeight;
      duckTime--;
    }
  }
  void checkIfStuck() {
    if (vx<3)toSlow+=1 *speedFactor ;
    else toSlow=0;
    if (toSlow>100) {
      respawn();
      toSlow=0;
    }
  }
  void cutSprite (int index) {
    final int interval= 160, imageWidth=160, imageheight=130;
    index= int(index%16);
    cell = SpriteSheetRunning.get(index*(interval+1)+1, 0, imageWidth, imageheight);
  }
  void reset() {
    y=floorHeight-h;
    vy=0;
    lives=MAX_LIFE;
    vx=defaultSpeed;
    x=0;

    invis=0;
    attractRange=0;

    totalDucks=0;
    totalJumps=0;
    totalAttacks=0;
    averageSpeed=0;

    punching=false; 
    ducking=false;
    invincible=false;
    usedPowerup.clear();
  }
  void reduceLife() {
    lives--;
    UpdateGUILife(); // updateGUI
    playSound(ughSound);
    screenAngle=-10;
    background(255, 0, 0);
  }
  void respawn() {
    invis=100;
    vx*= -0.5;
    scaleFactor=0.1;
    entities.add(new Lumber(int(p.x-500), int(floorHeight-700), 400, 25, true) );
    x-=400;
    y=-50-h;
    respawning=false;
  }

  void spawnSpeedEffect() {
    if (int(random(60/speedFactor))<vx) {
      particles.add(new speedParticle(int(x+w), int(random(90)+p.y)));
      if (invincible) particles.add(new sparkParticle(int(x+w), int(random(h)+y), 10, color(255, 220, 20)));
    }
  }
}

