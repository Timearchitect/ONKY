

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
  float opacity=255;
  TrailParticle(int _x, int  _y, PImage _cell) {
     super( _x, _y);
    particles.add(this);
    cell=_cell;
   w=100;
   h=80;
  }

  void update() {
    if (opacity>0)opacity*=0.9;
    if (opacity<=1)death();
  }

  void display() {
    tint(255, opacity);
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

    w++;
    if (opacity>0)opacity--;
    if (w>200)death();
  }

  void display() {
    stroke(255, opacity);
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

    if (opacity>0)opacity*=0.9;
    if (opacity<=1)death();
  }

  void display() {
    noFill();
    stroke(255, 0, 0, opacity);
    strokeWeight(int(opacity*0.15));
    if (type==0)curve(p.x-200, p.y-40, p.x+30, p.y+ 0, p.x+ 160, p.y+90, p.x- 200, p.y+20);
    else  curve(p.x-200, p.y+500, p.x+30, p.y+ 50, p.x+ 180, p.y+40, p.x-300, p.y+400);

    stroke(255, opacity+50);
    strokeWeight(int(opacity*0.04));
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
    size*=1.1;
    if (opacity>0)opacity*=0.7;
    if (opacity<=1)death();
  }

  void display() {

    noFill();

    stroke(particleColor, opacity);
    strokeWeight(int(0.2*opacity));
    line(x-cos(radians(angle))*size, y-sin(radians(angle))*size, x+cos(radians(angle))*size, y+sin(radians(angle))*size);

    stroke(255, opacity+100);
    strokeWeight(int(0.1*opacity));
    line(x-cos(radians(angle))*size, y-sin(radians(angle))*size, x+cos(radians(angle))*size, y+sin(radians(angle))*size);
    strokeWeight(1);
  }

}
class SpinParticle extends Particle {
  float size=100, angle;
  SpinParticle( int _x, int _y) {
    super( _x, _y);
    particles.add(this);

    angle=random(0, 360);
  }
  void update() {

    angle+=16;
    opacity-=8;
    x=int(p.x+p.w*0.5);
    y=int(p.y+p.h*0.5);
    if (opacity<=1)death();
  }

  void display() {

    noFill();
    stroke(255, opacity);
    strokeWeight(ceil (opacity*0.1));
    arc(x, y, size, size, radians(angle), radians(angle+180));
    strokeWeight(1);
  }

}

