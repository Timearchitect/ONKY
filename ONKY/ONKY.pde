
/*
 *
 *  ONKY the game
 *  av Alrik He
 *
 */
import ddf.minim.*;

Minim minim;
AudioPlayer BGM;
AudioPlayer boxDestroySound;
AudioPlayer boxKnockSound;
AudioPlayer jumpSound;


Player p = new Player();

int score;
ArrayList<Paralax> paralaxLayers = new ArrayList<Paralax>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Debris> debris = new ArrayList<Debris>();
//ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Powerup> powerups = new ArrayList<Powerup>();


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

powerups.add( new  Powerup(11000, 600, 20000) );



  p.SpriteSheetRunning = loadImage("onky_running.png");


  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);

  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  //BGM = minim.loadFile("BGM.wav");
  boxDestroySound = minim.loadFile("boxSmash.wav");
  boxKnockSound = minim.loadFile("boxKnock.wav");
  //jumpSound = minim.loadFile("jump.wav");
 // BGM.play();
   
}

void draw() {
  background(255);

  //-----------------------------         Paralax           -----------------------------------------------------------

  for (Paralax px : paralaxLayers) {
    px.update();
    px.display();
  }

  pushMatrix();
  scale(scaleFactor);
  rotate(radians(0));
  translate(-p.x+playerOffsetX, 0);

  displaySign();
  displayFloor();

  p.update();
  p.display();

  //-----------------------------         Obstacle           -----------------------------------------------------------

  for (Obstacle o : obstacles) {
    o.update();
    o.display();
    o.collision();
    o.hitCollision();
  }
  for (int i=obstacles.size () -1; i>=0; i--) {
    if (obstacles.get(i).dead)obstacles.remove(obstacles.get(i));
  }

  //-----------------------------         Powerup           -----------------------------------------------------------

  /*  for (Powerup par : powerups) {
   pow.update();
   pow.display();
   }
   for (int i=powerups.size () -1; i>=0; i--) {
   if (powerups.get(i).dead)powerups.remove(powerups.get(i));
   }*/

  //-----------------------------         Debris           -----------------------------------------------------------

  for (Debris d : debris) {
    d.update();
    d.display();
  }
  for (int i=debris.size () -1; i>=0; i--) {
    if (debris.get(i).dead)debris.remove(debris.get(i));
  }

  //-----------------------------         Particle           -----------------------------------------------------------

  /* for (Particle par : particles) {
   par.update();
   par.display();
   }
   for (int i=particles.size () -1; i>=0; i--) {
   if (particles.get(i).dead)particles.remove(particles.get(i));
   }
   */

  popMatrix();
  calcDispScore();
}

void displayFloor() {
  fill(0);
  rect(p.x-playerOffsetX*2, floorHeight, width*2, 1000);
}

void displaySign() {
  stroke(255);
  for ( int i=0; i<500; i++) {
    line(i*100, 0, i*100, height);
    if (i%10==0)text(i*100+" meter", i*100, height*0.3);
  }
}

void loadObstacle() {



  spawnTunnel(500) ;

  for (int i=1; i<100; i++) {
    /*obstacles.add(new Box(i*100+3000, int(floorHeight-100) ) );
     obstacles.add(new Box(i*100+3000, int(floorHeight-200) ) );
     obstacles.add(new Box(i*100+3000, int(floorHeight-300) ) );
     obstacles.add(new Box(*100+3000, int(floorHeight-400) ) );
     obstacles.add(new Box(i*100+3000, int(floorHeight-500) ) );*/

    spawnWall(i*2000);

    /*  obstacles.add(new Box(i*1000, int(random(floorHeight-spawnHeight)-100+spawnHeight) ) );
     obstacles.add(new Box(i*2000, int(random(floorHeight-spawnHeight)-100+spawnHeight) ) );
     obstacles.add(new Box(i*2200, int(random(floorHeight-spawnHeight)-100+spawnHeight) ) );
     obstacles.add(new IronBox(i*10100, int(random(floorHeight-spawnHeight)-100+spawnHeight) ) );
     obstacles.add(new Tire(i*10300, floorHeight-100) );*/
  }
}

void spawnWall(int x) {
  int breakableIndex= int(random(3))+1;
  switch(breakableIndex) {
  case 3:
    obstacles.add(new Box(x, int(floorHeight-600) ) ); // 3
    obstacles.add(new IronBox(x, int(floorHeight-400) ) ); // 2
    obstacles.add(new IronBox(x, int(floorHeight-200) ) ); // 1
    obstacles.add(new Box(x+200, int(floorHeight-600) ) ); // 3
    obstacles.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    obstacles.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 2:
    obstacles.add(new IronBox(x, int(floorHeight-600) ) ); // 3
    obstacles.add(new Box(x, int(floorHeight-400) ) ); // 2
    obstacles.add(new IronBox(x, int(floorHeight-200) ) ); // 1
    obstacles.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    obstacles.add(new Box(x+200, int(floorHeight-400) ) ); // 2
    obstacles.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 1:
    obstacles.add(new IronBox(x, int(floorHeight-600) ) ); // 3
    obstacles.add(new IronBox(x, int(floorHeight-400) ) ); // 2
    obstacles.add(new Box(x, int(floorHeight-200) ) ); // 1
    obstacles.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    obstacles.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    obstacles.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    break;
  }
}

void spawnTunnel(int x) {

  obstacles.add(new IronBox(x, int(floorHeight-200) ) ); 
  obstacles.add(new IronBox(x+200, int(floorHeight-400) ) ); 
  obstacles.add(new IronBox(x+400, int(floorHeight-400) ) ); 
  obstacles.add(new IronBox(x+600, int(floorHeight-400) ) );

  obstacles.add(new Box(x+800, int(floorHeight-400) ) );  // <-- key
  obstacles.add(new Box(x+1000, int(floorHeight-400) ) );  // <-- key


  obstacles.add(new IronBox(x+1200, int(floorHeight-600) ) ); 
  obstacles.add(new IronBox(x+1200, int(floorHeight-800) ) ); 
  obstacles.add(new IronBox(x+1200, int(floorHeight-1000) ) ); 
  obstacles.add(new IronBox(x+1200, int(floorHeight-1200) ) );
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

