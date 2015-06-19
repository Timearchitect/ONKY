class Particle extends Entity {

  Particle(int _x, int  _y) {
    super( _x, _y);
  }

  void update() {
  }

  void display() {
  }

  void death() {
    super.death();
  }
}

class speedParticle extends Particle {

  speedParticle(int _x, int  _y) {
    super( _x, _y);
    particles.add(this);
    // x=_x;
    // y=_y;
  }

  void update() {

    w++;
    if (w>200)death();
  }

  void display() {
    stroke(255, 100);
    strokeWeight(3);
    noFill();
    line(x+p.vx-w, y, x-w, y);
    
    strokeWeight(1);

  }

  void death() {
    super.death();
  }
}

