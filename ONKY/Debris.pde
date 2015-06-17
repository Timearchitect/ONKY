class Debris {
  int x, y, w, h, opacityDecay=-2;
  float angle, VAngle, vx, vy, ax, ay=0.9, opacity=255;
  boolean dead;
  Obstacle owner; 
  
  Debris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    owner=_o;
    x=_x;
    y=_y;
    vx=_vx;
    vy=_vy;
  }

  void display() {
  }

  void update() {
    if (!dead) {
      angle+=VAngle;
      x+=vx;
      y+=vy;
      vx+=ax;
      vy+=ay;
      opacity-=opacityDecay;
      if (opacity<0)dead=true;
    }
  }
}
class BoxDebris extends Debris {


  BoxDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
  }

  void display() {
    if (!dead) {
      fill(owner.obstacleColor, opacity);
      noStroke();
      rect(x, y, 50, 50);
    }
  }
}

class TireDebris extends Debris {


  TireDebris(Obstacle _o, int _x, int _y, float _vx, float _vy) {
    super( _o, _x, _y, _vx, _vy);
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

