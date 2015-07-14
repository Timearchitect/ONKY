int  difficulty, difficultyRange=7, totalAmountOfCourses=35, totalAmountOfTutorialCourses=15;
float minDifficulty=0, maxDifficulty=difficultyRange, difficultScale=1.2;
int tutorialStep, amountOfCourses=110, distGenerated, defaultObstacleCourseDist=2200, obstacleCourseDist=defaultObstacleCourseDist, defaultLoadMargin=2900, loadMargin=defaultLoadMargin, deleteMargin=2200;
boolean firstCourse=true, tutorial=true;

void generateObstacle() {
  if (p.x+p.w+loadMargin > distGenerated ) {
    loadRandomObstacleCourse(distGenerated);
    distGenerated+=obstacleCourseDist;
  }
}
void deletePastObstacles() {
  for (int i=entities.size () -1; i>=0; i--) {
    if (entities.get(i).x+entities.get(i).w+deleteMargin<p.x)
      entities.remove(entities.get(i));
  }
  for (int i=powerups.size () -1; i>=0; i--) {
    if (powerups.get(i).x+powerups.get(i).w+deleteMargin<p.x)
      powerups.remove(powerups.get(i));
  }
  for (int i=obstacles.size () -1; i>=0; i--) {
    if (obstacles.get(i).x+obstacles.get(i).w+deleteMargin<p.x)
      obstacles.remove(obstacles.get(i));
  }
  for (int i=particles.size () -1; i>=0; i--) {
    if (particles.get(i).x+particles.get(i).w+deleteMargin<p.x)
      particles.remove(particles.get(i));
  }
  for (int i=debris.size () -1; i>=0; i--) {
    if (debris.get(i).x+debris.get(i).w+deleteMargin<p.x)
      debris.remove(debris.get(i));
  }
}

void loadObstacleCourse() {
  // entities.add(new Box(1500, int(floorHeight-200), 1) ); // ? box
  spawnFloor(-obstacleCourseDist);   // behind floor
  spawnFloor(0);  // first floor

  for (int i=1; i<amountOfCourses; i++) {
    loadRandomObstacleCourse(i*obstacleCourseDist);
  }
}
void resetTutorialCourseStats() {
  p.tutorialCourseRetries=0;
  hint=false;
  automate=false;
}
void exitTutorial() {
  speedFactor=1;
  targetSpeedFactor=1;
  scaleFactor=1.1;
  targetScaleFactor=1.1;
  playerOffsetX+=200;
  playerOffsetY=-200;
  shakeFactor+=100;
  screenAngle=5;

  if (p.x<1000)bonusSkipSpeed=3;
  tutorial=false;
  UpdateGUILife();
}
void loadRandomObstacleCourse(int x) {
  if (firstCourse) {  // first is always grass
    obstacleCourseDist=4400;
    spawnFloor(-obstacleCourseDist);
    spawnFloor(x);
    entities.add(new Sign(x+600, int(floorHeight-200), "Tutorial?\n Hit to skip. ", true));
    //        entities.add(new Sign(x+800, int(floorHeight-200), "ONKY GO!!!"));
    firstCourse=false;
  } else if (tutorial) {
    switch(tutorialStep) {
    case 0: // jumpT
      resetTutorialCourseStats();
      spawnFloor(x);
      if (tutorialStep==0)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "!" ));
      entities.add(new  stoneSign(x+300, int(floorHeight-200), "Jump"));
      entities.add(new IronBox(x+800, int(floorHeight-200), true) );  

      entities.add(new  hintOverLayParticle(x+200, int(floorHeight-200), color(0, 100, 255), 0) );

      if (p.tutorialCourseRetries==0)entities.add(new textParticle(x+1000, int(floorHeight-200), color(0, 255, 0), "Perfect" ));
      else if (p.tutorialCourseRetries<2) entities.add(new textParticle(x+1000, int(floorHeight-200), color(0, 255, 0), "Great" ));
      else entities.add(new textParticle(x+1000, int(floorHeight-200), color(0, 255, 0), "Good" ));


      tutorialStep++;
      break;
    case 1:
      resetTutorialCourseStats();      
      spawnFloor(x);
      if (tutorialStep==1)  entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));

      entities.add(new  stoneSign(x+300, int(floorHeight-200), "Double jump"));
      entities.add(new IronBox(x+1000, int(floorHeight-200) ) ); 
      entities.add(new IronBox(x+1000, int(floorHeight-400) ) );

      entities.add(new  hintOverLayParticle(x+400, int(floorHeight-200), color(0, 100, 255), 0) );    
      entities.add(new  hintOverLayParticle(x+100, int(floorHeight-200), color(0, 100, 255), 0) );

      tutorialStep++;
      break;
    case 2:
      resetTutorialCourseStats();      
      spawnFloor(x);
      if (tutorialStep==2)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good"));
      entities.add(new  stoneSign(x+300, int(floorHeight-200), "Attack"));
      entities.add(new Box(x+1000, int(floorHeight-200), 0, true) ); 
      entities.add(new IronBox(x+1000, int(floorHeight-400) ) );
      entities.add(new IronBox(x+1000, int(floorHeight-600) ) );

      entities.add(new  hintOverLayParticle(x+400, int(floorHeight-200), color(255, 0, 0), 2) );

      tutorialStep++;
      break;
    case 3:
      resetTutorialCourseStats();      
      spawnFloor(x);
      if (tutorialStep==3)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      entities.add(new  stoneSign(x+300, int(floorHeight-200), "Jump attack"));
      entities.add(new IronBox(x+1000, int(floorHeight-200) ) ); 
      entities.add(new Box(x+1000, int(floorHeight-400), 0, true) );
      entities.add(new IronBox(x+1000, int(floorHeight-600) ) );

      entities.add(new  hintOverLayParticle(x+400, int(floorHeight-200), color(0, 100, 255), 0) );
      entities.add(new  hintOverLayParticle(x+600, int(floorHeight-200), color(255, 0, 0), 2) );

      tutorialStep++;
      break;
    case 4:
      resetTutorialCourseStats();      
      spawnFloor(x);
      if (tutorialStep==4)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      entities.add(new  stoneSign(x+300, int(floorHeight-200), "Double + jump + attack"));
      entities.add(new IronBox(x+1000, int(floorHeight-200) ) ); 
      entities.add(new IronBox(x+1000, int(floorHeight-400)) );
      entities.add(new Box(x+1000, int(floorHeight-600), 0, true) );

      entities.add(new  hintOverLayParticle(x+100, int(floorHeight-200), color(0, 100, 255), 0) );
      entities.add(new  hintOverLayParticle(x+400, int(floorHeight-200), color(0, 100, 255), 0) );
      entities.add(new  hintOverLayParticle(x+600, int(floorHeight-200), color(255, 0, 0), 2) );

      tutorialStep++;
      break;

    case 5:
      resetTutorialCourseStats();      
      spawnFloor(x);
      if (tutorialStep==5)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      entities.add(new  stoneSign(x+300, int(floorHeight-200), "attack timing"));
      entities.add(new IronBox(x+1000, int(floorHeight-600) ) ); 
      entities.add(new IronBox(x+1000, int(floorHeight-400)) );
      entities.add(new IronBox(x+1200, int(floorHeight-400)) );
      entities.add(new IronBox(x+1400, int(floorHeight-400)) );

      entities.add(new Box(x+1000, int(floorHeight-200), 0, true) );
      entities.add(new Box(x+1200, int(floorHeight-200), 0, true) );
      entities.add(new Box(x+1400, int(floorHeight-200), 0, true) );


      entities.add(new  hintOverLayParticle(x+730, int(floorHeight-200), color(255, 0, 0), 2) );
      // entities.add(new  hintOverLayParticle(x+600, int(floorHeight-200), color(255, 0, 0), 2) );


      tutorialStep++;
      break;

    case 6:
      resetTutorialCourseStats();      
      if (tutorialStep==6)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      entities.add(new  stoneSign(x+300, int(floorHeight-200), "Slide"));
      entities.add(new IronBox(x+1000, int(floorHeight-250) ) ); 
      entities.add(new IronBox(x+1000, int(floorHeight-450) ) );
      entities.add(new IronBox(x+1000, int(floorHeight-650) ) );

      entities.add(new  hintOverLayParticle(x+500, int(floorHeight-200), color(0, 0, 255), 1) );

      spawnFloor(x);
      tutorialStep++;
      break;
    case 7:
      resetTutorialCourseStats();      
      if (tutorialStep==7)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      entities.add(new  stoneSign(x+300, int(floorHeight-200), "Slide more"));
      entities.add(new IronBox(x+1000, int(floorHeight-250) ) ); 
      entities.add(new IronBox(x+1200, int(floorHeight-250) ) ); 
      entities.add(new IronBox(x+1400, int(floorHeight-250) ) ); 
      entities.add(new IronBox(x+1600, int(floorHeight-250) ) ); 
      entities.add(new IronBox(x+1000, int(floorHeight-450) ) );
      entities.add(new IronBox(x+1000, int(floorHeight-650) ) );

      entities.add(new  hintOverLayParticle(x+500, int(floorHeight-200), color(0, 0, 255), 1) );
      entities.add(new  hintOverLayParticle(x+900, int(floorHeight-200), color(0, 0, 255), 1) );
      entities.add(new  hintOverLayParticle(x+1200, int(floorHeight-200), color(0, 0, 255), 1) );

      spawnFloor(x);
      tutorialStep++;
      break;
    case 8:
      resetTutorialCourseStats();      
      if (tutorialStep==8)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      spawnFloor(x);

      entities.add(new  stoneSign(x+300, int(floorHeight-200), "Slide + attack"));
      entities.add(new Box(x+1200, int(floorHeight-200), 0, true) ); 
      entities.add(new IronBox(x+1000, int(floorHeight-250) ) ); 
      entities.add(new IronBox(x+1000, int(floorHeight-450) ) );
      entities.add(new IronBox(x+1000, int(floorHeight-650) ) );

      entities.add(new  hintOverLayParticle(x+500, int(floorHeight-200), color(0, 0, 255), 1) );
      entities.add(new  hintOverLayParticle(x+800, int(floorHeight-200), color(255, 0, 0), 2) );

      tutorialStep++;
      break;
    case 9:
      resetTutorialCourseStats();      
      if (tutorialStep==9)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      entities.add(new  stoneSign(x+300, int(floorHeight-200), "Downdash"));
      spawnFloor(x);

      entities.add(new Grass(x+600, int(floorHeight-50), 200, 200) );
      entities.add(new Grass(x+800, int(floorHeight-100), 200, 200)  );
      entities.add(new Grass(x+1000, int(floorHeight-150), 200, 200)  );
      entities.add(new Grass(x+1200, int(floorHeight-200), 200, 200)  );
      entities.add(new Grass(x+1400, int(floorHeight-200), 200, 200)  );
      entities.add(new Grass(x+1600, int(floorHeight-200), 200, 200)  );


      entities.add(new IronBox(x+2000, int(floorHeight-350) ) ); 
      entities.add(new IronBox(x+2000, int(floorHeight-550) ) );
      entities.add(new IronBox(x+2000, int(floorHeight-750) ) );
      entities.add(new IronBox(x+2000, int(floorHeight-950) ) );

      entities.add(new  hintOverLayParticle(x+1300, int(floorHeight-200), color(0, 0, 255), 0) );
      entities.add(new  hintOverLayParticle(x+1650, int(floorHeight-200), color(0, 0, 255), 1) );

      tutorialStep++;
      break;
    case 10:
      resetTutorialCourseStats();      
      spawnFloor(x);
      if (tutorialStep==10)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      entities.add(new  stoneSign(x+100, int(floorHeight-200), "Jump + attack + down"));
      entities.add(new Grass(x+400, int(floorHeight-50), 200, 200) );
      entities.add(new Grass(x+600, int(floorHeight-100), 200, 200)  );
      entities.add(new Grass(x+800, int(floorHeight-150), 200, 200)  );
      entities.add(new Grass(x+1000, int(floorHeight-200), 200, 200)  );
      //entities.add(new IronBox(x+1000, int(floorHeight-200) ) ); 
      entities.add(new Sign(x+1000, int(floorHeight-400), "Stomp!!"));
      entities.add(new Glass(x+1200, int(floorHeight-200), 600, 50, true));

      entities.add(new IronBox(x+1800, int(floorHeight-400) ) );
      entities.add(new IronBox(x+1800, int(floorHeight-600) ) );
      entities.add(new IronBox(x+1800, int(floorHeight-800) ) );
      entities.add(new IronBox(x+1800, int(floorHeight-1000) ) );

      entities.add(new  hintOverLayParticle(x+100, int(floorHeight-200), color(0, 100, 255), 0) );
      entities.add(new  hintOverLayParticle(x+500, int(floorHeight-200), color(0, 100, 255), 0) );
      entities.add(new  hintOverLayParticle(x+700, int(floorHeight-200), color(255, 0, 0), 2) );
      entities.add(new  hintOverLayParticle(x+1100, int(floorHeight-200), color(0, 0, 255), 1) );

      tutorialStep++;

      break;
    case 11:
      resetTutorialCourseStats();      
      spawnFloor(x);
      if (tutorialStep==11)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      entities.add(new  stoneSign(x+100, int(floorHeight-200), "Attack + Jump"));

      entities.add(new IronBox(x+1000, int(floorHeight-800) ) );
      entities.add(new IronBox(x+1000, int(floorHeight-600) ) );
      entities.add(new IronBox(x+1000, int(floorHeight-400) ) );
      entities.add(new  Box(x+1200, int(floorHeight-400), 0, true ) );
      entities.add(new  Box(x+1400, int(floorHeight-400), 0, true ) );
      entities.add(new IronBox(x+1500, int(floorHeight-200) ) );

      entities.add(new  hintOverLayParticle(x+900, int(floorHeight-200), color(255, 0, 0), 2) );
      entities.add(new  hintOverLayParticle(x+1000, int(floorHeight-200), color(0, 100, 255), 0) );

      tutorialStep++;

      break;
    case 12:
      resetTutorialCourseStats();
      spawnFloor(x);
      if (tutorialStep==12)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Good" ));
      entities.add(new  stoneSign(x+100, int(floorHeight-200), "Powerups"));
      powerups.add( new  TeleportPowerup(x+1100, int(floorHeight-300), 300, 400, true, true) );

      entities.add(new IronBox(x+1200, int(floorHeight-200), true) ); 
      entities.add(new IronBox(x+1200, int(floorHeight-400), true) ); 
      entities.add(new IronBox(x+1200, int(floorHeight-600), true) );
      //entities.add(new IronBox(x+1000, int(floorHeight-600) ) ); 
      entities.add(new  hintOverLayParticle(x+600, int(floorHeight-200), color(0, 100, 255), 0) );

      tutorialStep++;
      break;
    case 13:
      resetTutorialCourseStats();
      spawnFloor(x);
      if (tutorialStep==13)entities.add(new textParticle(x+500, int(floorHeight-200), color(0, 255, 0), "Last" ));
      entities.add(new  stoneSign(x+100, int(floorHeight-200), "Tap the \n Powerup"));
      powerups.add( new  TeleportPowerup(x+600, int(floorHeight-100), 350, 450, false, true) );
      powerups.add( new  TeleportPowerup(x+600, int(floorHeight-300), 350, 450, false, true) );
      powerups.add( new  TeleportPowerup(x+600, int(floorHeight-500), 350, 450, false, true) );

      entities.add(new  hintOverLayParticle(x+500, int(floorHeight-200), color(0, 100, 255), 4) );
      entities.add(new  hintOverLayParticle(x+1300, int(floorHeight-200), color(0, 100, 255), 5) );

      entities.add(new IronBox(x+1600, int(floorHeight-600), true) );
      entities.add(new IronBox(x+1600, int(floorHeight-400), true) );
      entities.add(new IronBox(x+1600, int(floorHeight-200), true) );


      tutorialStep++;
      break;
    default:
      resetTutorialCourseStats();
      obstacleCourseDist= defaultObstacleCourseDist ;
      spawnFloor(x);
      entities.add(new Sign(x+100, int(floorHeight-200), "Hit me! \n to skip", true));
    }
  } else {
    loadMargin=defaultLoadMargin;
    if (totalAmountOfCourses+difficultyRange<minDifficulty) { // check if loop
      minDifficulty=0;
      maxDifficulty=difficultyRange; // resets
    }
    minDifficulty+=difficultScale;
    maxDifficulty+=difficultScale;
    difficulty=floor(random(maxDifficulty-minDifficulty))+int(minDifficulty-difficultyRange);
    //  println(difficulty);
    // println("min: "+minDifficulty+" max: "+maxDifficulty);

    if (difficulty<0)difficulty=0;  

    switch(difficulty) {
    case 0:
      //spawnPool(x);
      spawnBarrel(x);
      spawnSnake(x);
      spawnFloor(x);
      //  spawnSingleWall(x);
      entities.add(new Sign(x-200, int(floorHeight-200), "ONKY GO!!!"));
      spawnBush(x);
      break;
    case 1:
      entities.add(new Sign(x-200, int(floorHeight-200), "Hill"));
      spawnHill(x); 
      break;
    case 2:
      entities.add(new Sign(x-200, int(floorHeight-200), "UnderGround"));
      spawnUnderGround(x); 
      break;
    case 3:
      entities.add(new Sign(x-200, int(floorHeight-200), "bush"));
      spawnFloor(x);
      spawnBush(x);
      break;
    case 4:
      entities.add(new Sign(x-200, int(floorHeight-200), "1 wall"));
      spawnFloor(x);
      spawnSingleWall(x);
      break;
    case 5:
      entities.add(new Sign(x-200, int(floorHeight-200), "Tires"));
      spawnFloor(x);
      spawnTires(x);
      break;
    case 6:
      entities.add(new Sign(x-200, int(floorHeight-200), "water"));
      spawnWater(x);
      break;
    case 7:
      entities.add(new Sign(x-200, int(floorHeight-200), "Duck"));
      spawnFloor(x);
      spawnDuck(x);
      break;
    case 8:
      entities.add(new Sign(x-200, int(floorHeight-200), "FloatingBlock"));
      spawnFloor(x);
      spawnFloatingBlock(x);
      break;
    case 9:
      entities.add(new Sign(x-200, int(floorHeight-200), "2 wall"));
      spawnFloor(x);
      spawnDoubleWall(x);
      break;
    case 10:
      entities.add(new Sign(x-200, int(floorHeight-200), "tirePool"));
      spawnFloor(x);
      spawnTirePool(x);
      break;
    case 11:
      entities.add(new Sign(x-200, int(floorHeight-200), "metal wall"));
      spawnFloor(x);
      spawnMetalWall(x);
      break;
    case 12:
      entities.add(new Sign(x-200, int(floorHeight-200), "Heap"));
      spawnFloor(x);
      spawnHeap(x);
      break;
    case 13:
      entities.add(new Sign(x-200, int(floorHeight-200), "TiltedBoxes"));
      spawnFloor(x);
      spawnTiltedBoxes(x);
      break;
    case 14:
      entities.add(new Sign(x-200, int(floorHeight-200), "TireTower"));
      spawnFloor(x);
      spawnTireTower(x);
      break;
    case 15:
      entities.add(new Sign(x-200, int(floorHeight-200), "BoxDuck"));
      spawnFloor(x);
      spawnBoxDuck(x);
      break;
    case 16:
      entities.add(new Sign(x-200, int(floorHeight-200), "Platform"));
      spawnFloor(x);
      spawnLumber(x);
      break;
    case 17:
      entities.add(new Sign(x-200, int(floorHeight-200), "boxplatform"));
      spawnFloor(x);
      spawnBoxLumber(x);
      break;
    case 18:
      entities.add(new Sign(x-200, int(floorHeight-200), "barrier"));
      spawnFloor(x);
      spawnBarrier(x);
      break;
    case 19:
      entities.add(new Sign(x-200, int(floorHeight-200), "biuldingFrame"));
      spawnFloor(x);
      spawnBiuldingFrame(x);
      break;
    case 20:
      entities.add(new Sign(x-200, int(floorHeight-200), "steps"));
      spawnFloor(x);
      spawnSteps(x);
      break;
    case 21:  
      spawnFloor(x);
      spawnBlock(x);
      break;
    case 22:
      entities.add(new Sign(x-200, int(floorHeight-200), "Blocks"));
      spawnFloor(x);
      spawnBlocks(x);
      break;
    case 23:
      entities.add(new Sign(x-200, int(floorHeight-200), "IronPath"));
      spawnFloor(x);
      spawnIronPath(x);
      break;
    case 24:
      entities.add(new Sign(x-200, int(floorHeight-200), "Tunnel"));
      spawnFloor(x);
      spawnTunnel(x);
      break;  
    case 25:
      entities.add(new Sign(x-200, int(floorHeight-200), "TowerFrame"));
      spawnFloor(x);
      spawnTowerFrame(x);
      break;

    case 26:
      entities.add(new Sign(x-200, int(floorHeight-200), "Dounut"));
      spawnFloor(x);
      spawnDounut(x);
      break;
    case 27:
      entities.add(new Sign(x-200, int(floorHeight-200), "Timegate"));
      spawnFloor(x);
      spawnTimeGate(x);
      break;
    case 28:
      entities.add(new Sign(x-200, int(floorHeight-200), "slashArena"));
      spawnSlashArena(x);
      break;
    case 29:
      entities.add(new Sign(x-200, int(floorHeight-200), "shell"));
      spawnFloor(x);
      spawnShell(x);
      break;
    case 30:
      entities.add(new Sign(x-200, int(floorHeight-200), "Islands"));
      spawnIslands(x);
      break;
    case 31:
      entities.add(new Sign(x-200, int(floorHeight-200), "Islands"));
      spawnIslands(x);
      break;
    case 32:
      entities.add(new Sign(x-200, int(floorHeight-200), "Good luck!"));
      spawnPool(x);
      break;
    case 33:
      entities.add(new Sign(x-200, int(floorHeight-200), "happy!"));
      spawnFloor(x);
      spawnTokenParadise(x);
      break;
    case 34:
      entities.add(new Sign(x-200, int(floorHeight-200), "LaserArea"));
      spawnFloor(x);
      spawnLaserArena(x);
      break;

    case 35:
      entities.add(new Sign(x-200, int(floorHeight-200), "flak"));
      spawnFloor(x);
      spawnFlak(x);
      break;
    default:

      //spawnIslands(x);
      //spawnWater(x);
      //spawnUnderGround(x); 
      entities.add(new Sign(x-200, int(floorHeight-200), "default"));
      spawnFloor(x);
      spawnSingleWall(x);
      spawnBush(x);
    }
  }
}
void spawnFloor(int x) {
  for (int i=0; i<obstacleCourseDist; i+=200) {
    entities.add(new Grass(x+i, int(floorHeight), 200, 200 ) );
  }
}
void spawnDoubleWall(int x) {
  obstacleCourseDist=2200;
  int breakableIndex= int(random(3));
  switch(breakableIndex) {
  case 2:
    entities.add(new Box(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    entities.add(new Box(x+400, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+400, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+400, int(floorHeight-200) ) ); // 1
    break;
  case 1:
    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new Box(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    entities.add(new IronBox(x+400, int(floorHeight-600) ) ); // 3
    entities.add(new Box(x+400, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+400, int(floorHeight-200) ) ); // 1
    break;
  case 0:
    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    entities.add(new IronBox(x+400, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+400, int(floorHeight-400) ) ); // 2
    entities.add(new Box(x+400, int(floorHeight-200) ) ); // 1
    break;
  }
}
void spawnSingleWall(int x) {
  obstacleCourseDist=2200;
  int breakableIndex= int(random(4));
  switch(breakableIndex) {
  case 3:
    entities.add(new Box(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    //   entities.add(new Box(x+200, int(floorHeight-600) ) ); // 3
    //   entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    //   entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 2:
    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new Box(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    //   entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    //   entities.add(new Box(x+200, int(floorHeight-400) ) ); // 2
    //   entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 1:
    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    //   entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    //   entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    //   entities.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 0:
    entities.add(new Box(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new Box(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    //   entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    //   entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    //   entities.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    break;
  }
  int index= int(random(7));
  if (index==0) powerups.add( new  TokenPowerup(x+600, int(floorHeight-500), 200) );
  if (index==2) powerups.add( new  RandomPowerup(x+600, int(floorHeight-300), 1000) );
}
void spawnTunnel(int x) {
  obstacleCourseDist=2200;
  int index= int(random(4));
  if (index==0) powerups.add( new  TokenPowerup(x+1000, int(floorHeight-550), 200) );
  if (index==2) powerups.add( new  RandomPowerup(x+1500, int(floorHeight-550), 1000) );
  if (index==1) entities.add(new Box(x, int(floorHeight-200) ) ); 

  else entities.add(new IronBox(x, int(floorHeight-200) ) ); 
  entities.add(new IronBox(x+200, int(floorHeight-300) ) ); 
  entities.add(new IronBox(x+400, int(floorHeight-300) ) ); 
  // entities.add(new IronBox(x+600, int(floorHeight-300) ) );

  entities.add(new Glass(x+600, int(floorHeight-350), 200, 50 ) );  // <-- key
  entities.add(new Glass(x+800, int(floorHeight-350), 200, 50) );  // <-- key
  entities.add(new Glass(x+1000, int(floorHeight-350), 200, 50 ) );  // <-- key

  entities.add(new IronBox(x+1200, int(floorHeight-600) ) ); 
  entities.add(new IronBox(x+1200, int(floorHeight-800) ) ); 
  entities.add(new IronBox(x+1200, int(floorHeight-1000) ) ); 
  entities.add(new IronBox(x+1200, int(floorHeight-1200) ) );
}

void spawnTires(int x) {
  obstacleCourseDist=2200;
  entities.add(new Tire(x, int(floorHeight-200) ) ); 
  entities.add(new Tire(x+500, int(floorHeight-200) ) );
  entities.add(new Tire(x+1000, int(floorHeight-200) ) );
}
void spawnTirePool(int x) {
  obstacleCourseDist=2200;
  int index= int(random(3));
  entities.add(new IronBox(x, int(floorHeight-200) ) ); 
  entities.add(new Tire(x+200, int(floorHeight-200) ) ); 
  entities.add(new Tire(x+400, int(floorHeight-200) ) );
  if (index==0) entities.add(new Tire(x+600, int(floorHeight-200) ) );
  entities.add(new Tire(x+800, int(floorHeight-200) ) );
  entities.add(new Tire(x+1000, int(floorHeight-200) ) );

  entities.add(new Tire(x+200, int(floorHeight-400) ) ); 
  entities.add(new Tire(x+400, int(floorHeight-400) ) );
  if (index==0) entities.add(new Tire(x+600, int(floorHeight-400) ) );
  entities.add(new Tire(x+800, int(floorHeight-400) ) );
  entities.add(new Tire(x+1000, int(floorHeight-400) ) );

  entities.add(new IronBox(x+1200, int(floorHeight-200) ) );

  if (index==1) powerups.add( new  TokenPowerup(x+700, int(floorHeight-350), 200) );
}
void spawnTireTower(int x) {
  obstacleCourseDist=2200;
  entities.add(new Tire(x, int(floorHeight-200) ) ); 
  entities.add(new Tire(x, int(floorHeight-400) ) ); 
  entities.add(new Tire(x, int(floorHeight-600) ) ); 
  entities.add(new Tire(x, int(floorHeight-800) ) );
}

void spawnDuck(int x) {
  obstacleCourseDist=2200;
  int index= int(random(3));
  if (index==0) entities.add(new IronBox(x+400, int(floorHeight-660) ) );
  else  entities.add(new Box(x+400, int(floorHeight-660) ) );
  if (index==1) powerups.add( new  TeleportPowerup(x+250, int(floorHeight-350), 200, 500) );
  entities.add(new IronBox(x+400, int(floorHeight-860) ) ); 
  entities.add(new IronBox(x+400, int(floorHeight-460) ) );
  entities.add(new IronBox(x+400, int(floorHeight-260) ) );
}
void spawnBoxDuck(int x) {
  obstacleCourseDist=2200;
  int index= int(random(2));
  entities.add(new IronBox(x+400, int(floorHeight-860) ) ); 
  entities.add(new IronBox(x+400, int(floorHeight-660) ) );
  entities.add(new IronBox(x+400, int(floorHeight-460) ) );
  // entities.add(new Box(x, int(floorHeight-260) ) );
  if (index==0) {
    entities.add(new Box(x+300, int(floorHeight-260) ) );
    entities.add(new Box(x+500, int(floorHeight-260) ) );
  } else {
    entities.add(new Box(x+900, int(floorHeight-600) ) );
    entities.add(new Box(x+900, int(floorHeight-400) ) );
  }
  entities.add(new Box(x+900, int(floorHeight-200) ) );
}
void spawnTiltedBoxes(int x) {
  obstacleCourseDist=2200;
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
  obstacleCourseDist=2200;
  int index= int(random(3));
  if (index==0) {
    entities.add(new Box(x+200, int(floorHeight-600) ) );
    entities.add(new Box(x+200, int(floorHeight-400) ) );
    entities.add(new Box(x+400, int(floorHeight-600) ) );
    entities.add(new Box(x+400, int(floorHeight-400) ) );
  } else if (index==1) {
    entities.add(new Glass(x+250, int(floorHeight-400), 50, 200));
    entities.add(new Glass(x+350, int(floorHeight-400), 50, 200));
    entities.add(new Glass(x+450, int(floorHeight-400), 50, 200));
  } else {
    entities.add(new Tire(x+200, int(floorHeight-400) ) );
    entities.add(new Tire(x+400, int(floorHeight-400) ) );
    entities.add(new Tire(x+300, int(floorHeight-600) ) );
  }
  entities.add(new Lumber(x+250, int(floorHeight-200), 300, 25, true) );


  // entities.add(new Box(x+400, int(floorHeight-200) ) );
}
void spawnSteps(int x) {
  obstacleCourseDist=2200;
  int index= int(random(4));
  if (index==1) powerups.add( new  TeleportPowerup(x+300, int(floorHeight-300), 200, 1000) );
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
  //entities.add(new Box(x+1200, int(floorHeight-400) ) );
  entities.add(new IronBox(x+1200, int(floorHeight-200) ) );
  entities.add(new IronBox(x+1400, int(floorHeight-600) ) );
  //entities.add(new Box(x+1400, int(floorHeight-400) ) );
  //entities.add(new IronBox(x+1400, int(floorHeight-200) ) );
  if (index==0) powerups.add( new  TokenPowerup(x+1700, int(floorHeight-150), 200) );
}
void spawnHeap(int x) {
  obstacleCourseDist=2200;
  int index= int(random(4));

  // entities.add(new Box(x, int(floorHeight-600) ) );
  //entities.add(new Box(x, int(floorHeight-400) ) );
  if (index!=0) entities.add(new Box(x, int(floorHeight-200) ) );
  // entities.add(new Box(x+200, int(floorHeight-600) ) );
  // entities.add(new Box(x+200, int(floorHeight-400) ) );
  entities.add(new Box(x+200, int(floorHeight-200) ) );
  //entities.add(new Box(x+400, int(floorHeight-600) ) );
  if (index!=3) entities.add(new Tire(x+400, int(floorHeight-400) ) );
  if (index!=2)entities.add(new Box(x+400, int(floorHeight-200) ) );
  //  entities.add(new Box(x+600, int(floorHeight-600) ) );
  entities.add(new Tire(x+600, int(floorHeight-400) ) );
  if (index!=2) entities.add(new Box(x+600, int(floorHeight-200) ) );
  // entities.add(new Box(x+800, int(floorHeight-600) ) );
  // entities.add(new Box(x+800, int(floorHeight-400) ) );
  if (index!=1)  entities.add(new Box(x+800, int(floorHeight-200) ) );
}

void spawnLumber(int x) {
  obstacleCourseDist=2200;
  int index= int(random(3));
  if (index==0) powerups.add( new  TokenPowerup(x+1000, int(floorHeight-600), 200) );
  entities.add(new Lumber(x, int(floorHeight-100), 500, 50, true) );
  entities.add(new Box(x+1150, int(floorHeight-480) ) );
  entities.add(new Lumber(x+400, int(floorHeight-300), 1000, 50, true) );
  entities.add(new Tire(x+1400, int(floorHeight-700) ) );
  entities.add(new Lumber(x+800, int(floorHeight-500), 900, 50, true) );
}

void spawnBoxLumber(int x) {
  obstacleCourseDist=2200;
  int index= int(random(5));
  if (index==0) powerups.add( new  TokenPowerup(x+700, int(floorHeight-100), 200) );
  if (index==1) powerups.add( new  TokenPowerup(x+700, int(floorHeight-600), 200) );
  if (index==2) powerups.add( new  RandomPowerup(x+700, int(floorHeight-600), 1000) );

  for (int i=0; i<6; i++) {
    entities.add(new Box(x+i*255, int(floorHeight-400) ) );
  }
  entities.add(new Lumber(x, int(floorHeight-200), 1500, 50, true) );
}

void spawnBarrier(int x) {
  obstacleCourseDist=2200;
  int index= int(random(5));
  if (index==0) powerups.add( new  TokenPowerup(x+1600, int(floorHeight-650), 200) );
  if (index==1) powerups.add( new  RandomPowerup(x+1600, int(floorHeight-650), 200) );

  entities.add(new Glass(x, int(floorHeight-200), 50, 200));
  entities.add(new Glass(x+150, int(floorHeight-200), 50, 200));
  entities.add(new Glass(x+300, int(floorHeight-200), 50, 200));
  entities.add(new Glass(x+450, int(floorHeight-200), 50, 200));
  entities.add(new Glass(x+600, int(floorHeight-200), 50, 200));
  entities.add(new Glass(x+750, int(floorHeight-200), 50, 200));


  entities.add(new Glass(x, int(floorHeight-400), 50, 200));
  entities.add(new Glass(x+150, int(floorHeight-400), 50, 200));
  entities.add(new Glass(x+300, int(floorHeight-400), 50, 200));
  entities.add(new Glass(x+450, int(floorHeight-400), 50, 200));
  entities.add(new Glass(x+600, int(floorHeight-400), 50, 200));
  entities.add(new Glass(x+750, int(floorHeight-400), 50, 200));

  entities.add(new Glass(x, int(floorHeight-600), 50, 200));
  entities.add(new Glass(x+150, int(floorHeight-600), 50, 200));
  entities.add(new Glass(x+300, int(floorHeight-600), 50, 200));
  entities.add(new Glass(x+450, int(floorHeight-600), 50, 200));
  entities.add(new Glass(x+600, int(floorHeight-600), 50, 200));
  entities.add(new Glass(x+750, int(floorHeight-600), 50, 200));
}
void spawnBiuldingFrame(int x) {
  obstacleCourseDist=2200;
  int index= int(random(5));
  if (index==0) powerups.add( new  TokenPowerup(x+450, int(floorHeight-65), 200) );
  if (index==1) powerups.add( new  TokenPowerup(x+450, int(floorHeight-300), 200) );
  if (index==2) powerups.add( new  TokenPowerup(x+450, int(floorHeight-550), 200) );
  if (index==3) powerups.add( new  RandomPowerup(x+450, int(floorHeight-550), 1000) );

  entities.add(new Glass(x, int(floorHeight-150), 50, 150));
  entities.add(new Lumber(x, int(floorHeight-200), 900, 50 ) );
  entities.add(new Glass(x+850, int(floorHeight-150), 50, 150));

  entities.add(new Glass(x, int(floorHeight-400), 50, 200));
  entities.add(new Lumber(x, int(floorHeight-450), 900, 50 ) );
  entities.add(new Glass(x+850, int(floorHeight-400), 50, 200));

  entities.add(new Glass(x, int(floorHeight-650), 50, 200));
  entities.add(new Lumber(x, int(floorHeight-700), 900, 50 ) );
  entities.add(new Glass(x+850, int(floorHeight-650), 50, 200));
}
void spawnTowerFrame(int x) {
  obstacleCourseDist=2200;
  int index= int(random(2));

  entities.add(new Glass(x, int(floorHeight-400), 50, 400));
  entities.add(new Lumber(x, int(floorHeight-1000), 50, 600 ) );
  for (int j=0; j<6; j++) {
    for (int i=0; i<4; i++) {
      entities.add(new Glass(x+50+j*200, int(floorHeight-i*150-200), 200, 50));
    }
  }
  if (index==0) {
    entities.add(new Lumber(x+1250, int(floorHeight-600), 50, 400 ) );
    entities.add(new Glass(x+1250, int(floorHeight-1000), 50, 400));
  } else {
    entities.add(new Lumber(x+1250, int(floorHeight-350), 50, 350 ) );
    entities.add(new Glass(x+1250, int(floorHeight-550), 50, 200));
    entities.add(new Lumber(x+1250, int(floorHeight-950), 50, 400 ) );
  }
}
void spawnBlocks(int x) {
  obstacleCourseDist=2200;
  int index= int(random(2));
  entities.add(new textParticle(x+200, int(floorHeight-200), color(255, 0, 0), "!" ));
  entities.add(new textParticle(x+1000, int(floorHeight-200), color(255, 0, 0), "!" ));

  // entities.add(new IronBox(x, int(floorHeight-600) ) );
  // entities.add(new IronBox(x, int(floorHeight-400) ) );
  entities.add(new Block(x+2000, int(floorHeight-200), -100, -45 ) );
  // entities.add(new Block(x+200, int(floorHeight-200) ) );
  // entities.add(new Block(x+400, int(floorHeight-200) ) );
  entities.add(new Rock(x+1200, int(floorHeight-200) ) );
  entities.add(new Rock(x+1800, int(floorHeight-200) ) );

  entities.add(new Block(x+1000, int(floorHeight-1200), -45, 10 ) );

  if (index==0) powerups.add( new  TokenPowerup(x+1200, int(floorHeight-750), 200) );
  if (index==1) powerups.add( new  TokenPowerup(x+300, int(floorHeight-150), 200) );
}
void spawnDounut(int x) {
  obstacleCourseDist=2200;
  int index= int(random(3));
  powerups.add( new  LaserPowerup(x-150, int(floorHeight-300), 300) );

  entities.add(new Box(x+200, int(floorHeight-200) ) );
  entities.add(new Box(x+200, int(floorHeight-400) ) );
  entities.add(new Box(x+200, int(floorHeight-600) ) );
  entities.add(new Box(x+0, int(floorHeight-200) ) );
  // entities.add(new Box(x-200, int(floorHeight-400) ) );
  entities.add(new Box(x+0, int(floorHeight-600) ) );
  entities.add(new Box(x-200, int(floorHeight-200) ) );
  entities.add(new Box(x-200, int(floorHeight-400) ) );
  entities.add(new Box(x-200, int(floorHeight-600) ) );
  if (index==0) powerups.add( new  TokenPowerup(x+1000, int(floorHeight-800), 200) );
  if (index==1) powerups.add( new  TokenPowerup(x+200, int(floorHeight-350), 200) );
  if (index==2) powerups.add( new  LaserPowerup(x+200, int(floorHeight-350), 200) );


  entities.add(new Box(x+200, int(floorHeight-600) ) );
  entities.add(new Box(x+200, int(floorHeight-200) ) );
}
void spawnLaserArena(int x) {
  obstacleCourseDist=2200;
  powerups.add( new  LaserPowerup(x-400, int(floorHeight-700), 200) );
  powerups.add( new  LaserPowerup(x-400, int(floorHeight-500), 200) );
  powerups.add( new  LaserPowerup(x-400, int(floorHeight-300), 200) );
  powerups.add( new  LaserPowerup(x-400, int(floorHeight-100), 200) );

  for (int i=0; i<5; i++) {
    entities.add(new Box(x+i*250+200, int(floorHeight-200) ) );
    entities.add(new Box(x+i*250+200, int(floorHeight-400) ) );
    entities.add(new Box(x+i*250+200, int(floorHeight-600) ) );
  }
}

void spawnBush(int x) {
  obstacleCourseDist=2200;
  int noBushes = int(random(6));
  for (int i=0; i<noBushes; i++) {
    entities.add(new Bush(x-0+i*100, int(floorHeight-100) ) );
  }
  if (noBushes==4) powerups.add( new  TokenPowerup(x+300, int(floorHeight-100), 200) );
}

void spawnTimeGate(int x) {
  obstacleCourseDist=2200;
  powerups.add( new  SlowPowerup(x-400, int(floorHeight-700), 500) );
  powerups.add( new  SlowPowerup(x-400, int(floorHeight-500), 500) );
  powerups.add( new  SlowPowerup(x-400, int(floorHeight-300), 500) );
  powerups.add( new  SlowPowerup(x-400, int(floorHeight-100), 500) );

  for (int i=0; i<12; i++) {
    int j = int(random(3));
    entities.add(new Box(x+i*100+100, int(floorHeight-j*200)-200 ) );
  }
}

void spawnSlashArena(int x) {
  obstacleCourseDist=2200;
  int index= int(random(3));
  if (index==0) {
    powerups.add( new  TeleportPowerup(x+0, int(floorHeight-100), 100, 400) );
    entities.add(new IronBox(x+100, int(floorHeight-200) ) );
    entities.add(new Lumber(x+100, int(floorHeight-0), 200, 25, true) );
  } else if (index==1) {
    powerups.add( new  TeleportPowerup(x+0, int(floorHeight-300), 100, 400) );
    entities.add(new IronBox(x+100, int(floorHeight-400) ) );
    entities.add(new Lumber(x+100, int(floorHeight-200), 200, 25, true) );
  } else {
    powerups.add( new  TeleportPowerup(x+0, int(floorHeight-500), 100, 400) );
    entities.add(new IronBox(x+100, int(floorHeight-600) ) );
    entities.add(new Lumber(x+100, int(floorHeight-400), 200, 25, true) );
  }

  index= int(random(3));
  if (index==0) {
    powerups.add( new  TeleportPowerup(x+400, int(floorHeight-100), 100, 400) );
    entities.add(new IronBox(x+500, int(floorHeight-200) ) );
    entities.add(new Lumber(x+500, int(floorHeight-0), 200, 25, true) );
  } else if (index==1) {
    powerups.add( new  TeleportPowerup(x+400, int(floorHeight-300), 100, 400) );
    entities.add(new IronBox(x+500, int(floorHeight-400) ) );
    entities.add(new Lumber(x+500, int(floorHeight-200), 200, 25, true) );
  } else {
    powerups.add( new  TeleportPowerup(x+400, int(floorHeight-500), 100, 400) );
    entities.add(new IronBox(x+500, int(floorHeight-600) ) );
    entities.add(new Lumber(x+500, int(floorHeight-400), 200, 25, true) );
  }
  index= int(random(3));
  if (index==0) {
    powerups.add( new  TeleportPowerup(x+800, int(floorHeight-100), 100, 400) );
    entities.add(new IronBox(x+900, int(floorHeight-200) ) );
    entities.add(new Lumber(x+900, int(floorHeight-0), 200, 25, true) );
  } else if (index==1) {
    powerups.add( new  TeleportPowerup(x+800, int(floorHeight-300), 100, 400) );
    entities.add(new IronBox(x+900, int(floorHeight-400) ) );
    entities.add(new Lumber(x+900, int(floorHeight-200), 200, 25, true) );
  } else {
    powerups.add( new  TeleportPowerup(x+800, int(floorHeight-500), 100, 400) );
    entities.add(new IronBox(x+900, int(floorHeight-600) ) );
    entities.add(new Lumber(x+900, int(floorHeight-400), 200, 25, true) );
  }
  entities.add(new Lumber(x+1100, int(floorHeight-25), 500, 25, true) );

  for (int i=0; i<obstacleCourseDist; i+=200) {
    if (i<obstacleCourseDist-600)entities.add(new Water(x+i, int(floorHeight), 200, 200 ) );
    else entities.add(new Grass(x+i, int(floorHeight), 200, 200 ) );
  }
}

void spawnMetalWall(int x) {
  obstacleCourseDist=2200;
  int index= int(random(3));

  entities.add(new Box(x+0, int(floorHeight-200) ) );
  entities.add(new Box(x+0, int(floorHeight-400) ) );
  entities.add(new Box(x+0, int(floorHeight-600) ) );
  entities.add(new Box(x+0, int(floorHeight-800) ) );

  if (index==0)  powerups.add(new TeleportPowerup(x+400, 600, 600));
  entities.add(new IronBox(x+600, int(floorHeight-200) ) ); // 3
  entities.add(new IronBox(x+800, int(floorHeight-200) ) ); // 3
  entities.add(new Tire(x+1000, int(floorHeight-200) ) ); // 3

  if (index==1) powerups.add(new TeleportPowerup(x+400, 400, 600));
  entities.add(new IronBox(x+600, int(floorHeight-400) ) ); // 3
  entities.add(new IronBox(x+800, int(floorHeight-400) ) ); // 3
  entities.add(new Tire(x+1000, int(floorHeight-400) ) ); // 3
}

void spawnShell(int x) {
  obstacleCourseDist=2200;
  int index= int(random(3));

  entities.add(new IronBox(x-200, int(floorHeight-300) ) );
  entities.add(new IronBox(x+0, int(floorHeight-400) ) );
  entities.add(new IronBox(x+200, int(floorHeight-400) ) );
  entities.add(new Box(x+200, int(floorHeight-600) ) );

  if (index==0) powerups.add( new  TeleportPowerup(x+100, int(floorHeight-150), 100, 650) );
  if (index==1) powerups.add( new  RandomPowerup(x+100, int(floorHeight-150), 100) );

  entities.add(new IronBox(x+200, int(floorHeight-200) ) );
  entities.add(new IronBox(x+400, int(floorHeight-200) ) );
}
void spawnWater(int x) {
  obstacleCourseDist=2200;
  entities.add(new Box(x+400, int(floorHeight-100) ) );
  entities.add(new Box(x+600, int(floorHeight-100) ) );
  entities.add(new Box(x+800, int(floorHeight-100) ) );

  entities.add(new Box(x+600, int(floorHeight-300) ) );
  entities.add(new Box(x+600, int(floorHeight-500) ) );

  entities.add(new Box(x+1400, int(floorHeight-100) ) );
  entities.add(new Box(x+1600, int(floorHeight-100) ) );

  for (int i=0; i<obstacleCourseDist; i+=200) {
    entities.add(new Water(x+i, int(floorHeight), 200, 200 ) );
  }
}

void spawnUnderGround(int x) {
  obstacleCourseDist=2200;
  int index= int(random(3));
  entities.add(new Grass(x+0, int(floorHeight+0), 200, 200) );
  entities.add(new Grass(x+200, int(floorHeight+50), 200, 200) );
  entities.add(new Grass(x+400, int(floorHeight+100), 200, 200)  );
  entities.add(new Grass(x+600, int(floorHeight+150), 200, 200 ) );
  entities.add(new Grass(x+800, int(floorHeight+200), 200, 200 ) );
  entities.add(new Grass(x+1000, int(floorHeight+200), 200, 200 ) );

  entities.add(new Box(x+800, int(floorHeight-200)) );
  if (index==0)entities.add(new Box(x+1000, int(floorHeight-200), -1) );
  entities.add(new Box(x+1000, int(floorHeight-400)) );
  entities.add(new Box(x+1200, int(floorHeight-200)) );

  entities.add(new Grass(x+1200, int(floorHeight+200), 200, 200 ) );
  entities.add(new Grass(x+1400, int(floorHeight+150), 200, 200 ) );
  entities.add(new Grass(x+1600, int(floorHeight+100), 200, 200 ) );
  entities.add(new Grass(x+1800, int(floorHeight+50), 200, 200 ) );
  entities.add(new Grass(x+2000, int(floorHeight+0), 200, 200) );
}

void spawnHill(int x) {
  obstacleCourseDist=2200;
  int index= int(random(4));

  if (index==1) {
    entities.add(new Box(x+800, int(floorHeight-350) ));
    entities.add(new Box(x+1000, int(floorHeight-350) ));
    entities.add(new Box(x+1200, int(floorHeight-350) ));
  }
  entities.add(new Grass(x+0, int(floorHeight+0), 200, 200) );
  entities.add(new Grass(x+200, int(floorHeight-50), 200, 200) );
  entities.add(new Grass(x+400, int(floorHeight-100), 200, 200)  );
  entities.add(new Grass(x+600, int(floorHeight-150), 200, 200 ) );
  entities.add(new Grass(x+800, int(floorHeight-150), 200, 200 ) );
  entities.add(new Grass(x+1000, int(floorHeight-150), 200, 200 ) );

  if (index==0)entities.add(new Box(x+1000, int(floorHeight-350), -1) );

  entities.add(new Grass(x+1200, int(floorHeight-150), 200, 200 ) );
  entities.add(new Grass(x+1400, int(floorHeight-150), 200, 200 ) );
  entities.add(new Grass(x+1600, int(floorHeight-100), 200, 200 ) );
  entities.add(new Grass(x+1800, int(floorHeight-50), 200, 200 ) );
  entities.add(new Grass(x+2000, int(floorHeight-0), 200, 200) );
}


void spawnIronPath(int x) {
  obstacleCourseDist=2200;
  int index= int(random(4));
  powerups.add( new  TokenPowerup(x+100, int(floorHeight-100), 100) );
  entities.add(new IronBox(x+00, int(floorHeight-400) ));
  entities.add(new IronBox(x+00, int(floorHeight-600) ));

  //entities.add(new IronBox(x+200, int(floorHeight-200) ));
  entities.add(new IronBox(x+200, int(floorHeight-600) ));
  powerups.add( new  TokenPowerup(x+300, int(floorHeight-100), 100) );

  // entities.add(new IronBox(x+400, int(floorHeight-200) ));
  // entities.add(new IronBox(x+400, int(floorHeight-400) ));
  entities.add(new IronBox(x+400, int(floorHeight-600) ));
  powerups.add( new  TokenPowerup(x+500, int(floorHeight-100), 100) );
  powerups.add( new  TokenPowerup(x+500, int(floorHeight-300), 100) );

  entities.add(new IronBox(x+600, int(floorHeight-200) ));
  //entities.add(new IronBox(x+600, int(floorHeight-400) ));
  entities.add(new IronBox(x+600, int(floorHeight-600) ));
  powerups.add( new  TokenPowerup(x+700, int(floorHeight-300), 100) );

  //entities.add(new IronBox(x+800, int(floorHeight-200) ));
  //entities.add(new IronBox(x+800, int(floorHeight-400) ));
  entities.add(new IronBox(x+800, int(floorHeight-600) ));
  powerups.add( new  TokenPowerup(x+900, int(floorHeight-100), 100) );
  powerups.add( new  TokenPowerup(x+900, int(floorHeight-300), 100) );

  //entities.add(new IronBox(x+1000, int(floorHeight-200) ));
  entities.add(new IronBox(x+1000, int(floorHeight-600) ));
  powerups.add( new  TokenPowerup(x+1100, int(floorHeight-100), 100) );

  entities.add(new IronBox(x+1200, int(floorHeight-400) ));
  entities.add(new IronBox(x+1200, int(floorHeight-600) ));

  powerups.add( new  TokenPowerup(x+1300, int(floorHeight-100), 100) );

  entities.add(new Box(x+600, int(floorHeight-800), -1 ));
}
void spawnIslands(int x) {
  obstacleCourseDist=2200;
  entities.add(new Water(x+0, int(floorHeight), 200, 200 ) );
  entities.add(new Water(x+200, int(floorHeight), 200, 200 ) );
  entities.add(new Water(x+400, int(floorHeight), 200, 200 ) );
  entities.add(new Water(x+600, int(floorHeight), 200, 200 ) );
  entities.add(new Water(x+800, int(floorHeight), 200, 200));
  entities.add(new Grass(x+1000, int(floorHeight), 200, 200));
  entities.add(new Water(x+1200, int(floorHeight), 200, 200 ) );
  entities.add(new Water(x+1400, int(floorHeight), 200, 200 ) );
  entities.add(new Water(x+1600, int(floorHeight), 200, 200 ) );
  entities.add(new Box(x+2000, int(floorHeight-100) ) );
  entities.add(new Box(x+1800, int(floorHeight-100) ) );
  entities.add(new Water(x+1800, int(floorHeight), 200, 200 ) );
  entities.add(new Water(x+2000, int(floorHeight), 200, 200 ) );

  powerups.add( new  TokenPowerup(x+200, int(floorHeight-200), 100) );
  powerups.add( new  TokenPowerup(x+400, int(floorHeight-400), 100) );
  powerups.add( new  TokenPowerup(x+600, int(floorHeight-200), 100) );
  powerups.add( new  TokenPowerup(x+800, int(floorHeight-400), 100) );
  powerups.add( new  TokenPowerup(x+1000, int(floorHeight-150), 100) );
}



void spawnPool(int x) {
  obstacleCourseDist=2200;
  entities.add(new Water(x, int(floorHeight), 200, 200));

  powerups.add(  new  SlowPowerup(x+100, int(floorHeight-350), 100) );

  entities.add(new Water(x+200, int(floorHeight), 200, 200));
  entities.add(new Grass(x+400, int(floorHeight), 200, 200));
  entities.add(new Grass(x+600, int(floorHeight), 200, 200));
  entities.add(new IronBox(x+400, int(floorHeight-200)));
  entities.add(new IronBox(x+400, int(floorHeight-400)));

  entities.add(new IronBox(x+600, int(floorHeight-200)));
  entities.add(new IronBox(x+600, int(floorHeight-400)));
  entities.add(new IronBox(x+400, int(floorHeight-800)));
  entities.add(new IronBox(x+400, int(floorHeight-1000)));

  entities.add(new Water(x+800, int(floorHeight-400), 200, 200));

  entities.add(new Water(x+1000, int(floorHeight-400), 200, 200));

  //entities.add(new IronBox(x+1000, int(floorHeight-800)));

  //entities.add(new IronBox(x+1600, int(floorHeight-1000)));
  // entities.add(new IronBox(x+1600, int(floorHeight-800)));
  entities.add(new IronBox(x+1600, int(floorHeight-600)));
  entities.add(new IronBox(x+1600, int(floorHeight-400)));


  //entities.add(new Grass(x+1000, int(floorHeight), 200, 200));
  entities.add(new Grass(x+1200, int(floorHeight), 200, 200));
  entities.add(new Grass(x+1400, int(floorHeight), 200, 200));
  entities.add(new Grass(x+1600, int(floorHeight), 200, 200));
  entities.add(new Grass(x+1800, int(floorHeight), 200, 200));
  entities.add(new Grass(x+2000, int(floorHeight), 200, 200));
  //entities.add(new Grass(x+2200, int(floorHeight), 200, 200));
}
void spawnTokenParadise(int x) {
  obstacleCourseDist=2200;
  for (int i=0; i< 2200; i+=200) {
    for (int j= 0; j<4; j++) {

      powerups.add( new  TokenPowerup(x+i, int(floorHeight-j*100), 100) );
    }
  }
}
void spawnSnake(int x) {
  obstacleCourseDist=2200;
  entities.add(new Snake(x, int(floorHeight-50)));
  entities.add(new Snake(x+200, int(floorHeight-50)));
  entities.add(new Snake(x+400, int(floorHeight-50)));
  entities.add(new Snake(x+600, int(floorHeight-50)));
}
void spawnFlak(int x) { 
  obstacleCourseDist=2200;
  for (int i=600; i < 2200; i+=200) entities.add(new Box(x+i, int(floorHeight-200)));
  entities.add(new Lumber(x+250, int(floorHeight-500), 300, 25, true) );
}

void spawnBlock(int x) { 
  obstacleCourseDist=2200;
  entities.add(new Rock(x+00, int(floorHeight-200) ) );
  entities.add(new Block(x+400, int(floorHeight-500)) );
  entities.add(new Glass(x+1600, int(floorHeight-100), 200, 100) );
  entities.add(new IronBox(x+1600, int(floorHeight-300)) );
  entities.add(new IronBox(x+1600, int(floorHeight-400)) );
  entities.add(new IronBox(x+1600, int(floorHeight-600)) );
}

void spawnBarrel(int x) {
  obstacleCourseDist=2200;
  entities.add(new Barrel(x+900, int(floorHeight-200)));
  entities.add(new Rock(x+1200, int(floorHeight-200) ) );
}

