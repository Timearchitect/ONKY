class Powerup extends Entity {
  PImage icon;
  float angle, offsetX, offsetY;
  int  time;
  Powerup(int _x, int _y, int _time) {
    super(_x, _y);
    powerups.add( this);
    time=_time;
    x=_x;
    y=_y;
    w=100;
    h=100;
  }
  void update() {
    angle+=8;
    offsetX=cos(radians(angle))*14;
    offsetY=sin(radians(angle))*14;
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    collision();
  }
  void display() {
    fill(255);
    ellipse(x+offsetX, y+offsetY, w, h);
  }
  void hitCollision() {
    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("killed powerup");  
      playSound(collectSound);
      p.usedPowerup=this;
      particles.add( new SpinParticle( int(x), int(y)));
      death();
    }
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("Grab!!!!"); 
      playSound(collectSound);
      particles.add( new SpinParticle( int(x), int(y)));
      p.usedPowerup=this;
      death();
    }
  }
  void use() {
    time--;
    tokens++;
    background(255, 0, 0);
    if (time<=0)death();
  }
}


class invisPowerup extends Powerup {
  PImage icon;
  int  time;
  invisPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    time=_time;
    x=_x;
    y=_y;
    w=100;
    h=100;
  }
  void update() {
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    collision();
  }
  void display() {
    fill(255,100,0);
    ellipse(x, y, w, h);
  }
  void hitCollision() {
    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("killed powerup");  
      playSound(collectSound);
      p.usedPowerup=this;
      particles.add( new SpinParticle(  int(x), int(y)));
    //  death();
    }
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("Grab!!!!"); 
      playSound(collectSound);
      particles.add( new SpinParticle(  int(x), int(y)));
      p.usedPowerup=this;
      //death();
    }
  }
  void use() {
    p.invis=4000;
    time--;
    tokens++;
    //background(255, 0, 0);
    if (time<=0)death();
  }
}
class LaserPowerup extends Powerup {
  PImage icon;
  int  time;
  LaserPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    time=_time;
    x=_x;
    y=_y;
    w=100;
    h=100;
  }
  void update() {
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    collision();
  }
  void display() {
    fill(255,0,0);
    ellipse(x, y, w, h);
  }
  void hitCollision() {
    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("killed powerup");  
      playSound(collectSound);
      p.usedPowerup=this;
      particles.add( new SpinParticle(  int(x), int(y)));
    //  death();
    }
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("Grab!!!!"); 
      playSound(collectSound);
      particles.add( new SpinParticle(  int(x), int(y)));
      p.usedPowerup=this;
      //death();
    }
  }
  void use() {
   if(time%10==0)projectiles.add( new Projectile(  int(p.x+p.w*0.5), int(p.y+p.h*0.3), 25, 0));
    time--;
    if (time<=0)death();
  }
}
