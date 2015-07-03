abstract class Powerup extends Entity implements Cloneable {
  PImage icon;
  boolean instant=true, toggle, homing;
  float angle, offsetX, offsetY;
  float  time, spawnTime;
  color powerupColor= color(255);
  int upgradeLevel=int(random(4));
  Powerup(int _x, int _y, int _time) {
    super(_x, _y);
   // icon= tokenIcon;
    time=_time;
    spawnTime=_time;
    x=_x;
    y=_y;
    w=100;
    h=100;
   // powerups.add( this);
    totalTokens++;
  }
  void update() {
    if (int(angle%120)==0) entities.add(new SparkParticle(int(x+offsetX*5), int(y+offsetY*5), 50, powerupColor));
    angle+=4*speedFactor;
    offsetX=cos(radians(angle))*12*speedFactor;
    offsetY=sin(radians(angle))*12*speedFactor;
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    if (homing && dist(x, y, p.x+p.w*0.5, p.y+p.h*0.5)<p.attractRange) {
      vx=((p.x+p.w*0.5)-x)*0.15*speedFactor;
      vy=((p.y+p.h*0.5)-y)*0.15*speedFactor;
    }
    collision();
  }
  void display() {
    image(icon, x-w*0.5+offsetX, y-h*0.5+offsetY, w, h);
    /*
        noStroke();
     fill(powerupColor);
     ellipse(x+offsetX, y+offsetY, w, h);
     */
  }
  void hitCollision() {
    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      if (p.collectCooldown<1)collect();
    }
  }
  void collision() {
    if (p.x+p.w > x- w*0.5 && p.x < x + w*0.5  && p.y+p.h > y - h*0.5 &&  p.y < y + h*0.5) {
      if (p.collectCooldown<1)collect();
    }
  }
  void collect() {
    tokensTaken++;
   // playSound(collectSound);
    //entities.add( new SpinParticle( int(x), int(y), powerupColor));
    entities.add( new SparkParticle(int(x), int(y), 50, powerupColor));
    //entities.add( new SparkParticle(int(x), int(y), 15, 255));
    UpdatePowerupGUILife();
    death();
  }
  void death() {
    super.death();
  }
  void use() {
    time--;
    //background(powerupColor);
    if (time<1)death();
  }
  void displayIcon() {
    int index=p.usedPowerup.indexOf(this), GUIoffsetY=height-150;     
    if (!instant && !toggle) {
      noFill();
      stroke(powerupColor);
      strokeWeight(5);
      ellipse(width-(GUIoffsetX+10+index*powerupGUIinterval+40)*screenFactor, GUIoffsetY+10+40*screenFactor, 100*screenFactor, 100*screenFactor);
    }
    //if (icon!=null)image(icon, GUIoffsetX+10+index*interval, GUIoffsetY+10, 100-20, 100-20); // GUILAYER
    noStroke();
    fill(0, 180);
    arc(width-(GUIoffsetX+w*0.5+index*powerupGUIinterval)*screenFactor, GUIoffsetY+h*0.5*screenFactor, 80*screenFactor, 80*screenFactor, -HALF_PI, PI*2-(PI*2/spawnTime*time+HALF_PI));
  }

  public Powerup clone()throws CloneNotSupportedException {  
    return (Powerup)super.clone();
  }
}
class TokenPowerup extends Powerup {
  TokenPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerups.add( this);
    powerupColor=color(255);
    icon= tokenIcon;
    w=75;
    h=75;
    homing=true;
  }
  void collect() {
    if (!dead) {
      super.collect();
    }
  }
}

class InvisPowerup extends Powerup {
  boolean first=true;
  InvisPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    powerupColor=color(255, 200, 0);
    icon = superIcon;
  }
  InvisPowerup(int _x, int _y, int _time, boolean _instant) {
    this(_x, _y, _time);
    instant=_instant;
  }
  void collect() {
    if (!dead) {
      try {
        p.usedPowerup.add(this.clone());
      }    
      catch(CloneNotSupportedException e) {
      }
      //p.usedPowerup.time+=this.time;
      //this.death();
      super.collect();
    }
  }
  void ones() {
    p.vx=30;
    p.weaponColor=powerupColor;
    if (p.invis<spawnTime)p.invis=spawnTime;  // replace invistime if it is longer
    p.invincible=true;  // activates supermario starpower
    //changeMusic(superSong);
    first=false;
  }
  void use() {
    if (!dead &&( instant|| toggle)) {
      if (first )ones();
      p.invincible=true;
      p.vx=30; // speed
      if (p.weaponColor==p.defaultWeaponColor) p.weaponColor=powerupColor;
      time-=1*speedFactor;
      if (time<1) {
        death();
        p.weaponColor=p.defaultWeaponColor;
      }
    }
  }
}

class LaserPowerup extends Powerup {

  LaserPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    icon=laserIcon;
    powerupColor=color(255, 0, 0);
  }
  LaserPowerup(int _x, int _y, int _time, boolean _instant) {
    this(_x, _y, _time);
    this.instant=_instant;
  }

  void collect() {
    if (!dead) {
      try {
        p.usedPowerup.add(this.clone());
      }    
      catch(CloneNotSupportedException e) {
      }
      super.collect();
    }
  }
  void use() {
    if ( toggle || instant ) {
      if (p.angle>6) {  
        switch(upgradeLevel) {  
        case 0:
          if (int(time)%4==0)entities.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*50), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, cos(radians(p.angle))*60, sin(radians(p.angle))*30));
          break;
        case 1:
          if (int(time)%3==0)entities.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*50), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, cos(radians(p.angle))*60, sin(radians(p.angle))*30));
          break;
        case 2:
          if (int(time)%2==0) entities.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*50), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, cos(radians(p.angle))*60, sin(radians(p.angle))*30));

          break;
        default:

          if (int(time)%2==0) {
            if (p.angle%360>270 || p.angle%360<90) { 

              entities.add( new BigLaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40)+80, int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, cos(radians(p.angle))*10, sin(radians(p.angle))*10));
            } else   entities.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, cos(radians(p.angle))*60, sin(radians(p.angle))*30));
          }
        }
      } else {
        switch(upgradeLevel) {  
        case 0:
          if (int(time)%9==0)entities.add( new LaserProjectile(  int(p.x+p.w*0.8), int(p.y+p.h*0.3), cos(radians(p.angle))*50, sin(radians(p.angle))*20));
          break;
        case 1:
          if (int(time)%7==0)entities.add( new LaserProjectile(  int(p.x+p.w*0.8), int(p.y+p.h*0.3), cos(radians(p.angle))*60, sin(radians(p.angle))*30));
          break;
        case 2:
          if (int(time)%13==0) {
            entities.add( new LaserProjectile(  int(p.x+p.w*0.8), int(p.y+p.h*0.3), cos(radians(p.angle-2))*60, sin(radians(p.angle-2))*30));
            entities.add( new LaserProjectile(  int(p.x+p.w*0.8), int(p.y+p.h*0.3), cos(radians(p.angle))*40, sin(radians(p.angle))*30));
            entities.add( new LaserProjectile(  int(p.x+p.w*0.8), int(p.y+p.h*0.3), cos(radians(p.angle+2))*60, sin(radians(p.angle+2))*30));
          }
          break;
        default:
          //if (int(time)%7==0)entities.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, cos(radians(p.angle))*60, sin(radians(p.angle))*30));
          if (int(time)%16==0) {
            // for (int i=2; i<3; i++)  entities.add( new LaserProjectile(  int(p.x+p.w*0.5+sin(radians(p.angle))*40), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, cos(radians(p.angle))*i*10, sin(radians(p.angle))*i*5));
            entities.add( new BigLaserProjectile(  int(p.x+p.w*0.5+100), int(p.y+p.h*0.6-cos(radians(p.angle))*30)+10, cos(radians(p.angle))*10, sin(radians(p.angle))*10));
          }
        }
      }
      if (targetScaleFactor>1-upgradeLevel*0.1-0.30) {
        targetScaleFactor=1-upgradeLevel*0.1-0.30;
      }
      time-=1*speedFactor;
      if (time<1)death();
    }
  }
}

class SlowPowerup extends Powerup {
  SlowPowerup(int _x, int _y, int _time) {
    super(_x, _y, int(_time*0.3));
    powerupColor=color(100, 100, 100);
    icon=slowIcon;
  }
  SlowPowerup(int _x, int _y, int _time, boolean _instant) {
    this(_x, _y, _time);
    instant=_instant;
  }

  void collect() {
    try {
      p.usedPowerup.add(this.clone());
    }        
    catch(CloneNotSupportedException e) {
    }
    super.collect();
  }
  void use() {
    if ( toggle || instant ) {
      speedFactor=0.5; //slowrate
      time--;
      if (time<1)death();
    }
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
      try {
        p.usedPowerup.add(this.clone());
      }        
      catch(CloneNotSupportedException e) {
      }    
      p.invis+=spawnTime;
      p.lives++;
      UpdateGUILife();
      super.collect();
      //death();
    }
  }

  void use() {
    time-= 1*speedFactor;
    if (time<1)death();
  }
}
class TeleportPowerup extends Powerup {
  int distance=900;
  boolean first=true;
  TeleportPowerup(int _x, int _y, int _time) {
    super(_x, _y, 25);
    powerups.add( this);
    powerupColor=color(0, 50, 255);
    icon= slashIcon;
    //instant=true;
  }
  TeleportPowerup(int _x, int _y, int _time, boolean _instant) {
    this(_x, _y, 25);
    this.instant=_instant;
  }
  TeleportPowerup(int _x, int _y, int _time, int _distance) {
    this(_x, _y, 25);
    distance=_distance;
    instant=true;
  }
  void collect() {
    if (!dead) {
      try {
        p.usedPowerup.add(this.clone());
      }        
      catch(CloneNotSupportedException e) {
      }    

      super.collect();
      //death();
    }
  }
  void ones() {
 //   playSound(teleportSound);
    p.weaponColor=powerupColor; // weapon color to blue
    p.invis+=time;  
    if (instant)p.x=x-w;  // telepot to powerup
    if (instant)p.y=y;
    p.x+=distance; // forward tele
    p.vx=-4;
    p.vy=-4;
    p.jumpCount++; 
    p.collectCooldown=20;  
    playerOffsetX=distance+100;
    playerOffsetY=0;
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
    screenAngle=12;
    shakeFactor=200;
    speedFactor=0.02;

    first=false;
  }
  void use() {
    if ( toggle || instant ) {
      if (first )ones();
      screenAngle=10;
      time-= 1*speedFactor;
      if (p.weaponColor==p.defaultWeaponColor) p.weaponColor=powerupColor;
      if (time<1) {
        death();
        p.weaponColor=p.defaultWeaponColor;
      }
    }
  }
}

class MagnetPowerup extends Powerup {
  int range;
  MagnetPowerup(int _x, int _y, int _time) {
    super(_x, _y, int(_time*2));
    powerupColor=color(220, 0, 220);
    icon=magnetIcon;
    range=80*(upgradeLevel)+300;
  }
  MagnetPowerup(int _x, int _y, int _time, boolean _instant) {
    this(_x, _y, int(_time*2));
    instant=_instant;
  }

  void collect() {
    try {
      p.usedPowerup.add(this.clone());
    }        
    catch(CloneNotSupportedException e) {
    }
    super.collect();
  }
  void use() {
    if ( toggle || instant ) {
      //speedFactor=0.5; //slowrate
      p.attractRange=range;
      if (time%int(16/speedFactor)==0)entities.add(new RShockWave(int(p.x), int(p.y), range*2, powerupColor) );
      //stroke(powerupColor);
      //noFill();
      // ellipse(p.x+p.w*0.5,p.y+p.h*0.5,p.attractRange*2,p.attractRange*2);
      time--;
      if (time<1) {
        death();
        p.attractRange=0;
      }
    }
  }
}

class RandomPowerup extends Powerup {
  RandomPowerup(int _x, int _y, int _time) {
    super(_x, _y, _time);
    //icon= tokenIcon;
    //powerupColor=color(100, 100, 100);
    switch(int(random(6))) {
    case 0:
      powerups.add( new InvisPowerup( _x, _y, _time)); 
      break;
    case 1:
      powerups.add( new LaserPowerup( _x, _y, _time) );
      break;
    case 2:
      powerups.add( new SlowPowerup( _x, _y, _time, false) );
      break;
    case 3:
      powerups.add( new LifePowerup( _x, _y, _time) );
      break;
    case 4:
      powerups.add( new  TeleportPowerup( _x, _y, _time, false) );
      break;
    case 5:
      powerups.add( new  MagnetPowerup( _x, _y, _time, false) );
      break;
    default:
      powerups.add( new TokenPowerup( _x, _y, _time));
    }
    death();
  }
}

