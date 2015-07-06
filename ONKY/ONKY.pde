/*
 *
 *  ONKY the game
 *  av Alrik He
 *
 */

// ref:
// http://javatechig.com/java/code-optimization-tips-for-java

import ddf.minim.*;
//import javax.media.opengl.*;
//import processing.opengl.*;

PGraphics GUI;
PGraphics powerupGUI;
PFont font; 
int renderObject;
Minim minim;
AudioPlayer BGM, regularSong, superSong;
AudioPlayer boxDestroySound, boxKnockSound;
AudioPlayer ironBoxDestroySound, ironBoxKnockSound, shatterSound;
AudioPlayer rubberSound, rubberKnockSound;
AudioPlayer leafSound, bloodSound;
AudioPlayer splash, waterFall,warning,Poof;
AudioPlayer blockDestroySound, smackSound;
AudioPlayer jumpSound, sliceSound, diceSound, ughSound, collectSound, laserSound, bigLaserSound, teleportSound,teleportAttackSound;

PImage  slashIcon, laserIcon, superIcon, tokenIcon, lifeIcon, slowIcon, magnetIcon;
PImage Tire, Vines, rock, lumber, lumberR, lumberL, glass, Bush, Box, brokenBox, mysteryBox, Leaf, rockDebris, Block, BlockSad, ironBox, ironBox2, ironBox3;
PImage Wood,Smoke,Tree, Tree2, Mountain, sign, Grass, waterSpriteSheet, Snake, Barrel;
PImage ONKYSpriteSheet;

int defaultSpeedLevel=12, speedLevel=defaultSpeedLevel; // default speed level
int score, tokensTaken, obstacleDestroyed, totalTokens, totalObstacle;

ArrayList<Entity> entities = new ArrayList<Entity>(); // all objects
ArrayList<Paralax> paralaxLayers = new ArrayList<Paralax>();
ArrayList<Paralax> ForegroundParalaxLayers = new ArrayList<Paralax>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Debris> debris = new ArrayList<Debris>();
ArrayList<Projectile> projectiles= new ArrayList<Projectile>();
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Particle> overParticles = new ArrayList<Particle>();
ArrayList<Powerup> powerups = new ArrayList<Powerup>();
//Paralax paralax= new Paralax();
//ParalaxObject paralaxObject=new ParalaxObject();
Player p = new Player();
color FlashColor;
boolean debug, mute, preloadObstacles=false;
final int MAX_SHAKE=200, MAX_SPEED=22, defaultPlayerOffsetX=100, defaultPlayerOffsetY=200;
int floorHeight=700, spawnHeight=250, playerOffsetX=defaultPlayerOffsetX, playerOffsetY=defaultPlayerOffsetY, flashOpacity;
float screenFactor=1, screenAngle, scaleFactor=0.5, targetScaleFactor=scaleFactor, speedFactor=1, targetSpeedFactor=speedFactor, shakeFactor, shakeX, shakeY, shakeDecay=0.85;

boolean powerUpUnlocked[]= new boolean[5];
boolean tutorialJump,tutorialDoubleJump,tutorialDuck,tutorialStomp,tutorialAttack;

void setup() {
  noSmooth();
  //noClip();
  //size(720, 1080); // vertical
  size( 1080, 720, OPENGL); // horisontal
  // hint();
   hint(DISABLE_TEXTURE_MIPMAPS);
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  font=loadFont("Roboto-Bold-48.vlw");
  textFont(font);
  loadImages();
  loadSound();
  loadGUILayer();
  loadIcon();
  //UpdateGUILife();

  loadParalax();
  if (preloadObstacles)loadObstacle();
  p.y=floorHeight-p.h;

  // entities.add(new InvisPowerup(1000, 600, 1500));
  //entities.add(new LaserPowerup(2200, 400, 600));
  // entities.add(new LaserPowerup(2100, 600, 600));
  //  entities.add(new TeleportPowerup(2100, 600, 600));
  // entities.add(new TeleportPowerup(2100, 600, 600));
  //  entities.add(new TeleportPowerup(2100, 600, 600,false));
  
  entities.add(new  hintOverLayParticle(2000, int(floorHeight-200),10, color(255,0,0)  ,"JUMP") );
  entities.add(new textParticle(2000, int(floorHeight-200),10, color(255,0,0) , "!" ));

  // entities.add(new IronBox(3200, int(floorHeight-200) ) ); // 3
   entities.add(new Box(3200, int(floorHeight-400) ,-1) ); // 3
  //entities.add(new IronBox(3000, int(floorHeight-600) ) ); // 3
  // entities.add(new IronBox(3000, int(floorHeight-200) ) ); // 3
  // entities.add(new Tire(2800, int(floorHeight-200) ) ); // 3

  // entities.add(new SlowPowerup(2200, 400, 1000));
  entities.add(new RandomPowerup(2000, 400, 500)); 
  // entities.add(new RandomPowerup(2000, 600, 500)); 
  // entities.add(new RandomPowerup(2000, 200, 500));
}

void draw() {
  frame.setTitle("ONKY  " +int(frameRate) + " fps");
  if (!preloadObstacles)  generateObstacle();
  shake();
  smoothScale();
  smoothOffset();
  smoothSlow();
  smoothAngle();
  if (!debug)adjustZoomLevel();
  //-----------------------------         Paralax   / Entity            -----------------------------------------------------------
  for (Paralax plx : paralaxLayers) {
    plx.update();
    if ( plx.x < width) plx.display(); // onscreen
  }
  if (debug) displaySign();
  displayFlash();
  pushMatrix();
  scale(scaleFactor);
  rotate(radians(screenAngle));
  translate(-p.x+playerOffsetX+shakeX, (-p.y+(height*0.5)/scaleFactor)*0.3+ shakeY);
  if (debug)renderObject=0; // for counting objects on screen

  //displayFloor(); legecy
  if (p.respawning)p.respawn() ;

  p.update();
  p.display();
  //-----------------------------         Obstacle   / Entity         -----------------------------------------------------------

  for (int i=obstacles.size () -1; i>=0; i--) {
    if (obstacles.get(i).dead)obstacles.remove(obstacles.get(i));
  }
  for (Obstacle o : obstacles) {
    //if (o.x+shakeX*2<(p.x+width/(wscaleFactor)) && (o.x+o.w-shakeX*2)/(scaleFactor)>(p.x -playerOffsetX)) {// old renderBound
    if (o.x+o.w+shakeX>p.x-p.vx-playerOffsetX-shakeX-400  && o.x-shakeX<p.x-p.vx-playerOffsetX-shakeX+(width)/scaleFactor+400) { // onscreen
      o.update();
      o.display();
      if (debug) renderObject++;
    }
  }

  if (debug) {
    fill(0, 255, 0, 100);
    rect(p.x-p.vx-playerOffsetX-shakeX+50/scaleFactor, (p.y-(height*0.3)/scaleFactor)*0.3-shakeY, (width-100+shakeX)/scaleFactor, height/scaleFactor-100+shakeY);
  }

  //-----------------------------         Powerup   / Entity         -----------------------------------------------------------
  for (int i=powerups.size () -1; i>=0; i--) {
    if (powerups.get(i).dead)powerups.remove(powerups.get(i));
  }
  for (Powerup pow : powerups) {
    if (pow.x+pow.w+shakeX>p.x-p.vx-playerOffsetX-shakeX  && pow.x-shakeX<p.x-p.vx-playerOffsetX-shakeX+(width)/scaleFactor) { // onscreen
      if (debug) renderObject++;
      pow.update();
      pow.display();
    }
  }

  //-----------------------------         Debris    / Entity       -----------------------------------------------------------

  for (int i=debris.size () -1; i>=0; i--) {
    debris.get(i).update();
    debris.get(i).display();
    if (debris.get(i).dead)debris.remove(debris.get(i));
  }
  // for (Debris d : debris)d.display();

  //-----------------------------         Particle     / Entity       -----------------------------------------------------------


  for (int i=particles.size () -1; i>=0; i--) {
    particles.get(i).update();
    particles.get(i).display();
    if (particles.get(i).dead)particles.remove(particles.get(i));
  }
  //for (Particle par : particles)par.display();

  //-----------------------------         Projectile     / Entity       -----------------------------------------------------------


  for (int i=projectiles.size () -1; i>=0; i--) {
    projectiles.get(i).update();
    projectiles.get(i).display();

    if (projectiles.get(i).dead)projectiles.remove(projectiles.get(i));
  }
  //for (Projectile pro : projectiles)pro.display();

  //-----------------------------         Entities           -----------------------------------------------------------


  //for (Entity e : entities) {
  /* if(!(e instanceof Paralax)){
   }*/

  /*if (e.getClass() == Paralax.class) {
   }*/

  /* if( !paralaxLayers.contains( e)){   // works
   }*/
  // e.display();
  // e.update();

  /*  if (! e.getClass().isInstance(paralax) && ! e.getClass().isInstance(paralaxObject)) {   // works
   e.display();
   e.update();
   }
   }*/


  /*for (int i=entities.size () -1; i>=0; i--) {
   if (entities.get(i).dead)entities.remove(entities.get(i));
   }*/
  //----------------------------¨-------------------------------------------------------------------------------------

  popMatrix();

  //-----------------------------         Paralax     / Entity       -----------------------------------------------------------

  /* for (Paralax plx : ForegroundParalaxLayers) {
   plx.update();
   if (plx.x<width)plx.display(); // onscreen
   }  */
  image(GUI, 0, 0); // add GUIlayer
  image( powerupGUI, 0, 0); // add GUIlayer
  for ( Powerup pow : p.usedPowerup) { 
    pow.displayIcon();
  }

  if (!preloadObstacles) deletePastObstacles();
  calcDispScore();
  if (debug)debugScreen();
}

void shake() {
  if (shakeFactor>0.5) {
    if (MAX_SHAKE<shakeFactor) shakeFactor=MAX_SHAKE;
    shakeFactor*=shakeDecay;
    shakeX=random(shakeFactor)-shakeFactor*0.5;
    shakeY=random(shakeFactor)-shakeFactor*0.5;
  }
}
void displayFlash() {
  if (flashOpacity>0) {
    fill(0, flashOpacity);
    noStroke();
    rect(0, 0, width, height);
  }
}
void smoothOffset() {
  if (defaultPlayerOffsetX != round(playerOffsetX)) {
    float offsetXDiff=defaultPlayerOffsetX-playerOffsetX;
    float offsetYDiff=defaultPlayerOffsetY-playerOffsetY;

    playerOffsetX+=offsetXDiff*0.02;
    playerOffsetY+=offsetYDiff*0.02;
  }
}
void smoothScale() {
  //if (round(targetScaleFactor)!=round(scaleFactor)) {
  float scaleDiff=targetScaleFactor-scaleFactor;
  scaleFactor+=scaleDiff*0.1;
  // targetScaleFactor=1;
  // scaleFactor=1;
  // }
}
void smoothSlow() {
  // if (targetSpeedFactor!=speedFactor) {
  float speedDiff=targetSpeedFactor-speedFactor;
  flashOpacity=int(255-255*speedFactor);
  speedFactor+=speedDiff*0.1;
  // }
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
  //if (p.)fill(255, 50, 0);
  // else fill(128,181,113);
  noStroke();
  fill(128, 181, 113);
  // image(Grass ,p.x-playerOffsetX-MAX_SHAKE, floorHeight+offset, width+playerOffsetX+MAX_SHAKE*2, 1000*scaleFactor);
  rect(p.x-playerOffsetX-MAX_SHAKE, floorHeight, width/(scaleFactor)+playerOffsetX+MAX_SHAKE*2, 1000);
}


void displaySign() {
  stroke(255);
  strokeWeight(1);
  int interval=100;
  for (int i=0; i< width/scaleFactor; i+=interval)
    line((i+playerOffsetX-p.x%interval)*(scaleFactor), 0, (i+playerOffsetX-p.x%interval)*(scaleFactor), height);
}

void gameReset() {
  particles.clear();
  entities.clear();
  obstacles.clear();
  powerups.clear();
  debris.clear();


  if (!mute)changeMusic(regularSong);

  speedLevel=0;

  if (preloadObstacles)loadObstacle();
  else {
    distGenerated=0;
    firstCourse=true;
    difficulty=0;
    minDifficulty=0; 
    maxDifficulty=difficultyRange;
  }

  p.reset();
  UpdateGUILife(); // resetGUI
  UpdatePowerupGUILife();


  speedFactor=1;
  targetSpeedFactor=1;
  resetScore();
}
void resetScore() {
  score=0;
  tokensTaken=0;
  obstacleDestroyed=0;

  score=0;
  totalTokens=0;
  totalObstacle=0;
}
void calcDispScore() {
  if (MAX_SPEED>speedLevel)speedLevel=int(score*0.00005+defaultSpeedLevel);
  score=int(p.x);
  fill(255);
  textSize(40);
  textAlign(RIGHT);
  text( ""+obstacleDestroyed +" boxes   "+tokensTaken +" tokens   "+int(score*0.002)  +" meter", width-50, 100);
  // text( String.format( "%.1f", speedFactor)+"X"+" velocity:"+(speedLevel-defaultSpeedLevel) +"  m: "+int(score*0.01)+"  killed: "+obstacleDestroyed +"  tokens: "+tokensTaken, width-850, 50);
  // text( String.format( "%.1f", speedFactor)+"X"+" velocity:"+(speedLevel-defaultSpeedLevel) +"  m: "+int(score*0.01)+"  total: "+totalObstacle +"  Ttokens: "+totalTokens, width-850, 100);
  textAlign(LEFT);
}
void debugScreen() {
  fill(100, 255, 0);
  textSize(18);
  text("renderO "+renderObject+" Entities: "+ entities.size()+" projetiles: "+projectiles.size()+" particles: "+particles.size()+" obstacles: "+obstacles.size() +" debris:"+debris.size()+" powerups:"+powerups.size(), 50, height-50);
}
void playSound(AudioPlayer sound) {
  if (!mute) {
    sound.rewind();
    sound.play();
  }
}
void changeMusic(AudioPlayer song) {
  if (!mute) { 
    BGM.pause();
    BGM = song;
    playSound(BGM);
    BGM.loop();
  }
}



void loadImages() {
  //ONKY player sprites
  p.ONKYSpriteSheet = loadImage("OnkySpriteSheet.png");
  p.SpriteSheetRunning = loadImage("onky_running3.png");
  p.FrontFlip = loadImage("frontFlip.png");
  p.Life = loadImage("extraLife.png");
  p.Jump = loadImage("jump.png");
  p.DownDash = loadImage("downDash.png");
  p.Slide = loadImage("slide.png");

  //icons
  slowIcon = loadImage("icon/slowpower.png");
  slashIcon = loadImage("icon/slashpower.png");
  laserIcon = loadImage("icon/laserpower2.png");
  tokenIcon = loadImage("icon/token2.png");
  superIcon = loadImage("icon/speedpower.png");
  lifeIcon = loadImage("icon/oneup.png");
  magnetIcon = loadImage("icon/magnet.png");


  //Obstacle graphics
  rock=loadImage("rock.png");
  Snake=loadImage("snake.png");
  Barrel=loadImage("barrel.png");
  Tire= loadImage("tire.png");
  ironBox = loadImage("metalBox1.png");
  ironBox2= loadImage("metalBox2.png");
  ironBox3= loadImage("metalBox3.png");
  Box= loadImage("woodenBox.png");
  glass = loadImage("glass.png");
  brokenBox= loadImage("woodenBoxBroken.png");
  mysteryBox= loadImage("mysteryWoodenBox.png");
  Grass= loadImage("grasstile.png");
  Bush = loadImage("bush.png");
  sign= loadImage("sign.png");
  Vines = loadImage("vines.png");
  lumber= loadImage("lumber22.png");
  lumberR= loadImage("lumber33.png");
  lumberL= loadImage("lumber11.png");
  Wood= loadImage("wood.png");
  waterSpriteSheet= loadImage("watertile.png");

  Block = loadImage("blockMad.png");
  BlockSad = loadImage("blockSad.png");

  //paralax
  Tree =loadImage("treetile.png");
  Tree2 =loadImage("treetile2.png");
  Mountain= loadImage("backgroundfull.png");

  //debris
  Smoke=loadImage("smoke.png");
  rockDebris=loadImage("rockDebris.png");
  Leaf  =loadImage("leaf.png");
}
void loadSound() {
  minim = new Minim(this);
  regularSong= minim.loadFile("music/KillerBlood-The Black(Paroto).wav");
  superSong = minim.loadFile("music/Super Mario - Invincibility Star.wav");
  BGM = regularSong;

  smackSound= minim.loadFile("sound/smack.wav");
  blockDestroySound= minim.loadFile("sound/blockDestroy.wav");
  boxDestroySound = minim.loadFile("sound/boxSmash.wav");
  boxKnockSound = minim.loadFile("sound/boxKnock.wav");
  ironBoxDestroySound = minim.loadFile("sound/ironBoxSmash.wav");
  ironBoxKnockSound = minim.loadFile("sound/ironBoxKnock.wav");
  shatterSound = minim.loadFile("sound/shatter.wav");
  jumpSound = minim.loadFile("sound/jump.wav");
  sliceSound = minim.loadFile("sound/slice.wav");
  diceSound= minim.loadFile("sound/dice.wav");
  ughSound= minim.loadFile("sound/ugh.wav");
  rubberSound= minim.loadFile("sound/rubberBounce.wav");
  rubberKnockSound=minim.loadFile("sound/rubberKnock.wav");
  collectSound= minim.loadFile("sound/grab.wav");
  laserSound= minim.loadFile("sound/laser2.wav");
  bigLaserSound= minim.loadFile("sound/laser.wav");
  leafSound =  minim.loadFile("sound/rustle.wav");
  teleportSound =minim.loadFile("sound/teleport.wav");
  teleportAttackSound =minim.loadFile("sound/teleportAttack.wav");
  splash=minim.loadFile("sound/splash.wav");
  waterFall=minim.loadFile("sound/waterfall.wav");
  bloodSound=minim.loadFile("sound/blood.wav");
  warning=minim.loadFile("sound/noticeMe.wav");
  Poof=minim.loadFile("sound/poof.wav");
  regularSong.setGain(-10);
  laserSound.setGain(-20);

  BGM.play();
  BGM.loop();
}


void loadParalax() {

  entities.add(new Paralax(0, -int(height*1.5)-300, width*3, int( height*3), 0.01, Mountain)); // bakgrund
  entities.add(new ParalaxObject(Tree, 0, 400, 50, 50, 0.02)); 
  entities.add(new ParalaxObject(Tree2, 255, 400, 50, 50, 0.02)); 
  entities.add(new ParalaxObject(Tree, 0, 420, 100, 100, 0.1)); 
  entities.add(new ParalaxObject(Tree2, 300, 420, 100, 100, 0.1)); 
  entities.add(new ParalaxObject(Tree, 0, 290, 250, 250, 0.2)); 
  entities.add(new ParalaxObject(Tree, 0, 120, 500, 500, 0.3));

  //ForegroundParalaxLayers.add(new ParalaxObject(300, 250-400, 700, 700, 1.2, 18, 150)); 
  //ForegroundParalaxLayers.add(new ParalaxObject(500, 50-1200, 1800, 1800, 1.4, 25, 150));
}
void loadIcon(){
  final PGraphics pg = createGraphics(41, 41, JAVA2D);
  pg.beginDraw();
  pg.image( loadImage("extraLife.png"), 0, 0, 41, 41);
  pg.endDraw();
  frame.setIconImage(pg.image);
}
