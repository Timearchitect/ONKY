


class Paralax extends Entity {
  //int x, y, w, h, vx=-20, vy;
  float angle, factor;
  PImage bg;
  Paralax() { // DUMMY
    super( 0, 0, 0, 0);
  }
  Paralax(int _x, int _y, int _w, int _h, float _factor) {
    super( _x, _y, _w, _h);
    paralaxLayers.add( this);
    // x=_x;
    // y=_y;
    w=_w;
    h=_h;
    factor=_factor;
  }

  void update() {
    x+=vx;
    y+=vy;
    if (x+w<width)x=0;

    //if(x+w<0)x=0;
  }

  void display() {
    fill(0, 0, 255);
    rect(x, y, w, h);
  }
}



class ParalaxObject extends Paralax {


  ParalaxObject() { // DUMMY
    super();
  }
  ParalaxObject(int _x, int _y, int _w, int _h, float _factor) {

    super(_x, _y, _w, _h, _factor);
  }

  void update() {
    x-=int(p.vx*factor);
    //y+=int(p.vy*0.8);
    if (x+w<0)x=width;

    //if(x+w<0)x=0;
  }

  void display() {
    fill(0, 100, 100);
    rect(x, y, w, h);
  }
}

