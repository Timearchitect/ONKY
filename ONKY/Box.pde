class Box extends Obstacle {
  int type;
  Box(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(120, 120, 80);
    health=2;
  }
  Box(int _x, int _y, int _type) {
    this(_x, _y);
    type=_type;
  }
  void death() {
    super.death();
    if (type==1)  entities.add(new RandomPowerup(int(x+w*0.5), int(y+h*0.5), 500)); 
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
    for (int i =0; i< 8; i++) {
      entities.add( new BoxDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }
  void display() {
    super.display();
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
  }
  void hit() {
    super.hit();
    scaleFactor+=scaleFactor*0.05;
    skakeFactor=50;
  }
  void knock() {
    super.knock();
    skakeFactor=100;
  }
  void knockSound() {
    playSound(boxKnockSound);
  }
  void destroySound() {
    playSound(boxDestroySound);
  }
}

class Tire extends Obstacle {

  Tire(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(0, 0, 0);
    health=3;
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
    playSound(rubberSound);
    for (int i =0; i< 5; i++) {
      entities.add( new TireDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }
  void hit() {
    super.hit();
    skakeFactor=50;
  }
  void surface() {
    if (!p.invincible)if (p.vx>9)p.vx*=0.82;
    if (int(random(9/speedFactor))==0)entities.add( new TireDebris(this, int(p.x), int(y), random(20)+p.vx-10, -random(20)));
  }
}
class IronBox extends Obstacle {
  float tx, ty;
  IronBox(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(150, 150, 150);
    tx=_x;
    ty=_y;
  }
  void display() {
    super.display();
    stroke(250, 250, 250);
    strokeWeight(8);
    point(x+10, y+10);
    point(x+w-10, y+10);
    point(x+w-10, y+h-10);
    point(x+10, y+h-10);

    strokeWeight(1);
  }
  void update() {
    super.update();
    float diffX=tx-x, diffY=ty-y;
    x+=diffX*0.2*speedFactor;
    y+=diffY*0.2*speedFactor;
  }
  void death() {
    if (p.invincible)super.death();
  }
  void hit() {  // hit by punching & smashing
    super.hit();
    skakeFactor=50; 
    hitBrightness=255;
    x+=p.vx;
    y+=-p.vy;
  }
  void knock() {
    super.knock();
    skakeFactor=100; 
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
    if (p.invincible)super.death();
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
    rect(x, y, w, h);
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
    skakeFactor=10;
    if (!p.invincible)p.vx*=0.8;
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
  Block(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(100, 100, 100);
    w=200;
    h=200;
    health=8;
  }
  void death() {
    //entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
    for (int i =0; i< 1; i++) {
      entities.add( new BoxDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }
  void display() {
    image(Block, x, y, w, h);
  }
  void update() {
    super.update();
    vx*=0.95;
    if (vx>1) entities.add( new smokeParticle( int(x+random(w)-w*0.5), int(y+h), random(15), random(10)-10));
  }

  void hit() {
    super.hit();
    vx+=(p.vx+6)*0.2;
    //  scaleFactor+=scaleFactor*0.05;
    //  skakeFactor=50;
  }
  void knock() {
    super.knock();
    skakeFactor=100;
  }
  void knockSound() {
    playSound(boxKnockSound);
  }
  void destroySound() {
    playSound(boxDestroySound);
  }
}

class Bush extends Obstacle {
  Bush(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(0, 255, 50);
    w=100;
    h=100;
    health=1;
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
    for (int i =0; i< 8; i++) {
      entities.add( new BushDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }
  void display() {
    image(Bush, x, y, w, h);
    //fill(obstacleColor);
    //rect( x, y, w, h);
  }

  void hit() {
    // super.hit();
    // vx+=(p.vx+6)*0.2;
    super.hit();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 100));
    for (int i =0; i< 6; i++) {
      entities.add( new BushDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(40)+impactForce*2, random(20)-20));
    //  scaleFactor+=scaleFactor*0.05;
    //  skakeFactor=50;
  }
  }
  void knock() {
    super.knock();
    for (int i =0; i< 1; i++) {
      entities.add( new BushDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
    //skakeFactor=100;
  }
  void knockSound() {
    playSound(boxKnockSound);
  }
  void destroySound() {
    playSound(boxDestroySound);
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("collision!!!!"); 
      if (p.vx>5) {
        knock();
      }
      impactForce=p.vx; 
      // death();
    }
  }
}


// kommentar

// hejasn

