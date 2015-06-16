
abstract class Obstacle {
  int x, y, w=500, h=100;
  float vx, vy;

  Obstacle(int _x, int _y) {
    x=_x;
    y=_y;
  }
  void update() {
    x+=vx;
    y+=vy;
  }
  void display() {
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
      
    }

  }
}

