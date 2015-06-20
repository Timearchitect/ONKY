class Box extends Obstacle {

  Box(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(120, 120, 80);
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));
    for (int i =0; i< 8; i++) {
      entities.add( new BoxDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }
  void display() {
    super.display();

    stroke(155, 155, 100);
    strokeWeight(8);
    line(x, y, x+w, y+h);
    line(x, y+h, x+w, y);
    strokeWeight(1);
  }
  void knockSound() {
    boxKnockSound.rewind();
    boxKnockSound.play();
  }
  void destroySound() {
    boxDestroySound.rewind();
    boxDestroySound.play();
  }
}
class Tire extends Obstacle {

  Tire(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(0, 0, 0);
  }
  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h*0.5), 150));

    for (int i =0; i< 6; i++) {
      entities.add( new TireDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
  }

  void surface() {
    if (p.vx>7)p.vx*=0.8;
    if (int(random(9))==0)entities.add( new TireDebris(this, int(p.x), int(y), random(20)+p.vx-10, -random(20)));
  }
}
class IronBox extends Obstacle {
  float tx, ty;
  IronBox(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(150, 150, 150);
    tx=_x;
    ty=_y;
  }
  void display() {
    super.display();
    stroke(250, 250, 250);
    strokeWeight(8);
    point(x+10, y+10);
      point(x+w-10, y+10);
      point(x+w-10, y+h-10);
      point(x+10, y+h-10);

    strokeWeight(1);
  }
  void update() {
    super.update();
    float diffX=tx-x, diffY=ty-y;
    x+=diffX*0.2;
    y+=diffY*0.2;
  }
  void death() {
    //  super.death();
  }
  void hit() {  // hit by punching & smashing
    super.hit();
    hitBrightness=255;
    x+=p.vx;
    y+=-p.vy;
  }
  void knock() {
    super.knock();
    hitBrightness=255;
  }
  void knockSound() {
    ironBoxDestroySound.rewind();
    ironBoxDestroySound.play();
  }
  void  hitSound() {
    ironBoxDestroySound.rewind();
    ironBoxDestroySound.play();
  }
}

class PlatForm extends Obstacle {
  boolean hanging;

  PlatForm(int _x, int _y, int _w, int _h) {
    super(_x, _y);
    w=_w;
    h=_h;
    obstacleColor = color(255, 50, 50);
  }
  PlatForm(int _x, int _y, int _w, int _h, boolean _hanging) {
    super(_x, _y);
    hanging=_hanging;
    w=_w;
    h=_h;
    obstacleColor = color(255, 50, 50);
  }
  void display() {
    super.display();
    if (hanging) {
      stroke(200, 200, 200);
      strokeWeight(6);
      line(x, y, x, 0);
      line(x+w, y, x+w, 0);
      strokeWeight(1);
    }
  }
  void death() {
    //super.death();
  }
  void hitCollision() {  // hit by punching & smashing
    //x+=p.vx;
  }
}

