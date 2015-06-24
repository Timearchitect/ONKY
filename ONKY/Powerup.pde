class Powerup extends Entity implements Cloneable {
  PImage icon;
  float angle, offsetX, offsetY;
  int  time;
  color powerupColor= color(255);
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
    fill(powerupColor);
    ellipse(x+offsetX, y+offsetY, w, h);
    if (icon!=null)image(laserIcon, x+offsetX, y+offsetY, 80, 80);
  }
  void hitCollision() {
    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("killed powerup");  
      collect();
    }
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("Grab!!!!"); 
      collect();
    }
  }
  void collect() {
    tokens++;
    playSound(collectSound);
    p.usedPowerup=this;
    particles.add( new SpinParticle( int(x), int(y)));
    death();
  }
  void death() {
    super.death();
    tokens++;
  }
  void use() {
    time--;
    background(powerupColor);
    if (time<=0)death();
  }
  void displayIcon() {
    fill(powerupColor);
    rect(50, 100, 100, 100);
    image(laserIcon, 50+10, 100+10, 100-20, 100-20);
  }
  public Powerup clone()throws CloneNotSupportedException {  
    return (Powerup)super.clone();
  }
}


class invisPowerup extends Powerup {
  int  time;
  invisPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    time=_time;
    powerupColor=color(255, 100, 0);
    x=_x;
    y=_y;
    w=100;
    h=100;

  }
  /*void update() {
   x+=vx*speedFactor;
   y+=vy*speedFactor;
   collision();
   }
   void display() {
   super.display();
   }*/

  void collect() {

    playSound(collectSound);
    particles.add( new SpinParticle(  int(x), int(y)));
    p.usedPowerup=this;     
    //    death();
  }
  void use() {
    p.invis=4000;
    time--;
    //  tokens++;
    if (time<=0)death();
  }
}
class LaserPowerup extends Powerup {
  long  time, spawnTime;
  LaserPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    time=_time;
    spawnTime=millis();
    powerupColor=color(255, 0, 0);
    x=_x;
    y=_y;
    w=100;
    h=100;
  }

  void collect() {

    playSound(collectSound);
    particles.add( new SpinParticle(int(x), int(y)));
    try {
      p.usedPowerup=this.clone();
    }
    catch(CloneNotSupportedException e) {
    }      
    //    death();
  }
  void use() {
    if (time%7==0)projectiles.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, p.vx+20, 0));
    time-=1*speedFactor;
    if (time<=0)death();
  }
}

