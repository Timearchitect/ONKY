abstract class Entity {
  boolean dead;
  int x, y, w, h;
  float vx, vy;
  Entity(int _x, int  _y) {
    x=_x;
    y=_y;
  }
  Entity(int _x, int  _y, int _w, int  _h) {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
  }
  Entity(int _x, int  _y, float  _vx, float  _vy) {
    x=_x;
    y=_y;
    vx=_vx;
    vy=_vy;
  }

  void update() {
  }

  void display() {
  }

  void death() {
    if (!dead) {
      dead=true;
      entities.remove(this);
    }
  }
}

