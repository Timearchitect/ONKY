
abstract class Obstacle {
  int x, y, w=100, h=100;
  float vx, vy;
  color obstacleColor = color(100,100,50);
  boolean dead;
  Obstacle(int _x, int _y) {
    x=_x;
    y=_y;
  }
  void update() {
    x+=vx;
    y+=vy;
  }
  void display() {
    fill(obstacleColor);
    rect(x, y, w, h);
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y-10&&  p.y+p.h-10 < y +10) {
        p.checkIfObstacle(y-10);
        println("onTop");  
     }
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
        println("collision!!!!");  
        p.collision();
        death();
    }
  }
    void hitCollision() {

    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
        println("KILLED A BOX");  
        death();
    }
  }
  void death(){
    fragment();
   dead=true;
  }
  void fragment(){
  
  
  }
}

