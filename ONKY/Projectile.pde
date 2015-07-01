abstract class Projectile extends Entity {
  int time=80;
  color projectileColor;
  Projectile(int _x, int  _y, float _vx, float _vy) {
    super( _x, _y, _vx, _vy);
    projectiles.add(this);

    vx=_vx*speedFactor;
    vy=_vy*speedFactor;
  }

  void collision() {
  }
}

class LaserProjectile extends Projectile {

  LaserProjectile(int _x, int  _y, float _vx, float _vy) {
    super( _x, _y, _vx, _vy);
    //projectiles.add(this);
    w=25;
    projectileColor= color(255, 0, 0);
    strokeWeight(10);
    stroke(projectileColor);
    fill(255);
    ellipse(x+w, y, 75, 40);
    particles.add(new sparkParticle(int(x+w), int(random(h)+y), 10, projectileColor));
    playSound(laserSound);
  }

  void display() {
    super.display();

    stroke(projectileColor);
    strokeWeight(12);
    line(x, y, x-vx*1.5, y-vy*1.5);

    stroke(255);
    strokeWeight(5);
    line(x, y, x-vx, y-vy);
  }

  void collision() {
    /* if ( floorHeight < y+vy ) {
     death();
     }*/
    if (!dead) {
      for (Obstacle o : obstacles) {
        if (!o.dead && o.x+o.w > x+vx && o.x < x  + vx && o.y+o.h > y+vy &&  o.y < y + h+vy) {
          o.damage(1);
          death();
        }
      }
    }
  }

  void update() {
    x+=vx;
    y+=vy;
    collision();
    //if ( x>p.x+width/scaleFactor) dead=true;  //off screen
    if (time<=0) dead=true;  // timelimit
    else time--;
  }

  void death() {
    super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h), 30, 0));
    strokeWeight(10);
    stroke(projectileColor);
    fill(255);
    ellipse(int(x), int(y), 75, 75);
  }
}
class BigLaserProjectile extends LaserProjectile {

  BigLaserProjectile(int _x, int  _y, float _vx, float _vy) {
    super( _x, _y, _vx, _vy);
    //projectiles.add(this);
    w=100;
    projectileColor= color(255, 0, 0);
    strokeWeight(15);
    stroke(projectileColor);
    fill(255);
    ellipse(x+w, y, 75, 40);
    playSound(laserSound);
    shakeFactor+=20;
    particles.add(new sparkParticle(int(x)-40, int(y), 20, projectileColor));
    particles.add(new sparkParticle(int(x)-40, int(y), 10, 255));
  }

  void display() {
    super.display();

    stroke(projectileColor);
    strokeWeight(30);
    line(x, y, x-vx*5, y-vy*5);

    stroke(255);
    strokeWeight(15);
    line(x, y, x-vx*3, y-vy*3);
  }

  void collision() {
    /* if ( floorHeight < y+vy ) {
     death();
     }*/
    if (!dead) {
      for (Obstacle o : obstacles) {
        if (!o.dead && !o.unBreakable && o.x+o.w > x+vx && o.x < x  + vx && o.y+o.h > y+vy &&  o.y < y + h+vy) {
          o.damage(3);
          death();
          shakeFactor+=30;
        }
      }
    }
  }

  void update() {
    x+=vx;
    y+=vy;
    vx*=1.08;
    collision();
    //if ( x>p.x+width/scaleFactor) dead=true;  //off screen
    if (time<=0) dead=true;  // timelimit
    else time--;
  }

  void death() {
    //super.death();
    entities.add(new LineParticle(int(x+w*0.5), int(y+h), 30, 0));
    strokeWeight(20);
    stroke(projectileColor);
    fill(255);
    ellipse(int(x), int(y), 200, 200);
  }
}

