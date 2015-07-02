abstract class Debris extends Entity {
  float opacityDecay=-3, angle, VAngle=1, ax, ay=0.9, opacity=255, bounceFriction, bounceForce;
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
    if (opacity<20)death();
    else opacity+=opacityDecay*speedFactor;
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
  void death() {
    super.death();
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
class IronBoxDebris extends Debris {


  IronBoxDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    VAngle=random(6)-3;
    bounceFriction=0;
    bounceForce=0;
    opacityDecay=-5;
    w=30;
    h=60;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    fill(owner.obstacleColor, int(opacity));
    stroke(0);
    strokeWeight(2);

    beginShape();
    vertex(-w, -h+25);
    vertex(w, -h);
    vertex(w, h);
    vertex(-w, h+25);

    endShape(CLOSE);

    // rect(-25, -25, 50, 50);
    popMatrix();
  }
}
class RockDebris extends Debris {


  RockDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    angle=random(360);
    VAngle=random(4)-2;
    bounceFriction=0.2;
    bounceForce=0;
    w=50;
    h=50;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));

    image(rockDebris, -w*0.5, -h*0.5, w, h);
    popMatrix();
  }
}
class TireDebris extends Debris {

  int cooldown, size;
  TireDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    bounceFriction=1;
    bounceForce=0.8;
    opacityDecay=-4;
    size=int(random(50, 80));
  }
  void update() {
    super.update();
    if (cooldown>0)cooldown--;
  }
  void hitFloor() {
    super.hitFloor();
    //if (cooldown<1 &&opacity>50)playSound(rubberSound);
    cooldown=10;
  }
  void display() {
    stroke(0, int(opacity));
    strokeWeight(int(size*0.4));
    noFill();
    ellipse(x, y, size, size);
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
class PlatFormDebris extends Debris {


  PlatFormDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    VAngle=random(6)-3;
    bounceFriction=0;
    bounceForce=0;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    fill(owner.obstacleColor, int(opacity));
    noStroke();
    rect(-25, -25, 100, 25);
    popMatrix();
  }
}
class BushDebris extends Debris {
  float offsetX;
  BushDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
    bounceForce=0;
    angle=90;
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
    if (opacity<20)death(); 
    else opacity+=opacityDecay*speedFactor;
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

