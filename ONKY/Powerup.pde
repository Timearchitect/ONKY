class Powerup extends Entity implements Cloneable {
  PImage icon;
  float angle, offsetX, offsetY;
  float  time, spawnTime;
  color powerupColor= color(255);
  Powerup(int _x, int _y, int _time) {
    super(_x, _y);
    time=_time;
    spawnTime=_time;
    x=_x;
    y=_y;
    w=100;
    h=100;
    powerups.add( this);
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
    noStroke();
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
    particles.add( new SpinParticle( int(x), int(y)));
    death();
  }
  void death() {
    super.death();
  }
  void use() {
    time--;
    background(powerupColor);
    if (time<=0)death();
  }
  void displayIcon() {
    int index=p.usedPowerup.indexOf(this), interval=120;

    noStroke();
    fill(powerupColor);
    rect(50+index*interval, 100, 100, 100);
    //if (icon!=null)image(icon, 50+10, 100+10, 100-20, 100-20);
    fill(0, 100);
    println(spawnTime +" : "+time);
    arc(50+w*0.5+index*interval, 100+h*0.5, 100, 100, ((PI*2)/spawnTime)*(time)-HALF_PI, PI*2-HALF_PI);
  }// +(PI*2)-((PI*2)/maxHealth)*health

  public Powerup clone()throws CloneNotSupportedException {  
    return (Powerup)super.clone();
  }
}


class invisPowerup extends Powerup {
  invisPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time*2);
    powerups.add( this);
    powerupColor=color(255, 100, 0);
    x=_x;
    y=_y;
    w=100;
    h=100;
  }
  void collect() {
    if (!dead) {
      tokens++;
      playSound(collectSound);
      particles.add( new SpinParticle(int(x), int(y)));
      p.vx=30;
      p.invis=spawnTime;
      p.invincible=true;  // activates supermario starpower
      BGM.pause();
      BGM = minim.loadFile("Super Mario - Invincibility Star.mp3");
      playSound(BGM);
      BGM.loop();

      try {
        p.usedPowerup.add(this.clone());
      }    
      catch(CloneNotSupportedException e) {
      }
      //p.usedPowerup.time+=this.time;
      this.death();
    }
  }
  void use() {
    time-=1*speedFactor;
    if (time<=0)death();
  }
}
class LaserPowerup extends Powerup {
  LaserPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    icon=laserIcon;
    powerupColor=color(255, 0, 0);
    x=_x;
    y=_y;
    w=100;
    h=100;
  }

  void collect() {
    if (!dead) {

      tokens++;
      playSound(collectSound);
      particles.add( new SpinParticle(int(x), int(y)));
      try {
        p.usedPowerup.add(this.clone());
      }    
      catch(CloneNotSupportedException e) {
      }
      //} else {   
      // tokens++;
      //p.usedPowerup.time+=this.time;
      this.death();
    }
  }
  void use() {
    if (p.angle>6) {  
      if (time%2==0)projectiles.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, p.vx+cos(radians(p.angle))*30, -1+sin(radians(p.angle))*30));
    } else {
      if (time%7==0)projectiles.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, p.vx+cos(radians(p.angle))*30, -1+sin(radians(p.angle))*30));
    }
    time-=1*speedFactor;
    if (time<=0)death();
  }
}

class SlowPowerup extends Powerup {
  SlowPowerup(int _x, int _y, int _time) {
    super(_x, _y, int(_time*0.5));
    powerups.add( this);
    powerupColor=color(100, 100, 100);
    x=_x;
    y=_y;
    w=100;
    h=100;
  }

  void collect() {
    tokens++;
    playSound(collectSound);
    particles.add( new SpinParticle(int(x), int(y)));
    try {
      p.usedPowerup.add(this.clone());
    }        
    catch(CloneNotSupportedException e) {
    }

    //tokens++;
    //p.usedPowerup.time+=this.time;
    this.death();
  }
  void use() {
    speedFactor=0.5;
    time-=1*speedFactor;
    if (time<=0)death();
  }
}
class LifePowerup extends Powerup {
  LifePowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    powerupColor=color(50, 255, 50);
    x=_x;
    y=_y;
    w=100;
    h=100;
  }
  void collect() {
    if (!dead) {
      tokens++;
      playSound(collectSound);
      particles.add( new SpinParticle(  int(x), int(y)));
      try {
        p.usedPowerup.add(this.clone());
      }        
      catch(CloneNotSupportedException e) {
      }    
      p.lives++;
      death();
    }
  }
  void use() {
    p.invis=200;
    time-= 1*speedFactor;
    if (time<=0)death();
  }
}
class RandomPowerup extends Powerup {
  RandomPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    powerupColor=color(100, 100, 100);
    x=_x;
    y=_y;
    switch(int(random(5))) {
    case 0:
      entities.add( new invisPowerup( _x, _y, _time)); 
      break;
    case 1:
      entities.add( new LaserPowerup( _x, _y, _time) );
      break;
    case 2:
      entities.add( new SlowPowerup( _x, _y, _time) );
      break;
    case 3:
      entities.add( new LifePowerup( _x, _y, _time) );
      break;
    default:
      entities.add( new Powerup( _x, _y, _time));
    }
    super.death();
  }
}

