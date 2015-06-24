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
    if (icon!=null)image(laserIcon, x-w*0.5+offsetX, y-h*0.5+offsetY, 100, 100);
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
    if(icon!=null)image(icon, 50+10, 100+10, 100-20, 100-20);
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
  void collect() {
    playSound(collectSound);
    particles.add( new SpinParticle(  int(x), int(y)));
    p.usedPowerup=this;     
    p.vx+=10;
    death();
  }
  void use() {
    p.invis=2000;
    p.invincible=true;  // activates supermario starpower
       BGM.pause();
    BGM = minim.loadFile("Super Mario - Invincibility Star.mp3");
    playSound(BGM);
    time--;
    if (time<=0)death();
  }
}
class LaserPowerup extends Powerup {
  long  time, spawnTime;
  LaserPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    icon=laserIcon;
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
    if (time%6==0)projectiles.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, p.vx+20, random(2)-1));
    time-=1*speedFactor;
    if (time<=0)death();
  }
}

class SlowPowerup extends Powerup {
  long  time, spawnTime;
  SlowPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    time=_time;
    spawnTime=millis();
    powerupColor=color(100, 100, 100);
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
    speedFactor=0.5;
    time-=1*speedFactor;
    if (time<=0)death();
  }
}
class RandomPowerup extends Powerup {
  long  time, spawnTime;
  RandomPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    time=_time;
    spawnTime=millis();
    powerupColor=color(100, 100, 100);
    x=_x;
    y=_y;
    switch(int(random(4))) {
    case 0:
      entities.add( new invisPowerup( _x, _y, _time)); 
      break;
    case 1:
      entities.add( new LaserPowerup( _x, _y, _time) );
      break;

    case 2:
      entities.add( new SlowPowerup( _x, _y, _time) );
      break;
    default:
      entities.add( new Powerup( _x, _y, _time));
    }
    super.death();
  }
}

