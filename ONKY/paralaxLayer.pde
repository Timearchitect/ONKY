


class Paralax extends Entity {
  float angle,x, factor, heightLevel, opacity=255;
  PImage bg;
  Paralax() { // DUMMY
    super( 0, 0, 0, 0);
  }
  Paralax(int _x, int _y, int _w, int _h, float _factor) {
    super( _x, _y, _w, _h);
    paralaxLayers.add( this);

    w=_w;
    h=_h;
    factor=_factor;
  }
  Paralax(int _x, int _y, int _w, int _h, float _factor, PImage _bg) {
    this( _x, _y, _w, _h, _factor);
    //paralaxLayers.add( this);
    bg=_bg;
  }


  void update() {
    x-=p.vx*factor*speedFactor;
    //x+=vx*speedFactor;
    if (x+w<width)x=0;
  }

  void display() {
    //noStroke();
   /* if (!p.) fill(0, 0, 255);
    else  fill(100, 100, 255);
    if (bg!=null)image(bg,  int(x), int(y), int(w), int(h));
    else rect(x, y, w, h);*/
    image(bg,  int(x), int(y), int(w), int(h));
  }
}



class ParalaxObject extends Paralax {
  float x, y ;
  int repeatDistance=1;

  ParalaxObject() { // DUMMY
    super();
  }
  ParalaxObject(PImage _image,int _x, int _y, int _w, int _h, float _factor) {
    super(_x, _y, _w, _h, _factor);
    x=_x;
    y=_y;
    heightLevel=_y;
    bg=_image;
  }
  ParalaxObject(PImage _image,int _x, int _y, int _w, int _h, float _factor, int _repeatDistance) {
    this(_image,_x, _y, _w, _h, _factor);
    repeatDistance=_repeatDistance;
  }
  ParalaxObject(PImage _image,int _x, int _y, int _w, int _h, float _factor, int _repeatDistance, int _opacity) {
    this(_image,_x, _y, _w, _h, _factor, _repeatDistance);
    opacity=_opacity;
  }
  void update() {
    x-=p.vx*factor*speedFactor;
    y =-(p.y-(height*0.3)/scaleFactor)*0.15*factor+heightLevel;
    if (x+w<0)x=width*repeatDistance;
  }

  void display() {
    /*if (bg==null) {
      noStroke();
      fill(0, 100, 100);   
      rect(x, y, w, h);
    } else {*/
      tint(255, opacity);
      image(bg, int(x), int(y), int(w), int(h));
      noTint();
    //}
  }
}

