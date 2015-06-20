abstract class Debris extends Entity {
  // int x, y, w, h, opacityDecay=-2;
  int opacityDecay=-2;
  // float angle, VAngle, vx, vy, ax, ay=0.9, opacity=255;

  float angle, VAngle=1, ax, ay=0.9, opacity=255, bounceFriction, bounceForce;
  boolean dead;
  Obstacle owner; 

  Debris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _x, _y, _vx, _vy);
    debris.add( this);
    owner=_o;
  }

  void display() {
  }

  void update() {
    if (!dead) {
      angle+=VAngle;
      bounceOnFloor();

      x+=vx;
      y+=vy;
      vx+=ax;
      vy+=ay;
      opacity+=opacityDecay;
      if (opacity<0)death();
    }
  }
  void death() {
    dead=true;
  }
  void bounceOnFloor() {
    if (y+25>floorHeight) {
        vy*=(-(bounceForce));
        vx*=(bounceFriction);
        VAngle*=(random(1));
    }
  }
}
class BoxDebris extends Debris {


  BoxDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    VAngle=random(6)-3;
    bounceFriction=0.7;
    bounceForce=0.5;
  }
  void update() {
    super.update();
  }
  void display() {
    if (!dead) {
      pushMatrix();
      translate(x, y);
      rotate(radians(angle));
      fill(owner.obstacleColor, opacity);
      noStroke();
      rect(-25, -25, 50, 50);
      popMatrix();
    }
  }
}

class TireDebris extends Debris {


  TireDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    bounceFriction=1;
    bounceForce=0.8;
  }
  void update() {
    super.update();
  }
  void display() {
    if (!dead) {
      stroke(0, opacity);
      strokeWeight(20);
      noFill();
      ellipse(x, y, 60, 60);
      strokeWeight(1);
    }
  }
}

