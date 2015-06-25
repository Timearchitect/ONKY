abstract class Debris extends Entity {
  float opacityDecay=-2, angle, VAngle=1, ax, ay=0.9, opacity=255, bounceFriction, bounceForce;
  Obstacle owner; 

  Debris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _x, _y, _vx, _vy);
    debris.add( this);
    owner=_o;
  }


  void update() {
    angle+=VAngle*speedFactor;
    bounceOnFloor();
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    vx+=ax*speedFactor;
    vy+=ay*speedFactor;
    opacity+=opacityDecay*speedFactor;
    if (opacity<20)death();
  }

  void bounceOnFloor() {
    if (y+25>floorHeight) {
      hitFloor();
      vy*=-(bounceForce);
      vx*=bounceFriction;
      VAngle*=random(1);
    }
  }
  void hitFloor() {
  }
}
class BoxDebris extends Debris {


  BoxDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    VAngle=random(6)-3;
    bounceFriction=0.7;
    bounceForce=0.5;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    fill(owner.obstacleColor, int(opacity));
    noStroke();
    rect(-25, -25, 50, 50);
    popMatrix();
  }
}

class TireDebris extends Debris {


  TireDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    bounceFriction=1;
    bounceForce=0.8;
  }

  void hitFloor() {
    super.hitFloor();
    if (opacity>50)playSound(rubberSound);
  }
  void display() {
    stroke(0, int(opacity));
    strokeWeight(20);
    noFill();
    ellipse(x, y, 60, 60);
    strokeWeight(1);
  }
}
class GlassDebris extends Debris {


  GlassDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    VAngle=random(4)-2;
    bounceFriction=0.7;
    bounceForce=0.5;
  }

  void display() {
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    fill(owner.obstacleColor, int(opacity));
    triangle(-10, 0, 10, 0, 0, -40);
    popMatrix();
  }
}

class BushDebris extends Debris {
  float offsetX;
  BushDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    bounceForce=0;
    VAngle=random(4)-2;
    bounceFriction=0;
    w = 5;
    h = 5;
    ay=0.2;
  }

  @Override
    void update() {

    angle+=VAngle*speedFactor;
    offsetX=sin(radians(angle))*50;
    bounceOnFloor();
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    vx*=0.95;
    vy*=0.95; 
    vx+=ax*speedFactor;
    vy+=ay*speedFactor;
    opacity+=opacityDecay*speedFactor;
    if (opacity<20)death();
  }

  void display() {
    noStroke();
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    // fill(owner.obstacleColor, int(opacity));
    // triangle(-w+offsetX,0,w+offsetX,0,0+offsetX,-h*2);

    tint(255, int(opacity));
    image(Leaf, 0+offsetX, 0);
    noTint();
    popMatrix();
  }
}

