class Powerup extends Entity{
  PImage icon;
  int  time;
  float  vx, vy;

  Powerup(int _x, int _y, int _time) {
    super(_x,  _y);
    powerups.add( this);
    time=_time;
    x=_x;
    y=_y;
    w=100;
    h=100;
  }
  void update() {
    x+=vx;
    y+=vy;
    collision();
  }
  void display() {
    fill(255);
    ellipse(x, y, w, h);
  }
  void hitCollision() {
    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("Got powerup");  
      death();
    }
  }
   void collision() {
      if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
        println("Grab!!!!"); 
        death();
        p.usedPowerup=this;
      }
  }
  void use(){
    time--;
    background(255,0,0);
    if(time<=0)death();
  }
  
  void death() {
    dead=true;
  }
}

