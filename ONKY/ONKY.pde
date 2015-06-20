
/*
 *
 *  ONKY the game
 *  av Alrik He
 *
 */
import ddf.minim.*;

Minim minim;
AudioPlayer BGM;
AudioPlayer boxDestroySound, boxKnockSound;
AudioPlayer ironBoxDestroySound, ironBoxKnockSound;
AudioPlayer jumpSound, sliceSound, diceSound, ughSound;

Player p = new Player();

int speedLevel=12;
int score;
ArrayList<Entity> entities = new ArrayList<Entity>(); // all objects
ArrayList<Paralax> paralaxLayers = new ArrayList<Paralax>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Debris> debris = new ArrayList<Debris>();
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Powerup> powerups = new ArrayList<Powerup>();
Paralax paralax= new Paralax();
ParalaxObject paralaxObject=new ParalaxObject();

int floorHeight=700, spawnHeight=250, playerOffsetX=100;
float scaleFactor=1;

void setup() {
  loadObstacle();
  //size(720, 1080); // vertical
  size( 1080, 720); // horisontal

  entities.add(new Paralax(0, 250, 5000, 2000, 1)); 

  entities.add(new ParalaxObject(0, 300, 30, 100, 0.6)); 
  entities.add(new ParalaxObject(255, 350, 30, 100, 0.6)); 
  entities.add(new ParalaxObject(0, 350, 50, 200, 0.7)); 
  entities.add(new ParalaxObject(300, 350, 50, 200, 0.7)); 
  entities.add(new ParalaxObject(0, 400, 80, 300, 0.8)); 
  entities.add(new ParalaxObject(0, 370, 90, 450, 0.9));

  powerups.add( new  Powerup(11000, 600, 20000) );



  p.SpriteSheetRunning = loadImage("onky_running3.png");
  p.FrontFlip = loadImage("frontFlip.png");
  p.Life = loadImage("extraLife.png");

  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);

  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  BGM = minim.loadFile("KillerBlood-The Black(Paroto).mp3");
  boxDestroySound = minim.loadFile("boxSmash.wav");
  boxKnockSound = minim.loadFile("boxKnock.wav");
  ironBoxDestroySound = minim.loadFile("ironBoxSmash.wav");
  ironBoxKnockSound = minim.loadFile("ironBoxKnock.wav");
  jumpSound = minim.loadFile("jump.wav");
  sliceSound = minim.loadFile("slice.wav");
  diceSound= minim.loadFile("dice.wav");
  ughSound= minim.loadFile("ugh.wav");
  BGM.play();
  BGM.loop();
}

void draw() {
  background(80);



  //-----------------------------         Paralax   / Entity            -----------------------------------------------------------

  for (Paralax px : paralaxLayers) {
    px.update();
    px.display();
  }

  pushMatrix();
  scale(scaleFactor);
  rotate(radians(0));
  translate(-p.x+playerOffsetX, 0);

  // displaySign();
  displayFloor();

  p.update();
  p.display();

  //-----------------------------         Obstacle   / Entity         -----------------------------------------------------------

  for (Obstacle o : obstacles) {
    o.update();
    if (o.x<p.x+width && o.x+o.w>p.x -200)o.display();
    //o.collision();
    // o.hitCollision();
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

  //-----------------------------         Debris    / Entity       -----------------------------------------------------------

  for (Debris d : debris) {
    d.update();
    d.display();
  }
  for (int i=debris.size () -1; i>=0; i--) {
    if (debris.get(i).dead)debris.remove(debris.get(i));
  }

  //-----------------------------         Particle           -----------------------------------------------------------

  for (Particle par : particles) {
    par.update();
    par.display();
  }
  for (int i=particles.size () -1; i>=0; i--) {
    if (particles.get(i).dead)particles.remove(particles.get(i));
  }


  //-----------------------------         Entities           -----------------------------------------------------------


  /* for (Entity e : entities) {
  /* if(!(e instanceof Paralax)){
   }*/

  /*if (e.getClass() == Paralax.class) {
   }*/

  /* if( !paralaxLayers.contains( e)){   // works
   }*/



  /*  if (! e.getClass().isInstance(paralax) && ! e.getClass().isInstance(paralaxObject)) {   // works
   e.display();
   e.update();
   }
   }*/
  /* for (int i=entities.size () -1; i>=0; i--) {
   if (entities.get(i).dead)entities.remove(entities.get(i));
   }*/

  //----------------------------¨-------------------------------------------------------------------------------------




  popMatrix();
  displayLife();
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

  for (int i=1; i<100; i++) {
    switch(int(random(12))) {
    case 0:
      spawnDuck(i*2200);

      break;

    case 1:
      spawnTires(i*2200);

      break;

    case 2:
      spawnTunnel(i*2200);

      break;
    case 3:
      spawnBlock(i*2200);

      break;
    case 4:
      spawnDoubleWall(i*2200);

      break;
    case 5:
      spawnTirePool(i*2200);
      break;
    case 6:
      spawnSteps(i*2200);
      break;
    case 7:
      spawnHeap(i*2200);
      break;
    case 8:
      spawnFloatingBlock(i*2200);
      break;
    case 9:
      spawnTireTower(i*2200);
      break;
    case 10:
      spawnBoxDuck(i*2200);
      break;
    case 11:
      spawnPlatform(i*2200);
      break;
    default:
      spawnSingleWall(i*2200);
    }
  }
}

void spawnDoubleWall(int x) {
  int breakableIndex= int(random(3))+1;
  switch(breakableIndex) {
  case 3:
    entities.add(new Box(x, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x, int(floorHeight-200) ) ); // 1
    entities.add(new Box(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 2:
    entities.add(new IronBox(x, int(floorHeight-600) ) ); // 3
    entities.add(new Box(x, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x, int(floorHeight-200) ) ); // 1
    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new Box(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 1:
    entities.add(new IronBox(x, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x, int(floorHeight-400) ) ); // 2
    entities.add(new Box(x, int(floorHeight-200) ) ); // 1
    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    break;
  }
}
void spawnSingleWall(int x) {
  int breakableIndex= int(random(3))+1;
  switch(breakableIndex) {
  case 3:
    entities.add(new Box(x, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x, int(floorHeight-200) ) ); // 1
    //   entities.add(new Box(x+200, int(floorHeight-600) ) ); // 3
    //  entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    //  entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 2:
    entities.add(new IronBox(x, int(floorHeight-600) ) ); // 3
    entities.add(new Box(x, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x, int(floorHeight-200) ) ); // 1
    //  entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    //   entities.add(new Box(x+200, int(floorHeight-400) ) ); // 2
    //   entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 1:
    entities.add(new IronBox(x, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x, int(floorHeight-400) ) ); // 2
    entities.add(new Box(x, int(floorHeight-200) ) ); // 1
    //    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    //   entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    //   entities.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    break;
  }
}
void spawnTunnel(int x) {

  entities.add(new IronBox(x, int(floorHeight-200) ) ); 
  entities.add(new IronBox(x+200, int(floorHeight-400) ) ); 
  entities.add(new IronBox(x+400, int(floorHeight-400) ) ); 
  entities.add(new IronBox(x+600, int(floorHeight-400) ) );

  // entities.add(new Box(x+800, int(floorHeight-400) ) );  // <-- key
  // entities.add(new Box(x+1000, int(floorHeight-400) ) );  // <-- key


  entities.add(new IronBox(x+1200, int(floorHeight-600) ) ); 
  entities.add(new IronBox(x+1200, int(floorHeight-800) ) ); 
  entities.add(new IronBox(x+1200, int(floorHeight-1000) ) ); 
  entities.add(new IronBox(x+1200, int(floorHeight-1200) ) );
}

void spawnTires(int x) {
  entities.add(new Tire(x, int(floorHeight-200) ) ); 
  entities.add(new Tire(x+500, int(floorHeight-200) ) );
  entities.add(new Tire(x+1000, int(floorHeight-200) ) );
}
void spawnTirePool(int x) {
  entities.add(new IronBox(x-200, int(floorHeight-200) ) ); 
  entities.add(new Tire(x, int(floorHeight-200) ) ); 
  entities.add(new Tire(x+200, int(floorHeight-200) ) );
  entities.add(new Tire(x+400, int(floorHeight-200) ) );
  entities.add(new Tire(x+600, int(floorHeight-200) ) );
  entities.add(new Tire(x+800, int(floorHeight-200) ) );

  entities.add(new Tire(x, int(floorHeight-400) ) ); 
  entities.add(new Tire(x+200, int(floorHeight-400) ) );
  entities.add(new Tire(x+400, int(floorHeight-400) ) );
  entities.add(new Tire(x+600, int(floorHeight-400) ) );
  entities.add(new Tire(x+800, int(floorHeight-400) ) );

  entities.add(new IronBox(x+1000, int(floorHeight-200) ) );
}
void spawnTireTower(int x) {
  entities.add(new Tire(x, int(floorHeight-200) ) ); 
  entities.add(new Tire(x, int(floorHeight-400) ) ); 
  entities.add(new Tire(x, int(floorHeight-600) ) ); 
  entities.add(new Tire(x, int(floorHeight-800) ) );
}

void spawnDuck(int x) {
  entities.add(new IronBox(x, int(floorHeight-860) ) ); 
  entities.add(new IronBox(x, int(floorHeight-660) ) );
  entities.add(new IronBox(x, int(floorHeight-460) ) );
  entities.add(new IronBox(x, int(floorHeight-260) ) );
}
void spawnBoxDuck(int x) {
  entities.add(new IronBox(x+400, int(floorHeight-860) ) ); 
  entities.add(new IronBox(x+400, int(floorHeight-660) ) );
  entities.add(new IronBox(x+400, int(floorHeight-460) ) );
  // entities.add(new Box(x, int(floorHeight-260) ) );
  entities.add(new Box(x+250, int(floorHeight-260) ) );
  entities.add(new Box(x+450, int(floorHeight-260) ) );
  entities.add(new Box(x+650, int(floorHeight-200) ) );
}
void spawnBlock(int x) {

  entities.add(new Box(x, int(floorHeight-600) ) );
  entities.add(new Box(x+50, int(floorHeight-400) ) );
  //entities.add(new Box(x, int(floorHeight-200) ) );
  //entities.add(new Box(x+200, int(floorHeight-600) ) );
  entities.add(new Box(x+250, int(floorHeight-400) ) );
  entities.add(new Box(x+200, int(floorHeight-200) ) );
  //entities.add(new Box(x+400, int(floorHeight-600) ) );
  //entities.add(new Box(x+400, int(floorHeight-400) ) );
  entities.add(new Box(x+400, int(floorHeight-200) ) );
}
void spawnFloatingBlock(int x) {

  //  entities.add(new Box(x, int(floorHeight-600) ) );
  // entities.add(new Box(x, int(floorHeight-400) ) );
  //  entities.add(new Box(x, int(floorHeight-200) ) );
  entities.add(new Box(x+200, int(floorHeight-600) ) );
  entities.add(new Box(x+200, int(floorHeight-400) ) );
  //  entities.add(new Box(x+200, int(floorHeight-200) ) );
  entities.add(new Box(x+400, int(floorHeight-600) ) );
  entities.add(new Box(x+400, int(floorHeight-400) ) );
  entities.add(new PlatForm(x+250, int(floorHeight-200), 300, 25, true) );

  // entities.add(new Box(x+400, int(floorHeight-200) ) );
}
void spawnSteps(int x) {

  // entities.add(new IronBox(x, int(floorHeight-600) ) );
  // entities.add(new IronBox(x, int(floorHeight-400) ) );
  entities.add(new IronBox(x, int(floorHeight-200) ) );
  entities.add(new IronBox(x+200, int(floorHeight-200) ) );
  entities.add(new IronBox(x+400, int(floorHeight-200) ) );

  // entities.add(new IronBox(x+200, int(floorHeight-600) ) );
  entities.add(new Box(x+400, int(floorHeight-400) ) );
  entities.add(new IronBox(x+400, int(floorHeight-200) ) );
  entities.add(new Box(x+600, int(floorHeight-400) ) );
  entities.add(new IronBox(x+600, int(floorHeight-200) ) );
  entities.add(new Box(x+800, int(floorHeight-400) ) );
  entities.add(new IronBox(x+800, int(floorHeight-200) ) );

  entities.add(new Box(x+1000, int(floorHeight-600) ) );
  entities.add(new Box(x+1000, int(floorHeight-400) ) );
  entities.add(new IronBox(x+1000, int(floorHeight-200) ) );
  entities.add(new IronBox(x+1200, int(floorHeight-600) ) );
  entities.add(new Box(x+1200, int(floorHeight-400) ) );
  entities.add(new IronBox(x+1200, int(floorHeight-200) ) );
  entities.add(new IronBox(x+1400, int(floorHeight-600) ) );
  entities.add(new Box(x+1400, int(floorHeight-400) ) );
  entities.add(new IronBox(x+1400, int(floorHeight-200) ) );
}
void spawnHeap(int x) {

  // entities.add(new Box(x, int(floorHeight-600) ) );
  //entities.add(new Box(x, int(floorHeight-400) ) );
  entities.add(new Box(x, int(floorHeight-200) ) );
  // entities.add(new Box(x+200, int(floorHeight-600) ) );
  // entities.add(new Box(x+200, int(floorHeight-400) ) );
  entities.add(new Box(x+200, int(floorHeight-200) ) );
  //entities.add(new Box(x+400, int(floorHeight-600) ) );
  entities.add(new Tire(x+400, int(floorHeight-400) ) );
  entities.add(new Box(x+400, int(floorHeight-200) ) );
  //  entities.add(new Box(x+600, int(floorHeight-600) ) );
  entities.add(new Tire(x+600, int(floorHeight-400) ) );
  entities.add(new Box(x+600, int(floorHeight-200) ) );
  // entities.add(new Box(x+800, int(floorHeight-600) ) );
  // entities.add(new Box(x+800, int(floorHeight-400) ) );
  entities.add(new Box(x+800, int(floorHeight-200) ) );
}

void spawnPlatform(int x) {

  entities.add(new PlatForm(x, int(floorHeight-100), 1000, 50 ) );
  entities.add(new Box(x+1150, int(floorHeight-480) ) );
  entities.add(new PlatForm(x+400, int(floorHeight-300), 1000, 50) );
  entities.add(new Tire(x+1400, int(floorHeight-700) ) );
  entities.add(new PlatForm(x+800, int(floorHeight-500), 1000, 50) );
}

void reset() {
  background(0);
  BGM.rewind();

  obstacles.clear();
  loadObstacle();
  p.reset();
  score=0;
}

void calcDispScore() {
  speedLevel=int(score*0.0001+10);
  score=int(p.x);
  fill(100, 255, 0);
  textSize(40);
  text("Speed:"+(speedLevel-10)+"  SCORE: "+score, width-500, 80);
  textSize(18);
}
void playSound(AudioPlayer sound) {
  sound.rewind();
  sound.play();
}
void displayLife() {
  for (int i=0; i<p.lives; i++)
    image(p.Life, 0+50+i*50, 0+60,40,40);
}

