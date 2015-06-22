

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
  int type;
  slashParticle(int _x, int  _y, int _type) {
    super( _x, _y);
    particles.add(this);
    type=_type;
    // y=_y;
  }

  void update() {

    if (opacity>0)opacity*=1-0.1*speedFactor;
    if (opacity<=20)death();
  }

  void display() {
    noFill();
    stroke(255, 0, 0, int(opacity));
    strokeWeight(int(opacity*0.18));
    if (type==0)curve(p.x-200, p.y-40, p.x+30, p.y+ 0, p.x+ 160, p.y+90, p.x- 200, p.y+20);
    else  curve(p.x-200, p.y+500, p.x+30, p.y+ 50, p.x+ 180, p.y+40, p.x-300, p.y+400);

    stroke(255, int(opacity+50));
    strokeWeight(int(opacity*0.05));
    noFill();
    if (type==0)curve(p.x-200, p.y-40, p.x+30, p.y+ 0, p.x+ 160, p.y+90, p.x- 200, p.y+20);
    else  curve(p.x-200, p.y+500, p.x+30, p.y+ 50, p.x+ 180, p.y+40, p.x-300, p.y+400);

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
    super( _x, _y);
    particles.add(this);
    particleColor=color(255);
    size=_size;
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
  SpinParticle( Player _player) {
    super( 0, 0);
    particles.add(this);
    player=_player;
    angle=random(0, 360);
  }
  SpinParticle( int _x, int _y) {
    super( _x, _y);
    particles.add(this);
    size=150;
    angle=random(0, 360);
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
    ellipse(x,y,w,h);
  }
}

