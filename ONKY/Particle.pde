

class Particle extends Entity {
  float opacity=255;
  Particle(int _x, int  _y) {
    super( _x, _y);
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

  TrailParticle(int _x, int  _y, PImage _cell) {
    super( _x, _y);
    particles.add(this);
    cell=_cell;
    opacity=100;
    w=100;
    h=80;
  }

  void update() {
    if (opacity>10)opacity*=1-0.1*speedFactor;
    else death();
  }

  void display() {
    tint(255, int(opacity));
    image(cell, x, y, w, h);
    g.removeCache(cell);// this is avoiding the leak

    noTint();
  }
}

class speedParticle extends Particle {

  speedParticle(int _x, int  _y) {
    super( _x, _y);
    particles.add(this);
    opacity=100;
    // y=_y;
  }

  void update() {

    w+=1*speedFactor;
    if (opacity>10)opacity-=4*speedFactor;
    else death();
  }

  void display() {
    stroke(255, int(opacity));
    strokeWeight(3);
    noFill();
    line(x+p.vx-w, y, x-w, y);

    strokeWeight(1);
  }
}

class slashParticle extends Particle {
  int type, distance;

  slashParticle(int _x, int  _y, int _type) {
    super( _x, _y);
    particles.add(this);
    type=_type;
  }
  slashParticle(int _x, int  _y, int _type, int _distance) {
    this( _x, _y, _type);
    distance=_distance;
  }

  void update() {
    if (opacity>0)opacity*=1-0.1*speedFactor;
    if (opacity<=20)death();
  }

  void display() {
    noFill();
    stroke(255, 0, 0, int(opacity));
    strokeWeight(int(opacity*0.18));
    if (type==0) {
      curve(p.x-200, p.y-40, p.x+30, p.y+ 0, p.x+ 160, p.y+90, p.x- 200, p.y+20);
    }
    if (type==1) { 
      curve(p.x-200, p.y+500, p.x+30, p.y+ 50, p.x+ 180, p.y+40, p.x-300, p.y+400);
    }
    if (type==2) {
      curve(p.x-100, p.y+60, p.x+40, p.y+ 0, p.x+ 180, p.y+30, p.x- 200, p.y+180);
    }
    if (type==3) {
      arc(p.x+p.w*0.5+20, p.y+p.h*0.5, 190, 140, radians(p.angle*1.5-50), radians(p.angle*1.5+120));
    }
    if (type==4) {
      curve(p.x-60, p.y-420, p.x+20, p.y+ 30, p.x+ 140, p.y-20, p.x- 150, p.y-780);
    }
    if (type==5) {  // special
      stroke(0, 50, 255);
      line(x-distance, y, x, y);
    }
    stroke(255, int(opacity+50));
    strokeWeight(int(opacity*0.05));
    noFill();


    if (type==0) {
      curve(p.x-200, p.y-40, p.x+30, p.y+ 0, p.x+ 160, p.y+90, p.x- 200, p.y+20);
    }
    if (type==1) {
      curve(p.x-200, p.y+500, p.x+30, p.y+ 50, p.x+ 180, p.y+40, p.x-300, p.y+400);
    }
    if (type==2) {
      curve(p.x-100, p.y+60, p.x+40, p.y+ 0, p.x+ 180, p.y+30, p.x- 200, p.y+180);
    }
    if (type==3) {
      arc(p.x+p.w*0.5+20, p.y+p.h*0.5, 190, 140, radians(p.angle*1.5-50), radians(p.angle*1.5+120));
    }
    if (type==4) {
      curve(p.x-60, p.y-420, p.x+20, p.y+ 30, p.x+ 140, p.y-20, p.x- 150, p.y-780);
    }
    if (type==5) {
      line(x-distance, y, x, y);
    }
    strokeWeight(1);
  }
}

class LineParticle extends Particle {
  float angle, size;
  color particleColor;
  LineParticle(int _x, int _y, int _size) {
    super( _x, _y);
    particles.add(this);
    particleColor=color(255, 0, 0);
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
    if (opacity>0)opacity*=1-0.3*speedFactor;
    if (opacity<=1)death();
  }

  void display() {

    noFill();

    stroke(particleColor, int(opacity));
    strokeWeight(int(0.2*opacity));
    line(x-cos(radians(angle))*size, y-sin(radians(angle))*size, x+cos(radians(angle))*size, y+sin(radians(angle))*size);

    stroke(255, int(opacity)+100);
    strokeWeight(int(0.1*opacity));
    line(x-cos(radians(angle))*size, y-sin(radians(angle))*size, x+cos(radians(angle))*size, y+sin(radians(angle))*size);
    strokeWeight(1);
  }
}
class SpinParticle extends Particle {
  float size=100, angle;
  Player player;

  SpinParticle( int _x, int _y) {
    super( _x, _y);
    particles.add(this);
    size=150;
    angle=random(0, 360);
  }
    SpinParticle( Player _player) {
    this( 0, 0);
    player=_player;
  }
  void update() {

    angle+=16*speedFactor;
    opacity-=8*speedFactor;
    if (opacity<0)opacity=0;
    if (player!=null) {
      x=int(p.x+p.w*0.5);
      y=int(p.y+p.h*0.5);
    } 
    if (opacity<=1)death();
  }

  void display() {

    noFill();
    stroke(255, int(opacity));
    strokeWeight(int(opacity*0.1));
    arc(x, y, size, size, radians(angle), radians(angle+180));
    strokeWeight(1);
  }
}
class smokeParticle extends Particle {

  smokeParticle(int _x, int  _y, float _vx, float  _vy) {
    super( _x, _y);
    particles.add(this);
    opacity=100;
    vy=_vy;
    vx=_vx;
  }

  void update() {
    if (opacity>10)opacity-=4*speedFactor;
    else death();
  }

  void display() {
    fill(255, int(opacity));
    noStroke();
    ellipse(x, y, w, h);
  }
}

class sparkParticle extends Particle {
  float  size;
  color particleColor;
  sparkParticle(int _x, int _y, int _size, color _particleColor) {
    super( _x, _y);
    particles.add(this);
    particleColor=_particleColor;
    size=_size;
  }

  void update() {
    size*=1+0.1*speedFactor;
    if (opacity>0)opacity*=1-0.3*speedFactor;
    if (opacity<=1)death();
  }

  void display() {
  }
}

