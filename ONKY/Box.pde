class Box extends Obstacle {
  int type, count;
  Box(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(180, 140, 50);
    health=2;
    type=int(random(3));
  }
  Box(int _x, int _y, int _type) {
    this(_x, _y);
    type=_type;
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
    entities.add( new smokeParticle( int(x+w*0.5), int(y+h*0.5), 0, 0, 300, obstacleColor));
    if (type==-1)  entities.add(new RandomPowerup(int(x+w*0.5), int(y+h*0.5), 500)); 
    if (type==2)  for (int i=0; i <3; i++)  entities.add(new TokenPowerup(int(x+random(w)), int(y+random(h)), 500)); 
    for (int i =0; i< 8; i++) {
      entities.add( new BoxDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }
  void display() {
    super.display();
    /*
    stroke(155, 155, 100);
     strokeWeight(8);
     line(x, y, x+w, y+h);
     line(x, y+h, x+w, y);
     if (type==1) { 
     fill(255, 255, 180);
     textAlign(CENTER);
     textSize(160);
     text("?", x+w*0.5, y+h*0.8);
     textAlign(LEFT);
     }
     strokeWeight(1);
     */
    switch(type) {
    case 0:
      image(Box, x, y, w, h);
      break;
    case 1:
      image(brokenBox, x, y, w, h);
      break;
    case 2:
      image(brokenBox, x, y, w, h);
      if (count%20==0)entities.add(new SparkParticle(int(x+w*0.8), int(y+h*0.2), 40, 255));
      break;
    default:
      image(mysteryBox, x, y, w, h);
    }
    /* if (type==0) image(Box, x, y, w, h);
     else if (type==1) image(brokenBox, x, y, w, h);
     else if (type==2) {
     image(brokenBox, x, y, w, h);
     if (count%20==0)entities.add(new SparkParticle(int(x+w*0.8), int(y+h*0.2), 20, 255));
     } else image(mysteryBox, x, y, w, h);*/
  }
  void update() {
    super.update();
    count++;
    if (p.attractRange > 0 && type==2 && dist(x, y, p.x+p.w*0.5, p.y+p.h*0.5)<p.attractRange) {
      type=1;
      for (int i=0; i<3; i++)entities.add(new TokenPowerup(int(x+random(w)), int(y+random(h)), 500));
    }
  }
  void hit() {
    super.hit();
    scaleFactor+=scaleFactor*0.05;
    shakeFactor=50;
  }
  void knock() {
    super.knock();
    shakeFactor=100;
  }
  void knockSound() {
    playSound(boxKnockSound);
  }
  void destroySound() {
    playSound(boxDestroySound);
  }
}

class Tire extends Obstacle {
  float radianer, offset;
  Tire(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(0, 0, 0);
    health=3;
    switch(int(random(4))) {
    case 0:
      radianer = HALF_PI;
      break;
    case 1:
      radianer = PI;
      break;
    case 2:
      radianer = PI+HALF_PI;
      break;
    case 3:
      radianer = PI*2;
      break;
    }
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
    entities.add( new smokeParticle( int(x+w*0.5), int(y+h*0.5), 0, 0, 300, obstacleColor));
    playSound(rubberKnockSound);
    for (int i =0; i< 5; i++) {
      entities.add( new TireDebris(this, int(x+random(w)-w*0.5+50), int(y+random(h)-h*0.5+50), random(15)+impactForce*0.4, random(30)-20));
    }
  }
  void update() {
    super.update();
    if (offset>0) offset--;
  }
  void hit() {
    super.hit();
    scaleFactor+=scaleFactor*0.05;
    shakeFactor=50;
  }
  void display() {
    pushMatrix();
    translate(x+w*0.5+random(-offset, offset), y+h*0.5+random(-offset, offset));
    rotate(radianer);
    image(Tire, -w*0.5-10, -h*0.5-10, w+20, h+20);
    popMatrix();
  }
  void knock() {
    super.knock();
    offset=6;
  }
  void knockSound() {
    playSound(rubberKnockSound);
  }
  void surface() {
    offset=6;
    if (p.vx>9)p.vx*=0.84;
    if (int(random(15/speedFactor))==0)entities.add( new TireDebris(this, int(p.x), int(y), random(20)+p.vx-10, -random(20)));
  }
}
class IronBox extends Obstacle {
  int tx, ty, invis;
  IronBox(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(200);
    tx=_x;
    ty=_y;
    health=5;
  }
  void display() {
    super.display();
    /* stroke(250, 250, 250);
     strokeWeight(8);
     point(x+10, y+10);
     point(x+w-10, y+10);
     point(x+w-10, y+h-10);
     point(x+10, y+h-10);
     
     strokeWeight(1);
     */

    if (health==5) {
      image(ironBox, x, y, w, h);
    } else if (health>2) {
      image(ironBox2, x, y, w, h);
    } else {
      image(ironBox3, x, y, w, h);
    }
  }
  void update() {
    super.update();
    if (invis>0)invis--;
    if (x!=tx &&  y!=ty) {
      float diffX=tx-x, diffY=ty-y;
      x+=diffX*0.2*speedFactor;
      y+=diffY*0.2*speedFactor;
      if (x==tx)x=tx;
      if (y==ty)y=ty;
    }
  }
  void death() {
    if (p.invincible || health<=0) {
      super.death();
      entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
      entities.add( new smokeParticle( int(x+w*0.5), int(y+h*0.5), 0, 0, 500));
      for (int i =0; i< 3; i++) {
        entities.add( new IronBoxDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.3, random(20)-10));
      }
      playSound(ironBoxDestroySound);
    }
  }
  void hit() {  // hit by punching & smashing
    if (invis<1) {
      super.hit();
      shakeFactor=50; 
      hitBrightness=255;
      x+=p.vx;
      y+=p.vy;
      invis=15;
    }
  }
  void knock() {
    super.knock();
    shakeFactor=100; 
    hitBrightness=255;
  }
  void knockSound() {
    playSound(ironBoxDestroySound);
  }
  void  hitSound() {
    playSound(ironBoxDestroySound);
  }
}

class PlatForm extends Obstacle {
  boolean hanging;

  PlatForm(int _x, int _y, int _w, int _h) {
    super(_x, _y);
    w=_w;
    h=_h;
    health=4;
    obstacleColor = color(255, 50, 50);
  }
  PlatForm(int _x, int _y, int _w, int _h, boolean _hanging) {
    this( _x, _y, _w, _h);
    hanging=_hanging;
  }
  void display() {
    super.display();
    if (hanging) {
      stroke(200, 200, 200);
      strokeWeight(6);
      line(x, -1000, x, y);
      line(x+w, -1000, x+w, y);
      strokeWeight(1);
    }
  }
  void death() {
    if (p.invincible ||health<=0) {
      super.death();
      playSound(ironBoxDestroySound);
      for (int i= 0; i<w; i+=100) {
        entities.add( new PlatFormDebris(this, int(x+i+100)-50, int(y), random(15)+impactForce*0.3, random(30)-20));
      }
    }
  }
  void hitCollision() {  // hit by punching & smashing
  }
}

class Lumber extends Obstacle {
  boolean hanging;

  Lumber(int _x, int _y, int _w, int _h) {
    super(_x, _y);
    w=_w;
    h=_h;
    health=4;
    obstacleColor = color(182, 69, 0);
  }
  Lumber(int _x, int _y, int _w, int _h, boolean _hanging) {
    this( _x, _y, _w, _h);
    hanging=_hanging;
  }
  void display() {
    //super.display();
    image(lumber, x, y, w, h);
    if (hanging) {
      for (int i= 0; i > -1000; i-=40) {
        image(Vines, x, y-80+i, 32, 80);
        image(Vines, x+w-32, y-80+i, 32, 80);
      }
      /*  stroke(0, 180, 0);
       strokeWeight(6);
       line(x, -1000, x, y);
       line(x+w, -1000, x+w, y);
       strokeWeight(1);*/
    }
  }
  void death() {
    if (p.invincible ||health<=0) {
      super.death();
      playSound(ironBoxDestroySound);
      for (int i= 0; i<w; i+=100) {
        entities.add( new PlatFormDebris(this, int(x+i+100)-50, int(y), random(15)+impactForce*0.3, random(30)-20));
      }
    }
  }
  void hitCollision() {  // hit by punching & smashing
  }
}

class Glass extends Obstacle {

  Glass(int _x, int _y, int _w, int _h) {
    super(_x, _y);
    w=_w;
    h=_h;
    obstacleColor = color(0, 150, 255, 100);
    health=1;
  }

  void display() {
    super.display();
    image(glass, x, y, w, h);
    // rect(x, y, w, h);
  }

  void destroySound() {
    playSound(shatterSound);
  }
  void hit() {
    super.hit();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 100));
    for (int i =0; i< 6; i++) {
      entities.add( new GlassDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(40)+impactForce*2, random(20)-20));
    }
  }

  void knock() {
    // super.knock();
    scaleFactor+=scaleFactor*0.05;
    shakeFactor=10;
    p.vx*=0.8;
    for (int i =0; i< 6; i++) {
      entities.add( new GlassDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
    death();
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h+p.vy > y-5 &&  p.y+p.h-5 < y +20) {
      p.checkIfObstacle(y-5);
      surface();
    } else {
      if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
        if (p.vx>5) {
          knock();
        }
        impactForce=p.vx;
      }
    }
  }
}
class Block extends Obstacle {
  int invis;
  float ay=2;
  boolean scale;
  Block(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(100, 100, 100);
    w=200;
    h=200;
    health=20;
  }
  Block(int _x, int _y, int _vx, int _vy) {
    this(_x, _y);
    vx=_vx;
    vy=_vy;
  }
  void damage(int i) {
    hitBrightness=100;
    health-=i;
    //if (health<=0)death();
    invis=4;
  }
  void death() {
    //entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));

    if (p.invincible && invis>0) {
      vy=-100;
      shakeFactor=300;
      scaleFactor=0.8;
      vx=-p.vx;
      playSound(smackSound);
      for (int i =0; i< 5; i++)  entities.add( new BoxDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(50)+impactForce*0.5, random(30)-50));
    }
    invis=20;
  }
  void display() {
    if (invis>0)image(BlockSad, x, y, w, h);
    else image(Block, x, y, w, h);
  }
  void update() {
    super.update();
    if (invis>0)invis--;
    vx*=0.95;
    vy*=0.95;
    gravity();
    if (vx>2) entities.add( new smokeParticle( int(x+random(w)-w*0.5), int(y+h), random(15), random(10)-5, 200));
  }
  void gravity() {
    if (y+h<floorHeight)vy+=ay;
    else {
      y=floorHeight-h;
    }
  }
  void hit() {
    super.hit();
    vx+=(p.vx+6)*0.2;
    invis=20;
  }
  void knock() {
    super.knock();
    if (abs(vx)>10) { 
      playSound(smackSound);
      speedFactor=0.5;
      background(255);
    }
    shakeFactor=100;
  }
  void knockSound() {
    playSound(boxKnockSound);
  }
  void destroySound() {
    playSound(boxDestroySound);
  }
}

class Bush extends Obstacle {
  int debrisCooldown;
  Bush(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(0, 255, 50);
    w=100;
    h=100;
    health=1;
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 100));
    for (int i =0; i< 8; i++) {
      entities.add( new BushDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }
  void update() {
    super.update();
    if (debrisCooldown>0)debrisCooldown--;
  }
  void display() {
    image(Bush, x, y, w, h);
    //fill(obstacleColor);
    //rect( x, y, w, h);
  }

  void hit() {
    super.hit();
    for (int i =0; i< 6; i++) {
      entities.add( new BushDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(40)+impactForce*2, random(20)-20));
    }
  }
  void knock() {
    if (p.invincible) death();
    if (debrisCooldown==0) { 
      super.knock();
      entities.add( new BushDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
      debrisCooldown=4;
    }
  }
  void knockSound() {
    playSound(leafSound);
  }
  void destroySound() {
    playSound(leafSound);
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
      if (p.vx>5) {
        knock();
      }
      impactForce=p.vx;
    }
  }
}
class Grass extends Obstacle {
  int margin=25;
  Grass(int _x, int _y, int _w, int _h) {
    super(_x, _y);
    w=_w;
    h=_h;
    obstacleColor = color(128, 181, 113);
    unBreakable=true;
  }
  void death() {
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h+p.vy > y-5 &&  p.y+p.h-5-p.vy < y +20) {
      p.checkIfObstacle(y);
      surface();
      //println("onTop");
    } else {
      if (p.x+p.w > x && p.x < x + w  && p.y+p.h+p.vy > y&&  p.y-p.vy < y + h) {
        // if (p.vx>5) {
        //  if (!p.invincible)  //knock();
        //}
        //if (!p.invincible)p.collision();
        p.checkIfObstacle(y);
      }
    }
  }
  void display() {
    //  super.display();
    fill(obstacleColor);
    noStroke();
    rect(x, y, w, 2000);
    image(Grass, x, y-margin, w, h);
  }

  void hitCollision() {  // hit by punching & smashing
  }
}
class Water extends Obstacle {
  int debrisCooldown;
  float count;
  //PImage cell;
  Water(int _x, int _y, int _w, int _h) {
    super(_x, _y);
    w=_w;
    h=_h;
    obstacleColor = color(81, 104, 151);
    unBreakable=true;
  }
  void update() {
    super.update();
    count+=1*speedFactor;
    count=int(count);
    if (debrisCooldown>0)debrisCooldown--;
  }
  void display() {
    //   super.display();
    /* noStroke();
     
     fill(150, 150, 255);
     rect(x, y, w, 25);*/
    noStroke();
    fill(obstacleColor);
    rect(x, y+50, w, 2000);
    /* if (count%60<10)image(water1, x, y, w, h);
     else if (count%60<20)image(water2, x, y, w, h);
     else if (count%60<30)image(water3, x, y, w, h);
     else if (count%60<40)image(water4, x, y, w, h);
     else if (count%60<50)image(water3, x, y, w, h);
     
     else image(water2, x, y, w, h);*/
    if (count%60<10)image( cutSprite (0), x, y-50, w, h);
    else if (count%60<20)image(cutSprite (1), x, y-50, w, h);
    else if (count%60<30)image(cutSprite (2), x, y-50, w, h);
    else if (count%60<40)image(cutSprite (3), x, y-50, w, h);
    else if (count%60<50)image(cutSprite (2), x, y-50, w, h);
    else image(cutSprite (1), x, y-50, w, h);
  }

  PImage cutSprite (int index) {
    final int interval= 50, imageWidth=50, imageheight=50;
    return waterSpriteSheet.get(index*(interval+1), 0, imageWidth, imageheight);
  }
  void collision() {


    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
      if (p.y>y+150) {
        p.respawning=true;
        if (p.invis==0)p.reduceLife();
      }
      if (p.y>y+h*0.5) {
        p.vx*=0.8;
        if (debrisCooldown==0) {
          entities.add(new splashParticle(int(p.x), int(y+30), 15, 0, 30, obstacleColor));
          entities.add(new splashParticle(int(p.x), int(y+30), 0, 0, 60, obstacleColor));
          entities.add(new splashParticle(int(p.x), int(y+30), -15, 0, 30, obstacleColor));
          playSound(splash);
          debrisCooldown=10;
        }
      }

      if (p.invincible) { // onGround
        if (p.vy>0)p.vy=0;
        p.y=y-p.h;
        p.onGround=true;
        p.jumpCount=p.MAX_JUMP;
        if (debrisCooldown==0) {
          playSound(waterFall);
          entities.add(new splashParticle(int(p.x), int(y+30), vx*0.5, 0, 50, obstacleColor));
          debrisCooldown=3;
        }
      }
      impactForce=p.vx;
    }
  }

  void death() {
  }
}
class Sign extends Obstacle {
  int debrisCooldown;
  String text;
  boolean trigg;
  Sign(int _x, int _y, String _text) {
    super(_x, _y);
    obstacleColor = color(220, 180, 90);
    w=200;
    h=200;
    health=1;
    text=_text;
  }
  Sign(int _x, int _y, String _text, boolean _trigg) {
    this(_x, _y, _text);
    trigg=_trigg;
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 100));
    for (int i= 0; i<3; i++) {
      entities.add( new PlatFormDebris(this, int(x)-50, int(y), random(15)+impactForce*0.3, random(30)-20));
    }
    if (trigg)tutorial=false;
  }
  void update() {
    super.update();
    if (debrisCooldown>0)debrisCooldown--;
  }
  void display() {
    image(sign, x, y, w, h);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(text, x+w*0.5, y+h*0.5);
  }

  void hit() {
    super.hit();
  }
  void knock() {
    if (p.invincible) death();
  }
  void knockSound() {
    playSound(boxKnockSound);
  }
  void destroySound() {
    playSound(boxDestroySound);
  }
  void collision() {
  }
}
class Snake extends Obstacle {
  int debrisCooldown;
  float count;
  int snakeSpeed = -int(random(16)+1);
  Snake(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(0, 255, 50);
    w=82*2;
    h=35*2;
    health=1;
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 100));
    for (int i =0; i< 8; i++) {
      entities.add( new BushDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }
  void update() {
    super.update();
    count+=1*speedFactor;
    /*
    if (count%30<10) x-=1*speedFactor;
     else if (count%30<20) x -= snakeSpeed+1;
     else x-=1*speedFactor;
     
     x-=1*speedFactor;
     */
    if (count%30<20  && count%30>10) x += snakeSpeed*speedFactor;
    else
      if (debrisCooldown>0)debrisCooldown--;
  }
  void display() {
    // image(Snake, x, y, w, h);
    //fill(obstacleColor);
    //rect( x, y, w, h);
    if (count%30<10)image( cutSprite (0), x+w*.5, y-30, w, h);
    else if (count%30<20)image(cutSprite (2), x+w*.5, y-40, w, h);
    else image(cutSprite (1), x+w*.5, y-20, w, h);
  }

  PImage cutSprite (int index) {
    final int interval= 82, imageWidth=82, imageheight=35;
    return Snake.get(index*(interval+1), 0, imageWidth, imageheight);
  }

  void hit() {
    super.hit();
    for (int i =0; i< 6; i++) {
      entities.add( new BushDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(40)+impactForce*2, random(20)-20));
    }
  }
  void knock() {
    if (p.invincible) death();
    if (debrisCooldown==0) { 
      super.knock();
      entities.add( new BushDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
      debrisCooldown=10;
    }
  }
  void knockSound() {
    playSound(leafSound);
  }
  void destroySound() {
    playSound(bloodSound);
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
      if (p.vx>5) {
        knock();
      }
      impactForce=p.vx;
    }
  }
}

class Barrel extends Obstacle {
  // int debrisCooldown;
  float angle;
  Barrel(int _x, int _y) {
    super(_x, _y+67);
    obstacleColor = color(180, 120, 50);
    w=67*2;
    h=67*2;
    health=1;
    vx=-2;
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 100));
    entities.add( new smokeParticle( int(x+w*0.5), int(y+h*0.5), 0, 0, 300));
    for (int i =0; i< 8; i++) {
      entities.add( new PlatFormDebris(this, int(x)-50, int(y), random(15)+impactForce*0.3, random(30)-20));

      //  entities.add( new BoxDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }
  void update() {
    super.update();
    angle+=vx*2*speedFactor;
  }
  void display() {
    // image(Snake, x, y, w, h);
    //fill(obstacleColor);
    //rect( x, y, w, h);
    pushMatrix();
    translate(x+w*0.5, y+h*0.5);
    rotate(radians(angle));
    image( Barrel, -w*0.5, -w*0.5, w, h);
    popMatrix();

    /* if (count%40<10)image( cutSprite (0), x, y-135, w, h);
     else if (count%40<20)image(cutSprite (1), x, y-140, w, h);
     else if (count%40<30)image(cutSprite (2), x, y-145, w, h);
     else image(cutSprite (3), x, y-140, w, h);*/
  }
  /*
  PImage cutSprite (int index) {
   final int interval= 67, imageWidth=67, imageheight=67;
   return Barrel.get(index*(interval+1), 0, imageWidth, imageheight);
   }
   */


  void hit() {
    super.hit();
    scaleFactor+=scaleFactor*0.05;
    shakeFactor=50;
  }
  void knock() {
    super.knock();
    impactForce=p.vx;
    death();
    shakeFactor=100;
  }
  void knockSound() {
    playSound(boxKnockSound);
  }
  void destroySound() {
    playSound(boxDestroySound);
  }
}

class Rock extends Obstacle {
  int invis;
  Rock(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(150);
    health=7;
  }
  void display() {

    image(rock, x, y, w, h);
  }
  void update() {
    if (invis>0)invis--;
    super.update();
    //if (x!=tx &&  y!=ty) {
    // float diffX=tx-x, diffY=ty-y;
    //x+=diffX*0.2*speedFactor;
    //y+=diffY*0.2*speedFactor;
    //if (x==tx)x=tx;
    //if (y==ty)y=ty;
    // }
  }
  void death() {
    if (p.invincible || health<=0) {
      super.death();
      entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
      entities.add( new smokeParticle( int(x+w*0.5), int(y+h*0.5), 0, 0, 500, obstacleColor));

      for (int i =0; i< 10; i++) {
        entities.add( new RockDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.3, random(20)-10));
      }
      playSound(blockDestroySound);
    }
  }
  void hit() {  // hit by punching & smashing
    if (invis<1) {
      super.hit();
      shakeFactor=50; 
      //hitBrightness=255;
      invis=20;
    }
  }
  void knock() {
    super.knock();
    shakeFactor=100; 
    // hitBrightness=255;
  }
  void knockSound() {
    playSound(blockDestroySound);
  }
  void  hitSound() {
    playSound(ironBoxDestroySound);
  }
}
class stoneSign extends Obstacle {
  int debrisCooldown;
  String text;
  //boolean trigg;
  stoneSign(int _x, int _y, String _text) {
    super(_x, _y);
    obstacleColor = color(150);
    w=400;
    h=200;
    health=5;
    text=_text;
  }
 /* stoneSign(int _x, int _y, String _text, boolean _trigg) {
    this(_x, _y, _text);
    trigg=_trigg;
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 100));
    for (int i= 0; i<3; i++) {
      entities.add( new PlatFormDebris(this, int(x)-50, int(y), random(15)+impactForce*0.3, random(30)-20));
    }
    if (trigg)tutorial=false;
  }*/
  void update() {
    super.update();
    if (debrisCooldown>0)debrisCooldown--;
  }
  void display() {
    image(rockSign, x, y, w, h);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(text, x+w*0.5, y+h*0.5);
  }
  void death() {
    if (p.invincible || health<=0) {
      super.death();
      entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
      entities.add( new smokeParticle( int(x+w*0.5), int(y+h*0.5), 0, 0, 600, obstacleColor));

      for (int i =0; i< 15; i++) {
        entities.add( new RockDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.3, random(20)-10));
      }
      playSound(blockDestroySound);
    }
  }

  void knock() {
    if (p.invincible) death();
  }
  void knockSound() {
      playSound(blockDestroySound);
  }
  void destroySound() {
      playSound(blockDestroySound);
  }
  void collision() {
  }
}

