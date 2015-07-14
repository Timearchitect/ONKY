class Player {

  long trailspawnTimer;
  ArrayList<Powerup> usedPowerup = new ArrayList<Powerup>() ;
  PImage SpriteSheetRunning, ONKYSpriteSheet, FrontFlip, Life, Jump, DownDash, Slide, cell; //setup
  float x, y, w=100, h=90, vx=5, vy, ax, ay=0.9, angle, decayFactor=0.95;
  final int MAX_LIFE=3, MAX_JUMP=2, PUNCH_MAX_CD=20, SMASH_MAX_CD=50, defaultSpeed=10, MAX_POWERUP_SIZE=16;
  int cooldown, collectCooldown, jumpHeight=20, jumpCount=MAX_JUMP, downDashSpeed=35, lives= MAX_LIFE;
  int  punchCooldown=PUNCH_MAX_CD, punchRange=100, attractRange, stompRange = 150;
  float punchTime, jumpTime, invis, toSlow;
  int duckTime, duckCooldown, duckHeight=45;
  int tauntTime, smashTime, smashCooldown =SMASH_MAX_CD, smashRange=100, attckSpeedReduction;
  boolean taunt=true, dead, onGround, punching, stomping, smashing, ducking, invincible, respawning;
  int totalJumps, totalAttacks, totalDucks, tutorialCourseRetries;
  float averageSpeed;
  final color defaultWeaponColor= color(255, 0, 0);
  color weaponColor= defaultWeaponColor;
  Player() {
    trailspawnTimer=millis();
  }

  void update() {
    if (taunt) {
      if (tauntTime<80) {
        tauntTime++;
        p.vx=0;
      } else {
        taunt=false;
        tauntTime=0;
        entities.add(new SparkParticle(int(x+w), int(y), 50, defaultWeaponColor));
      }
    } else {
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

      //cutSprite(int(x*0.025));    //cutSprite(int(x/40)); legacy

      checkIfGround();

      checkDuck();

      checkIfStuck();

      spawnSpeedEffect();

      if (!onGround)jumpTime+=1*speedFactor;

      //if (respawning)respawn() ;

      for (int i=usedPowerup.size ()-1; i>=0; i--) {  // powerup handeling
        usedPowerup.get(i).use();
        if (usedPowerup.get(i).dead) {
          usedPowerup.remove(usedPowerup.get(i));    
          UpdatePowerupGUILife();
        }
      }
      if (usedPowerup.size()>MAX_POWERUP_SIZE) {
        usedPowerup.remove(usedPowerup.size()-1);
        UpdatePowerupGUILife();
      }
      if (millis() > trailspawnTimer+80/speedFactor) {
        if (ducking && onGround) entities.add(new TrailParticle(int(x), int(y-duckHeight*0.5), cell));
        else entities.add(new TrailParticle(int(x), int(y), cell));
        trailspawnTimer=millis();
      }
      if (punching && punchCooldown==0)punch();

      if (lives<0)gameReset();
    }
  }

  void display() {
    pushMatrix();
    translate(int(x+w*0.5), int(y+h*0.5));
    rotate(radians(angle));
    if (taunt) {
      cell=cutSpriteSheet(int(tauntTime));
      image(cell, -30, -40, 100, 80);
    } else {
      if (ducking && onGround) { 
        cell=cutSpriteSheet(129);
        blink();
        image(cell, -30, -40, 100, 80);
      } else {
        if (jumpCount==MAX_JUMP-1) {
          cell=cutSpriteSheet(130);
          blink();
          image(cell, -w*0.5, -h*0.5, 100, 80);
        } else   if (jumpCount==MAX_JUMP) {  // jump ability restored
          cell=cutSpriteSheet(int(x*0.03%16));
          blink();
          image(cell, -w*0.5, -h*0.5, w, h);
          //image(cell, -w*0.5, -h*0.5, w, h);
        } else {
          cell=cutSpriteSheet(131);
          blink();
          image(cell, -w*0.5, -h*0.5, 100, 80);
        }
      }
    }
    popMatrix();
    // smash();
    fill(0);    
    if (debug)text ("averageSpeed:"+averageSpeed +" totalJump:"+totalJumps +" totalducks:"+totalDucks + " totalAttack:"+totalAttacks, x+300, y-200, 500, -100);
    //  if (debug)text ("invis:"+invis+" jumpcount:"+jumpCount + " ducking:"+ducking+" punching:"+punching, p.x, p.y, 200, -100);
  }
  void collision() {
    if (invis==0) {
      reduceLife();
    }
    if (!tutorial) invis=100;
    vx*= -0.5;
  }
  void jump() {
    if (jumpCount>0) {
      totalJumps++;
      onGround=false;
      if (ducking) {
        y-=duckHeight;
        duckTime=0;
      }
      h=90;
      ducking=false;
      if (jumpCount==2) {
        entities.add(new LineParticle(int(x+w*0.5), int(y+h), 15, 0));
      }
      playSound(jumpSound);
      if (jumpCount<MAX_JUMP) entities.add( new SpinParticle( true));

      if (punching && jumpCount==MAX_JUMP && punchTime>20) { // uppercut
        background(255);
        entities.add(new slashParticle(int(x), int(y), 6));
        for (Obstacle o : obstacles) {
          if (o.y+o.h > y-200 && y +h > o.y &&  o.x+o.w > x && o.x < x+w+200 ) {
            o.impactForce=60;  
            o.hit();
            o.death();
          }
        }
      }

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
      if (punching) entities.add(new slashParticle(int(p.x), int(p.y), 4)); // downdash Attack
    }
    if (attckSpeedReduction<30)attckSpeedReduction=30;  // redused attack cooldown when ducking

    if (jumpCount<MAX_JUMP && !ducking)entities.add(new LineParticle(int(x+w), int(y+h*2), 60, 80));

    if (!ducking) {
      duckTime=50;
      totalDucks++;
      ducking=true;
      y+=duckHeight;
    } else if (ducking && duckTime>0) {      
      duckTime=50;
    }
  }
  void checkIfObstacle(int top) {
    if (top<y+h) { 
      if (punching && ducking && !onGround && jumpCount<MAX_JUMP) stomp(); // stomp attack
      jumpCount=MAX_JUMP;
      onGround=true;
      jumpTime=0;
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

  void blink() {  
    if (invis >1 && invis % 4 <=1) {
      cell.filter(INVERT);
    }
  }
  void stomp() {
    playSound(blockDestroySound);
    entities.add(new LineParticle(int(x+w*0.5), int(y+h), 50, 0));
    entities.add(new splashParticle(int(x+w)+50, int(y+h), vx*0.5, 0, 35, weaponColor));
    entities.add( new smokeParticle(int(x+w*0.5), int(y+h*0.5), -5, 0, 100));
    entities.add( new smokeParticle(int(x+w*0.5), int(y+h*0.5), 10, 0, 100 ));

    if (invincible) {
      entities.add(new splashParticle(int(x+w)+50, int(y+h), vx*0.8, 0, 60, weaponColor));
      shakeFactor=100;
    } else {
      shakeFactor=60;
    }

    //fill(255, 0, 0);
    // rect( p.x,p.y-50,range,300);
    //rect( p.x-100,p.y+h-50  ,(x-100)-(x+w+100), 500);
    for (Obstacle o : obstacles) {
      if (!o.unBreakable && o.x+o.w  > x && o.x < x+stompRange &&   o.y > y-50 &&   o.y+o.h < y+250) {
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
        vx=speedLevel; 
        changeMusic(regularSong);
      }
      invincible=false;
    }
    //angle=-22;
  }
  void startPunch() {
    // fill(255, 0, 0);  // hitbox
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
      } else {     
        if (jumpTime!=0 && jumpTime<=8) { // uppercut
          background(255);
          entities.add(new slashParticle(int(p.x), int(p.y), 6));
          for (Obstacle o : obstacles) {
            if (o.y+o.h > p.y-200 && p.y +p.h > o.y &&  o.x+o.w > p.x && o.x < p.x+p.w+200 ) {
              o.impactForce=60;  
              o.hit();
              o.death();
            }
          }
        } else {
          entities.add(new slashParticle(int(p.x), int(p.y), 0)); // normal attack
        }
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
      if (invincible)  punchCooldown=PUNCH_MAX_CD-attckSpeedReduction; 
      else punchCooldown=PUNCH_MAX_CD;
    } else {
      punchTime-= 1*speedFactor;
      if (ducking) {
      } else {
        if (int(punchTime)==15 ) {
          entities.add(new slashParticle(int(x), int(y), 1));
          playSound(diceSound);
        }
        if (invincible && int(punchTime)==20) {
          entities.add(new slashParticle(int(x+120), int(y), 4));
          playSound(sliceSound);
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
      attckSpeedReduction=0;
      h=90;
      ducking=false;
    } else { // ducking
      h=duckHeight;
      duckTime--;
    }
  }
  void checkIfStuck() {
    if (vx<5)toSlow+=1 *speedFactor ;
    else toSlow=0;
    if (toSlow>90) {     
      speedFactor=0.02;
      for (int i=0; i<360; i+=60) {
        entities.add( new smokeParticle(int(x+w*0.5), int(y), -sin(radians(i))*8, cos(radians(i))*5, 400));
      }
      playSound(Poof);
      entities.add( new WoodDebris(int(x+w*0.5), int(y), 0, -10));
      if (tutorial)tutorialRespawn() ;
      else respawn();
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
    angle=0;
    weaponColor=defaultWeaponColor;
    invis=0;
    attractRange=0;

    totalDucks=0;
    totalJumps=0;
    totalAttacks=0;
    averageSpeed=0;

    taunt=true;
    respawning=false;
    punching=false; 
    ducking=false;
    invincible=false;
    usedPowerup.clear();
  }
  void reduceLife() {
    if (tutorial) {
      tutorialRespawn();
    } else {
      lives--;
      playSound(ughSound);
      screenAngle=-10;
      background(255, 0, 0);
      UpdateGUILife(); // updateGUI
    }
  }
  void respawn() {
    usedPowerup.clear();
    angle=0;
    invis=100;
    vx*= -0.5;
    scaleFactor=0.1;
    x-=400;
    y=-50-h;
    for (Obstacle o : obstacles) {
      if (o.y+o.h > y && y +h > o.y &&  o.x > x-400 && o.x+o.w < x+w ) {
        o.impactForce=60;  
        o.health=0;
        o.death();
      }
    }
    entities.add(new slashParticle(int(x+400), int(y+h), 5, 400));
    entities.add(new Lumber(int(x), int(floorHeight-700), 400, 25, true) );
    respawning=false;
    UpdateGUILife(); // updateGUI
  }
  void tutorialRespawn() {
    invis=10;
    speedFactor=0.01;
    vx*= -0.5;
    duckTime=0;
    // scaleFactor=0.1;
    usedPowerup.clear();
    UpdatePowerupGUILife();
    jumpCount=MAX_JUMP;
    angle=0;
    duckTime=0;
    ducking=false;
    onGround=true;
    punching=false;
    x-=1800;
    y=floorHeight-200+h;
    respawning=false;
    tutorialCourseRetries++;
    background(0);
    if (tutorialCourseRetries>2) {
      automate=true;
      speedFactor=0.001;
      vx*= -0.4;
    }
    if (tutorialCourseRetries>0)hint=true;
    for (Obstacle o : obstacles) {
      println("hedfsdffa");
      if (o.regenerating)o.regenerate();
    }
    for (Powerup pow : powerups) {
      println("hedfsdffa");
      if (pow.regenerating)pow.regenerate();
    }
  }

  PImage cutSpriteSheet(int index ) {
    final int imageheight=135;
    //index= int(index%16);
    int row=0, imageWidth=160, rowAmount=16;
    if (index < 16) {
      row=0; 
      imageWidth=160;
      rowAmount=16;
    } else if (index < 32) {
      row=1; 
      imageWidth=160;
      rowAmount=16;
    } else if (index < 48) {
      row=2;  
      imageWidth=190;
      rowAmount=16;
    } else if (index < 64) {
      row=3; 
      imageWidth=190;
      rowAmount=16;
    } else if (index < 80) {
      row=4; 
      imageWidth=190;
      rowAmount=16;
    } else if (index < 96) {
      row=5; 
      imageWidth=190;
      rowAmount=16;
    } else if (index < 112) {
      row=6; 
      imageWidth=190;
      rowAmount=16;
    } else if (index < 128) {
      row=7; 
      imageWidth=190;
      rowAmount=16;
    } else if (index < 133) {
      row=8; 
      imageWidth=160;
      rowAmount=5;
    } else if (index < 140) {
      row=9;  
      imageWidth=190;
      rowAmount=7;
    } 

    index=index%rowAmount;

    return ONKYSpriteSheet.get(index*(imageWidth+1)+1, row*imageheight+1, imageWidth, imageheight);
  }

  void spawnSpeedEffect() {
    if (int(random(60))<vx*speedFactor) {
      entities.add(new speedParticle(int(x), int(random(90)+y)));
      if (invincible) entities.add(new SparkParticle(int(x), int(random(h)+y), 20, color(255, 220, 20)));
    }
  }
}

