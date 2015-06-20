
abstract class Obstacle extends Entity{
 float impactForce;
  color obstacleColor = color(100, 100, 50);
  int hitBrightness;
  Obstacle(int _x, int _y) {
    super( _x, _y, 200, 200);
    obstacles.add( this);

  }
  void update() {
    x+=vx;
    y+=vy;
    if(hitBrightness>0)hitBrightness*=0.8;
    collision();
    hitCollision();
  }
  void display() {
    fill(red(obstacleColor)+hitBrightness,green(obstacleColor)+hitBrightness,blue(obstacleColor)+hitBrightness);
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
      hit();
      impactForce=p.vx+5;
      death();
    }

    if (p.smashing && p.x+p.smashRange > x && p.x+p.w < x + w  && p.y+p.h+p.smashRange > y&&  p.y < y + h) {
      println("KILLED A BOX");  
      hit();
      impactForce=p.vx+5;
      death();
    }
  }
  void hit(){
  }
  void death() {
    super.death();
    destroySound();

  }

    void knockSound() {

  }
    void destroySound() {

  }
}

