class Powerup extends Entity implements Cloneable {
  PImage icon= tokenIcon;
  float angle, offsetX, offsetY;
  float  time, spawnTime;
  color powerupColor= color(255);
  Powerup(int _x, int _y, int _time) {
    super(_x, _y);
    icon= tokenIcon;
    time=_time;
    spawnTime=_time;
    x=_x;
    y=_y;
    w=100;
    h=100;
    powerups.add( this);
  }
  void update() {
  if(angle%100==0) particles.add(new sparkParticle(int(x+offsetX*5), int(y+offsetY*5),20, powerupColor));
    angle+=4;
    offsetX=cos(radians(angle))*12;
    offsetY=sin(radians(angle))*12;
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    collision();
  }
  void display() {

    if (icon!=null)image(icon, x-w*0.5+offsetX, y-h*0.5+offsetY, 100, 100);
    else {
      noStroke();
      fill(powerupColor);
      ellipse(x+offsetX, y+offsetY, w, h);
    }
  }
  void hitCollision() {
    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      //println("killed powerup");  
      if (p.collectCooldown<1)collect();
    }
  }
  void collision() {
    if (p.x+p.w > x- w*0.5 && p.x < x + w*0.5  && p.y+p.h > y - h*0.5 &&  p.y < y + h*0.5) {
      //println("Grab!!!!"); 
      if (p.collectCooldown<1)collect();
    }
  }
  void collect() {
    tokens++;
    playSound(collectSound);
    particles.add( new SpinParticle( int(x), int(y),powerupColor));
    death();
  }
  void death() {
    super.death();
  }
  void use() {
    time--;
    background(powerupColor);
    if (time<1)death();
  }
  void displayIcon() {
    int index=p.usedPowerup.indexOf(this), interval=110;
    noStroke();

    // fill(powerupColor);
    // rect(50+index*interval, 100, 100, 100);
    if (icon!=null)image(icon, 50+10+index*interval, 100+10, 100-20, 100-20);
    fill(0, 150);
    //println(spawnTime +" : "+time);
    //arc(50+w*0.5+index*interval, 100+h*0.5, 75, 75, PI*2-(((PI*2)/spawnTime)*(time)+HALF_PI), PI*2-HALF_PI);
    //arc(50+w*0.5+index*interval, 100+h*0.5, 75, 75, (((PI*2)/spawnTime)*(time)-HALF_PI), PI*2-HALF_PI);
    arc(50+w*0.5+index*interval, 100+h*0.5, 75, 75, -HALF_PI, PI*2-(((PI*2)/spawnTime)*(time)+HALF_PI));
  }

  public Powerup clone()throws CloneNotSupportedException {  
    return (Powerup)super.clone();
  }
}


class InvisPowerup extends Powerup {
  InvisPowerup(int _x, int _y, int _time) {
    super(_x, _y, int(_time*1.5));
    powerupColor=color(255, 200, 0);
    icon = superIcon;
  }
  void collect() {
    if (!dead) {
      tokens++;
      playSound(collectSound);
      particles.add( new SpinParticle(int(x), int(y),powerupColor));
      p.vx=30;
      if (p.invis<spawnTime)p.invis=spawnTime;  // replace invistime if it is longer
      p.invincible=true;  // activates supermario starpower
      BGM.pause();
      BGM = superSong;
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
    if (!dead) {
      p.invincible=true;
      p.vx=30;
      time-=1*speedFactor;
      if (time<=0) {
        death();
      }
    }
  }
}
class LaserPowerup extends Powerup {
  boolean shoot;
  LaserPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    icon=laserIcon;
    powerupColor=color(255, 0, 0);
  }

  void collect() {
    if (!dead) {
      tokens++;
      playSound(collectSound);
      particles.add( new SpinParticle(int(x), int(y),powerupColor));
      try {
        p.usedPowerup.add(this.clone());
      }    
      catch(CloneNotSupportedException e) {
      }
      this.death();
    }
  }
  void use() {

    if (p.angle>6) {  
      if (int(time)%3==0)projectiles.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, p.vx+cos(radians(p.angle))*30, sin(radians(p.angle))*30));
    } else {
      if (int(time)%7==0)projectiles.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, p.vx+cos(radians(p.angle))*30, sin(radians(p.angle))*30));
    }


    time-=1*speedFactor;
    if (time<1)death();
  }
}

class SlowPowerup extends Powerup {
  SlowPowerup(int _x, int _y, int _time) {
    super(_x, _y, int(_time*0.3));
    powerupColor=color(100, 100, 100);
    icon=slowIcon;
  }

  void collect() {
    tokens++;
    playSound(collectSound);
    particles.add( new SpinParticle(int(x), int(y),powerupColor));
    try {
      p.usedPowerup.add(this.clone());
    }        
    catch(CloneNotSupportedException e) {
    }
    this.death();
  }
  void use() {
    speedFactor=0.5; //slowrate
    time--;
    if (time<1)death();
  }
}
class LifePowerup extends Powerup {
  LifePowerup(int _x, int _y, int _time) {
    super(_x, _y, int(_time*0.1));
    powerups.add( this);
    powerupColor=color(50, 255, 50);
    icon= lifeIcon;
  }
  void collect() {
    if (!dead) {
      tokens++;
      playSound(collectSound);
      particles.add( new SpinParticle(  int(x), int(y),powerupColor));
      try {
        p.usedPowerup.add(this.clone());
      }        
      catch(CloneNotSupportedException e) {
      }    
      p.invis+=spawnTime;
      p.lives++;
      UpdateGUILife();
      death();
    }
  }
  void use() {
    time-= 1*speedFactor;
    if (time<1)death();
  }
}
class TeleportPowerup extends Powerup {
  int distance=900;
  TeleportPowerup(int _x, int _y, int _time) {
    super(_x, _y, 25);
    powerups.add( this);
    powerupColor=color(0, 50, 255);
    icon= slashIcon;
  }
  TeleportPowerup(int _x, int _y, int _time, int _distance) {
    this(_x, _y, 25);
    distance=_distance;
  }
  void collect() {
    if (!dead) {
      tokens++;
      playSound(collectSound);
      playSound(teleportSound);
      particles.add( new SpinParticle(  int(x), int(y),powerupColor));
      try {
        p.usedPowerup.add(this.clone());
      }        
      catch(CloneNotSupportedException e) {
      }    
      p.invis+=time;
      p.x=x-w;
      p.y=y;
      p.x+=distance;
      p.vx=-4;
      p.vy=-4;
      p.collectCooldown=20;
      playerOffsetX=distance+100;
      // background(255);
      entities.add(new slashParticle(int(p.x), int(p.y), 5, distance));
      for (Obstacle o : obstacles) {
        //if (o.y+o.h > p.y && p.y +p.h > o.y &&  o.x > p.x-distance && o.x+o.w < p.x ) {
        if (o.y+o.h > p.y && p.y +p.h > o.y &&  o.x > p.x-distance && o.x+o.w < p.x+p.w ) {
          o.impactForce=60;  
          o.health=0;
          o.death();
        }
      }
      skakeFactor=200;
      speedFactor=0.02;
      death();
    }
  }
  void use() {

    time-= 1*speedFactor;
    if (time<1)death();
  }
}
class RandomPowerup extends Entity {
  RandomPowerup(int _x, int _y, int _time) {
    super(_x, _y);
    //icon= tokenIcon;
    //powerupColor=color(100, 100, 100);

    switch(int(random(5))) {
    case 0:
      entities.add( new InvisPowerup( _x, _y, _time)); 
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
    case 4:
      entities.add( new  TeleportPowerup( _x, _y, _time) );
      break;
    default:
      entities.add( new Powerup( _x, _y, _time));
    }
    death();
  }
}

