class Projectile extends Entity {

  Projectile(int _x, int  _y, float _vx, float _vy) {
    super( _x, _y, _vx, _vy);
    projectiles.add(this);
    vx=_vx;
    vy=_vy;
    w=100;
    background(255, 0, 0);
  }

  void display() {
    super.display();

    stroke(255, 0, 0);
    strokeWeight(10);
    line(x, y, x+w, y);

    stroke(255);
    strokeWeight(5);
    line(x, y, x+w, y);
  }

  void collision() {
    for (Obstacle o : obstacles) {
      if (o.x+o.w > x && o.x < x + w  && o.y+o.h > y&&  o.y < y + h) {
        o.damage(1);
        o.hit();
        death();
      }
    }
  }

  void update() {
    super.update();

    x+=vx;
    y+=vy;
    collision();
  }

  void death() {
    super.death();
    fill(255);
    ellipse(x+w*0.5, y, 75, 75);
  }
}

