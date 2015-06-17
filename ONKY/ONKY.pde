
/*
 *
 *  ONKY the game
 *  av Alrik He
 *
 */

Player p = new Player();
int score;
ArrayList<Paralax> paralaxLayers = new ArrayList<Paralax>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
int floorHeight=700, spawnHeight=250, playerOffsetX=100;
float scaleFactor=1;

void setup() {
  loadObstacle();
  //size(720, 1080); // vertical
  size( 1080, 720); // horisontal

  paralaxLayers.add(new Paralax(0, 250, 5000, 2000, 1)); 

  paralaxLayers.add(new ParalaxObject(0, 300, 30, 100, 0.6)); 
  paralaxLayers.add(new ParalaxObject(255, 350, 30, 100, 0.6)); 
  paralaxLayers.add(new ParalaxObject(0, 350, 50, 200, 0.7)); 
  paralaxLayers.add(new ParalaxObject(300, 350, 50, 200, 0.7)); 
  paralaxLayers.add(new ParalaxObject(0, 400, 80, 300, 0.8)); 
  paralaxLayers.add(new ParalaxObject(0, 370, 90, 450, 0.9));
}

void draw() {
  background(255);
  for (Paralax px : paralaxLayers) {
    px.update();
    px.display();
  }

  pushMatrix();
  scale(scaleFactor);
  rotate(radians(-1));
  translate(-p.x+playerOffsetX, 0);

  displaySign();
  displayFloor();
  p.update();
  p.display();

  for (Obstacle o : obstacles) {
    o.update();
    o.display();
    o.collision();
    o.hitCollision();
  }
  for (int i=obstacles.size () -1; i>=0; i--) {
    if (obstacles.get(i).dead)obstacles.remove(obstacles.get(i));
  }

  popMatrix();
  calcDispScore();
}

void displayFloor() {
  fill(0);
  rect(0, floorHeight, 50000, 1000);
}

void displaySign() {
  for ( int i=0; i<200; i++) {
    line(i*100, 0, i*100, height);
    if (i%10==0)text(i*100+" meter", i*100, height*0.3);
  }
}

void loadObstacle() {
  obstacles.add(new Box(1100, floorHeight-100));
  obstacles.add(new Box(1100, floorHeight-200));
  obstacles.add(new Box(1100, floorHeight-300));
  obstacles.add(new Box(1100, floorHeight-400));
  for (int i=0; i<100; i++) {
    obstacles.add(new Box(i*1000, int(random(floorHeight-spawnHeight)-50+spawnHeight) ) );
    obstacles.add(new Box(i*2000, int(random(floorHeight-spawnHeight)-50+spawnHeight) ) );
    obstacles.add(new Box(i*2200, int(random(floorHeight-spawnHeight)-50+spawnHeight) ) );
    obstacles.add(new Box(i*10100, int(random(floorHeight-spawnHeight)-50+spawnHeight) ) );

  }
}

void reset() {
  score=0;
  p.x=0;
}
void calcDispScore() {

  score=int(p.x);
  fill(100, 255, 0);
  textSize(30);
  text("SCORE: "+score, width-300, 100);
  textSize(18);
}

