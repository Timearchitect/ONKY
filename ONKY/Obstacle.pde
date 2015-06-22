
abstract class Obstacle extends Entity {
  float impactForce;
  color obstacleColor;
  int hitBrightness;
  Obstacle(int _x, int _y) {
    super( _x, _y, 200, 200);
    obstacles.add( this);
  }
  void update() {
    x+=vx*speedFactor;
    y+=vy*speedFactor;
    if (hitBrightness>0)hitBrightness*=0.8*speedFactor;
    collision();
    hitCollision();
  }
  void gravity() {
  }
  void display() {
    fill(red(obstacleColor)+hitBrightness, green(obstacleColor)+hitBrightness, blue(obstacleColor)+hitBrightness, alpha(obstacleColor));
    rect(x, y, w, h);
  }
  void collision() {
    if (p.x+p.w > x && p.x < x + w  && p.y+p.h+p.vy > y-5 &&  p.y+p.h-5 < y +20) {
      p.checkIfObstacle(y-5);

      surface();
      println("onTop");
    } else {
      if (p.x+p.w > x && p.x < x + w  && p.y+p.h > y&&  p.y < y + h) {
        println("collision!!!!"); 
        if (p.vx>5) {
          knock();
        }
        impactForce=p.vx; 
        p.collision();
        // death();
      }
    }
  }
  void surface() {
  }
  void knock() {
    knockSound();
  }
  void hitCollision() {  // hit by punching & smashing

    if (p.punching && p.x+p.w+p.punchRange > x && p.x+p.w < x + w  && p.y+p.h > y&&  p.y < y + h) {
      hit();
      impactForce=p.vx+5;
      death();
    }

    if (p.smashing && p.x+p.smashRange > x && p.x+p.w < x + w  && p.y+p.h+p.smashRange > y&&  p.y < y + h) {
      hit();
      impactForce=p.vx+5;
      death();
    }
  }
  void death() {
    super.death();
    destroySound();
    background(255);
  }
  void hit() {
    objectsDestroyed++;
    hitSound();
  }

  void hitSound() {
  }
  void knockSound() {
  }
  void destroySound() {
  }
}

