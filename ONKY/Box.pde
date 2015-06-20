class Box extends Obstacle {

  Box(int _x, int _y) {
    super(_x, _y);
    obstacleColor = color(100, 100, 50);
  }
  void death() {
    super.death();

    for (int i =0; i< 8; i++) {
      entities.add( new BoxDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
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
    for (int i =0; i< 6; i++) {
      entities.add( new TireDebris(this, int(x+random(w)-w*0.5), int(y+random(h)-h*0.5), random(15)+impactForce*0.5, random(30)-20));
    }
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
    hitBrightness=255;
    x+=p.vx;
    y+=-p.vy;
  }
}

class PlatForm extends Obstacle {


  PlatForm(int _x, int _y) {
    super(_x, _y);
  }
  void death() {
    //super.death();
  }
  void hitCollision() {  // hit by punching & smashing
    //x+=p.vx;
  }
}

