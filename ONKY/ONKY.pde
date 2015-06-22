
/*
 *
 *  ONKY the game
 *  av Alrik He
 *
 */
import ddf.minim.*;
int renderObject;
Minim minim;
AudioPlayer BGM;
AudioPlayer boxDestroySound, boxKnockSound;
AudioPlayer ironBoxDestroySound, ironBoxKnockSound, shatterSound;
AudioPlayer rubberSound;

AudioPlayer jumpSound, sliceSound, diceSound, ughSound, collectSound;

Player p = new Player();
PImage Block;
int speedLevel=14; // default speed level
int score, tokens, objectsDestroyed;
ArrayList<Entity> entities = new ArrayList<Entity>(); // all objects
ArrayList<Paralax> paralaxLayers = new ArrayList<Paralax>();
ArrayList<Paralax> ForegroundParalaxLayers = new ArrayList<Paralax>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Debris> debris = new ArrayList<Debris>();
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Powerup> powerups = new ArrayList<Powerup>();
Paralax paralax= new Paralax();
ParalaxObject paralaxObject=new ParalaxObject();

boolean debug, mute;
int floorHeight=700, spawnHeight=250, playerOffsetX=100, playerOffsety=200;
float screenAngle, scaleFactor=0.5, targetScaleFactor=scaleFactor, speedFactor=1, targetSpeedFactor=speedFactor, skakeFactor, shakeX, shakeY, shakeDecay=0.8;
final int MAX_SHAKE=200,MAX_SPEED=45;

void setup() {
  noSmooth();
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

  ForegroundParalaxLayers.add(new ParalaxObject(300, 350, 100, 1000, 1.1, 10)); 
  ForegroundParalaxLayers.add(new ParalaxObject(500, 150, 300, 1000, 1.2, 12)); 



  p.SpriteSheetRunning = loadImage("onky_running3.png");
  p.FrontFlip = loadImage("frontFlip.png");
  p.Life = loadImage("extraLife.png");
  p.Jump = loadImage("jump.png");
  p.DownDash = loadImage("downDash.png");
  p.Slide = loadImage("slide.png");

  Block = loadImage("block200.png");
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
  shatterSound = minim.loadFile("shatter.wav");
  jumpSound = minim.loadFile("jump.wav");
  sliceSound = minim.loadFile("slice.wav");
  diceSound= minim.loadFile("dice.wav");
  ughSound= minim.loadFile("ugh.wav");
  rubberSound= minim.loadFile("rubberBounce.mp3");
  collectSound= minim.loadFile("grab.wav");
  BGM.setGain(-10);
  BGM.play();
  BGM.loop();
}

void draw() {
  background(80);
  shake();
  smoothScale();
  smoothSlow();
  smoothAngle();
  if (!debug)adjustZoomLevel();
  //-----------------------------         Paralax   / Entity            -----------------------------------------------------------

  for (Paralax px : paralaxLayers) {
    px.update();
    px.display();
  }

  pushMatrix();
  scale(scaleFactor);
  rotate(radians(screenAngle));
  translate(-p.x+playerOffsetX+shakeX,(-p.y+(height*0.5)/scaleFactor)*0.3+ shakeY);

  if (debug)displaySign();
  displayFloor();

  p.update();
  p.display();

  //-----------------------------         Obstacle   / Entity         -----------------------------------------------------------
  renderObject=0;
  for (Obstacle o : obstacles) {

    //if (o.x+shakeX*2<(p.x+width/(scaleFactor)) && (o.x+o.w-shakeX*2)/(scaleFactor)>(p.x -playerOffsetX)) {// old renderBound
    // if((o.x+shakeX)/(scaleFactor)>p.x-p.vx-playerOffsetX-shakeX+50/scaleFactor  && o.x-o.w-shakeX<p.x-p.vx-playerOffsetX-shakeX+50/scaleFactor+(width-100+shakeX)/scaleFactor){
    if (o.x+o.w+shakeX>p.x-p.vx-playerOffsetX-shakeX  && o.x-shakeX<p.x-p.vx-playerOffsetX-shakeX+(width)/scaleFactor) {
      renderObject++;
      /*      strokeWeight(55);
       stroke(255, 0, 0);
       line((p.x+width/(scaleFactor)), 0, (p.x+width/(scaleFactor)), 3000);
       strokeWeight(5);
       
       stroke(0, 255, 0);
       line((p.x -playerOffsetX), 0, (p.x -playerOffsetX), 3000);*/
      o.update();

      // o.gravity();
      o.display();
    }
    //o.collision();
    // o.hitCollision();
  }
  for (int i=obstacles.size () -1; i>=0; i--) {
    if (obstacles.get(i).dead)obstacles.remove(obstacles.get(i));
  }
  if (debug) {
    fill(0, 255, 0, 100);
    rect(p.x-p.vx-playerOffsetX-shakeX+50/scaleFactor, 0+50-shakeY, (width-100+shakeX)/scaleFactor, height/scaleFactor-100+shakeY);
  }
  //-----------------------------         Powerup   / Entity         -----------------------------------------------------------

  for (Powerup pow : powerups) {
    pow.update();
    pow.display();
  }
  for (int i=powerups.size () -1; i>=0; i--) {
    if (powerups.get(i).dead)powerups.remove(powerups.get(i));
  }

  //-----------------------------         Debris    / Entity       -----------------------------------------------------------

  for (Debris d : debris) {
    d.update();
    d.display();
  }
  for (int i=debris.size () -1; i>=0; i--) {
    if (debris.get(i).dead)debris.remove(debris.get(i));
  }

  //-----------------------------         Particle     / Entity       -----------------------------------------------------------

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


  //-----------------------------         Paralax     / Entity       -----------------------------------------------------------

  for (Paralax px : ForegroundParalaxLayers) {
    px.update();
    px.display();
  }

  displayLife();
  calcDispScore();
  if (debug)debugScreen();
  if (p.lives<0)gameReset();
}

void shake() {
  if (MAX_SHAKE<skakeFactor) skakeFactor=MAX_SHAKE;
  skakeFactor*=shakeDecay;
  shakeX=random(skakeFactor)-skakeFactor*0.5;
  shakeY=random(skakeFactor)-skakeFactor*0.5;
}
void smoothScale() {
  float scaleDiff=targetScaleFactor-scaleFactor;
  scaleFactor+=scaleDiff*0.1;
}
void smoothSlow() {
  float speedDiff=targetSpeedFactor-speedFactor;
  speedFactor+=speedDiff*0.05;
}
void smoothAngle() {
  if (screenAngle!=0) {
    if (screenAngle>-1 && screenAngle<1)screenAngle=0 ;
    else screenAngle*=0.9;
  }
}
void adjustZoomLevel() {
  targetScaleFactor= map(p.vx, 0, 50, 1, 0.2);
}
void displayFloor() {
  fill(0);
  rect(p.x-playerOffsetX-MAX_SHAKE, floorHeight, width/(scaleFactor)+playerOffsetX+MAX_SHAKE*2, 1000);
}

void displaySign() {
  stroke(255);
  for ( int i=0; i<500; i++) {
    line(i*100, 0, i*100, height);
    if (i%10==0)text(i*100+" meter", i*100, height*0.3);
  }
}

void gameReset() {
  entities.clear();
  obstacles.clear();
  powerups.clear();
  debris.clear();
  background(0);
  BGM.rewind();

  loadObstacle();
  p.reset();
  p.y=floorHeight;
  p.invis=0;
  speedFactor=1;
  targetSpeedFactor=1;
  score=0;
  tokens=0;
  objectsDestroyed=0;
}

void calcDispScore() {
  speedLevel=int(score*0.0001+10);
  score=int(p.x);
  fill(100, 255, 0);
  textSize(35);
  text( String.format( "%.1f", speedFactor)+"X"+" velocity:"+(speedLevel-10) +" + "+ int(p.vx-speedLevel)+"  m: "+int(score*0.01)+"  killed: "+objectsDestroyed +"  tokens: "+tokens, width-850, 80);
  textSize(18);
}
void debugScreen() {
  fill(100, 255, 0);
  textSize(40);
  text("renderO"+renderObject+"Entities: "+ entities.size()+"particles: "+particles.size()+" obstacles: "+obstacles.size() +"debris:"+debris.size(), 50, height-50);
}
void playSound(AudioPlayer sound) {
  if (!mute) {
    sound.rewind();
    sound.play();
  }
}
void displayLife() {
  for (int i=0; i<p.lives; i++)
    image(p.Life, 0+50+i*50, 0+60, 40, 40);
}

