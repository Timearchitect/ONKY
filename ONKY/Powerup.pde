class Powerup {

  int x, y, time;
  float w, h, vx, vy;
  boolean dead;

  Powerup(int _x, int _y, int _time) {
    time=_time;
    x=_x;
    y=_y;
  }
  void update() {
    x+=vx;
    y+=vy;
  }
  void display() {
    fill(255);
    ellipse(x, y, w, h);
  }
  void hitCollision() {
    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("Got powerup");  
      //impactForce=p.vx+5;
      death();
    }
  }
  
  void use(){
    time--;
    if(time<=0)death();
    background(255,0,0);
  }
  
  
  void death() {
    dead=true;
  }
}

