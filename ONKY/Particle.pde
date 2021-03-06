

class Particle extends Entity {
  float opacity=255;
  //boolean overlay, underlay;
  Particle(int _x, int  _y) {
    super( _x, _y);
    particles.add(this);
  }
  void update() {
  }

  void display() {
  }
  void death() {
    super.death();
  }
}

class TrailParticle extends Particle {
  PImage cell;
  float angle;
  TrailParticle(int _x, int  _y, PImage _cell) {
    super( _x, _y);
    //particles.add(this);
    cell=p.cell;
    angle=p.angle;
    opacity=200-(100*speedFactor);
    w=100;
    h=80;
  }

  void update() {
    if (opacity<10) death();
    else opacity*=1-0.1*speedFactor;
  }

  void display() {
    pushMatrix();
    translate(x+w*0.5, y+h*0.5);
    rotate(radians(angle));
    tint(255, int(opacity));
    image(this.cell, -w*0.5, -h*0.5, w, h);
    // g.removeCache(cell);// this is avoiding the leak
    noTint();
    popMatrix();
  }
}

class speedParticle extends Particle {

  speedParticle(int _x, int  _y) {
    super( _x, _y);
    //particles.add(this);
    opacity=100;
  }

  void update() {
    w+=1*speedFactor;
    if (opacity<10) death();
    else opacity-=4*speedFactor;
  }

  void display() {
    stroke(255, int(opacity));
    strokeWeight(3);
    noFill();
    line(x+p.vx-w, y, x-w, y);
    //strokeWeight(1);
  }
}

class slashParticle extends Particle {
  int type, distance;

  slashParticle(int _x, int  _y, int _type) {
    super( _x, _y);
    // particles.add(this);
    type=_type;
  }
  slashParticle(int _x, int  _y, int _type, int _distance) {
    this( _x, _y, _type);
    distance=_distance;
  }

  void update() {
    if (opacity<20)death(); 
    else    opacity*=1-0.1*speedFactor;
  }

  void display() {
    noFill();
    stroke(p.weaponColor, int(opacity));
    strokeWeight(int(opacity*0.18));
    switch(type) {
    case 0:
      curve(p.x-200, p.y-40, p.x+30, p.y+ 0, p.x+ 160, p.y+90, p.x- 200, p.y+20);
      break;
    case 1:
      curve(p.x-200, p.y+500, p.x+30, p.y+ 50, p.x+ 180, p.y+40, p.x-300, p.y+400);
      break;
    case 2:
      curve(p.x-100, p.y+60, p.x+40, p.y+ 0, p.x+ 180, p.y+30, p.x- 200, p.y+180);
      break;
    case 3:
      arc(p.x+p.w*0.5+20, p.y+p.h*0.5, 190, 140, radians(p.angle*1.5-50), radians(p.angle*1.5+120));
      break;
    case 4:
      curve(p.x-60, p.y-420, p.x+20, p.y+ 30, p.x+ 140, p.y-20, p.x- 150, p.y-780);
      break;
    case 5:
      line(x-distance, y, x, y);
      break;
    case 6:
      curve(p.x-60, p.y+520, p.x+40, p.y- 40, p.x+ 120, p.y+130, p.x+ 100, p.y+580);
      break;
    }

    stroke(255, int(opacity+50));
    strokeWeight(int(opacity*0.05));
    noFill();

    switch(type) {
    case 0:
      curve(p.x-200, p.y-40, p.x+30, p.y+ 0, p.x+ 160, p.y+90, p.x- 200, p.y+20);
      break;
    case 1:
      curve(p.x-200, p.y+500, p.x+30, p.y+ 50, p.x+ 180, p.y+40, p.x-300, p.y+400);
      break;
    case 2:
      curve(p.x-100, p.y+60, p.x+40, p.y+ 0, p.x+ 180, p.y+30, p.x- 200, p.y+180);
      break;
    case 3:
      arc(p.x+p.w*0.5+20, p.y+p.h*0.5, 190, 140, radians(p.angle*1.5-50), radians(p.angle*1.5+120));
      break;
    case 4:
      curve(p.x-60, p.y-420, p.x+20, p.y+ 30, p.x+ 140, p.y-20, p.x- 150, p.y-780);
      break;
    case 5:
      line(x-distance, y, x, y);
      break;
    case 6:
      curve(p.x-60, p.y+520, p.x+40, p.y- 40, p.x+ 120, p.y+130, p.x+ 100, p.y+580);
      break;
    }
  }
}

class LineParticle extends Particle {
  float angle, size;
  color particleColor;
  LineParticle(int _x, int _y, int _size) {
    super( _x, _y);
    //particles.add(this);
    particleColor=p.weaponColor;
    size=_size;
    angle=random(360);
  }
  LineParticle(int _x, int _y, int _size, float _angle) {
    this( _x, _y, _size);
    particleColor=color(255);
    angle=_angle;
  }
  void update() {
    size*=1+0.1*speedFactor;
    if (opacity<2)death(); 
    else    opacity*=1-0.3*speedFactor;
  }

  void display() {

    noFill();
    stroke(particleColor, int(opacity));
    strokeWeight(int(0.2*opacity));
    line(x-cos(radians(angle))*size, y-sin(radians(angle))*size, x+cos(radians(angle))*size, y+sin(radians(angle))*size);

    stroke(255, int(opacity)+100);
    strokeWeight(int(0.1*opacity));
    line(x-cos(radians(angle))*size, y-sin(radians(angle))*size, x+cos(radians(angle))*size, y+sin(radians(angle))*size);
    // strokeWeight(1);
  }
}
class SpinParticle extends Particle {
  float size=100, angle;
  Boolean onOnky=false;
  color particleColor=color(255);
  SpinParticle( int _x, int _y, color _particleColor) {
    super( _x, _y);
    particleColor=_particleColor;
    //particles.add(this);
    size=150;
    angle=random(0, 360);
  }
  SpinParticle( Boolean _onOnky) {
    super( 0, 0);
    //particles.add(this);
    onOnky=_onOnky;
  }
  void update() {
    angle+=16*speedFactor;
    if (onOnky) {
      x=int(p.x+p.w*0.5);
      y=int(p.y+p.h*0.5);
    } 
    if (opacity<1)death(); 
    else opacity-=8*speedFactor;
  }

  void display() {
    noFill();
    stroke(particleColor, int(opacity));
    strokeWeight(int(opacity*0.1));
    arc(x, y, size, size, radians(angle), radians(angle+180));
  }
}
class smokeParticle extends Particle {
  float angle, size;
  color particleColor=255;

  smokeParticle(int _x, int  _y, float _vx, float  _vy, int _size) {
    super( _x, _y);
    particles.add(this);
    opacity=255;
    vy=_vy;
    vx=_vx;
    size=_size;
  }

  smokeParticle(int _x, int  _y, float _vx, float  _vy, int _size, color _particleColor) {
    this( _x, _y, _vx, _vy, _size);
    particleColor=_particleColor;
  }

  void update() {
    angle+=2*speedFactor;
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    if (size>0)size*=1-0.05*speedFactor;
    if (opacity>10)opacity-=10*speedFactor;
    else death();
  }

  void display() {
    tint(particleColor, opacity);
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    image(Smoke, -size*0.5, -size*0.5, size, size);
    popMatrix();
    noTint();
  }
}

class SparkParticle extends Particle {
  float  size;
  color particleColor;
  SparkParticle(int _x, int _y, int _size, color _particleColor) {
    super( _x, _y);
    //particles.add(this);
    particleColor=_particleColor;
    size=_size;
  }

  void update() {
    if (size>0)size*=1-0.1*speedFactor;
    if (size<=1)death();
  }

  void display() {
    stroke(particleColor);
    fill(255);
    strokeWeight(int(size*0.2)); 
    beginShape();
    vertex(x+0, y-size );
    vertex(x+size*0.5 -size*0.25, y- size*0.5+size*0.25);
    vertex(x+size, y+0);
    vertex(x+size*0.5-size*0.25, y+ size*0.5-size*0.25);
    vertex(x+0, y+ size);
    vertex(x-size*0.5+size*0.25, y+size*0.5-size*0.25);
    vertex(x-size, y-0);
    vertex(x-size*0.5+size*0.25, y-size*0.5+size*0.25);
    endShape(CLOSE);
  }
}

class splashParticle extends Particle {
  float  size;
  color particleColor;
  splashParticle(int _x, int _y, float _vx, float _vy, int _size, color _particleColor) {
    super( _x, _y);
    vx=_vx;
    vy=_vy;
    //particles.add(this);
    particleColor=_particleColor;
    size=_size;
  }

  void update() {
    //super.update();
    x+=vx;
    y+=vy;
    if (size>0)size*=1-0.1*speedFactor;
    if (size<5)death();
  }

  void display() {
    fill(255);
    stroke(particleColor);
    strokeWeight(size*0.4); 
    beginShape();
    vertex(x+0, y+0 );
    vertex(x+size, y-size*3 );
    vertex(x+size*1.5, y+0 );
    endShape(CLOSE);
  }
}
class RShockWave extends Particle {
  float  size;
  color particleColor;
  RShockWave(int _x, int _y, int _size, color _particleColor) {
    super( _x, _y );

    opacity=0;
    size=_size;
    particleColor=_particleColor;
  }
  void update() {
    //super.update();
    size-=25*speedFactor;
    opacity+=3*speedFactor;
    if (size<5)death();
  }
  void display() {
    noFill();
    stroke(particleColor, opacity);
    strokeWeight(int(0.3*opacity));
    ellipse(int(p.x+p.w*0.5), int(p.y+p.h*0.5), size, size);
  }
}

class triangleParticle extends Particle {
  float  size, angle, vAngle;
  color particleColor;
  triangleParticle(int _x, int _y, int _size, color _particleColor) {
    super( _x, _y );
    size=_size;
    particleColor=_particleColor;
    vAngle=random(12)-6;
  }
  triangleParticle(int _x, int _y, float _vx, float _vy, int _size, color _particleColor) {
    this( _x, _y, _size, _particleColor);
    vx=_vx;
    vy=_vy;
  }
  void update() {
    //super.update();
    angle+=vAngle;
    x+=vx;
    y+=vy;
    size*=0.9*speedFactor;  // decay
    if (size<2)death();
  }
  void display() {
    pushMatrix();
    translate(x+size*0.5, y+size*0.5);
    rotate(radians(angle));
    strokeWeight(int(size*0.3));
    stroke(particleColor);
    fill(255);
    beginShape();
    vertex(0, -size );
    vertex(size*0.5, 0 );
    vertex(-size*0.5, 0 );
    endShape(CLOSE);
    popMatrix();
  }
}
class RectParticle extends Particle {
  float  size;
  color particleColor;
  RectParticle(int _x, int _y, float _vx, float _vy, int _size, color _particleColor) {
    super( _x, _y );
    size=_size;
    particleColor=_particleColor;
    vx=_vx;
    vy=_vy;
  }
  void update() {
    //super.update();
    x+=vx;
    y+=vy;
    size*=0.9;  // decay
    if (size<2)death();
  }
  void display() {
    strokeWeight(int(size*0.3));
    stroke(particleColor);
    fill(255);
    rect(x-size*0.5, y-size*0.5, size*3, size);
  }
}

class textParticle extends Particle {
  float  opacity=10;
  color particleColor;
  String text;
  boolean active=false;
  textParticle(int _x, int _y, color _particleColor, String _text) {
    super( _x, _y );
    particleColor=_particleColor;
    text=_text;
  }
  void update() {
    //super.update();
    x+=vx;
    y+=vy;
    //    if (((p.x-playerOffsetX+width)/scaleFactor)*screenFactor>x) {
    if ((p.x+p.vx-playerOffsetX*3+width/scaleFactor*screenFactor)>x) {
      if (!active) {
        //playSound(warning);
        background(255);
        opacity=255;
        active=true;
      } else {
        opacity*=0.95;  // decay
        vx=p.vx;
      }
    }
    if (opacity<2)death();
  }
  void display() {
    if (active) {  
      fill(particleColor, opacity);
      textSize(int(350*screenFactor));
      textAlign(RIGHT);
      text(text, x, y);
      textAlign(NORMAL);
    }
  }
}


class hintOverLayParticle extends Particle {
  float  opacity;
  color particleColor;
  boolean active=false;
  int action;
  hintOverLayParticle(int _x, int _y, color _particleColor) {
    super( _x, _y );
    particleColor=_particleColor;
  }
  hintOverLayParticle(int _x, int _y, color _particleColor, int _action) {
    this(  _x, _y, _particleColor );
    action=_action;
    overlay=true;
  }
  void update() {

    if (p.x+p.vx-playerOffsetX>x && p.x-p.vx-playerOffsetX < x) {
      if (!active) {
        opacity=100;
        active=true;
        if (automate) {
          switch(action) {
          case 0:
            p.jump();
            break;
          case 1:
            p.duck();
            break;
          case 2:
            p.startPunch();
            break;
          case 4:
            break;
          case 5:
            background(p.usedPowerup.get(0).powerupColor);
            p.usedPowerup.get(0).toggle=!p.usedPowerup.get(0).toggle;  
            break;
          }
        }
      }
    }
    if (active) {      
      opacity-=2;  // decay
      if (opacity<5) {
        // death();
        active=false;
      }
    }
  }
  void display() {
    if (active && hint) {
      noStroke();
      fill(particleColor, opacity);
      switch(action) {
      case 0:
        rect(0, 0, width*0.5, height*0.5);
        break;
      case 1:
        rect(0, height*0.5, width*0.5, height*0.5);
        break;
      case 2:
        rect(width*0.5, 0, width*0.5, height);
        break;
      case 4:
        tint(255, opacity);
        image(tapPowerupZone, width*0.5, 0, width*0.5, height);
        noTint();
        break;
      case 5:
        tint(0,0,255, opacity);
        image(tapPowerupZone, width*0.5, 0, width*0.5, height); // activate
        noTint();
        break;
      }
      /*
      if (action==0) rect(0, 0, width*0.5, height*0.5);
       else if (action==1) rect(0, height*0.5, width*0.5, height*0.5);
       else if (action==2) rect(width*0.5, 0, width*0.5, height);
       //else if (action==3) rect(p.x-playerOffsetX, (p.y+height*0.5*0.3, width*0.5, height);
       else if (action==4) { 
       tint(255, opacity);
       image(tapPowerupZone, width*0.5, 0, width*0.5, height);
       noTint();
       }*/
    }
  }
}
class tapOverLayParticle extends Particle {
  float opacity=255;
  int action;
  tapOverLayParticle( int _opacity, int _action) {
    super( 0, 0 );
    opacity=_opacity;
    overlay=true;
    action=_action;
  }
  tapOverLayParticle( int _x, int _y, int _opacity, int _action) {
    super( _x, _y );
    x=_x;
    y=_y;
    opacity=_opacity;
    overlay=true;
    action=_action;
  }
  void update() { 
    opacity--;  // decay
    if (opacity<3)death();
  }
  void display() {
    tint(255, opacity);
    if (action==0) image(cornerStar, -width*0.5, -height*0.5, width, height);
    else if (action==1) image(cornerStar, -width*0.5, height*0.5, width, height);
    else if (action==2) image(cornerStar, width*0.5, -height*0.5, width, height);
    else if (action==3) image(cornerStar, width*0.5, height*0.5, width, height);
    else if (action==4) image(iconZone, x-100, y-100);
    noTint();
  }
}


