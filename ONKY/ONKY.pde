
/*
 *
 *  ONKY the game
 *  av Alrik He
 *
 */

Player p= new Player();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
int floorHeight=700, spawnHeight=250, playerOffsetX=100;
float scaleFactor=1;

void setup() {
  loadObstacle();
  //size(720, 1080); // vertical
  size( 1080, 720);
}

void draw() {
  background(255);
  pushMatrix();
  scale(scaleFactor);
  rotate(radians(-1));
  translate(-p.x+playerOffsetX, 0);

  p.update();
  p.display();

  for (Obstacle o : obstacles) {
    o.update();
    o.display();
    o.collision();
  }

  displaySign();
  displayFloor();

  popMatrix();
}

void displayFloor() {
  rect(0, floorHeight, 10000, 1000);
}

void displaySign() {
  for ( int i=0; i<100; i++) {
    line(i*100, 0, i*100, height);
    if (i%10==0)text(i*100+" meter", i*100, height*0.3);
  }
}

void loadObstacle() {
  obstacles.add(new Box(1100, floorHeight-100));
  obstacles.add(new Box(1100, floorHeight-200));
  obstacles.add(new Box(1100, floorHeight-300));
  obstacles.add(new Box(1100, floorHeight-400));

  for (int i=0; i<50; i++) obstacles.add(new Box(i*500, int (random(floorHeight-spawnHeight)-50+spawnHeight) ) );
}

