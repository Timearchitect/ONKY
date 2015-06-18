
abstract class Obstacle {
  int x, y, w=200, h=200;
  float vx, vy, impactForce;
  color obstacleColor = color(100, 100, 50);
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
      if (p.vx>5) {
      knockSound();
      }
      
      impactForce=p.vx; 
      p.collision();
      // death();
    }
  }


  void hitCollision() {  // hit by punching & smashing

    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      println("KILLED A BOX");  
      impactForce=p.vx+5;
      death();
    }

    if (p.smashing && p.x+p.smashRange > x && p.x+p.w < x + w  && p.y+p.h+p.smashRange > y&&  p.y < y + h) {
      println("KILLED A BOX");  
      impactForce=p.vx+5;
      death();
    }
  }
  
  void death() {
    destroySound();
    fragment();
    dead=true;
  }
  void fragment() {
  }
  
    void knockSound() {
    boxKnockSound.rewind();
    boxKnockSound.play();
  }
    void destroySound() {
      boxDestroySound.rewind();
      boxDestroySound.play();
  }
}
