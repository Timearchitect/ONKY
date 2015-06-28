int  difficulty, difficultyRange=1, interval=2200, totalAmountOfCourses=28;
float minDifficulty=0, maxDifficulty=difficultyRange, difficultScale=1;
int amountOfCourses=110, distGenerated, loadObstacleDist=2200, loadMargin=2000;
boolean firstCourse=true;

void generateObstacle() {
  if (p.x+p.w+loadMargin > distGenerated ) {
    loadRandomObstacleCourse(distGenerated);
    distGenerated+=loadObstacleDist;
  }
}

void loadObstacle() {

  entities.add(new Box(1500, int(floorHeight-200), 1) ); // ? box
  spawnFloor(-interval);   // behind floor
  spawnFloor(0);  // first floor

  for (int i=1; i<amountOfCourses; i++) {
    loadRandomObstacleCourse(i*interval);
  }
}
void loadRandomObstacleCourse(int x) {
  if (firstCourse) {  // first is always grass
    spawnFloor(x);
    firstCourse=false;
  } else {
    if (totalAmountOfCourses+difficultyRange<minDifficulty) { // check if loop
      minDifficulty=0;
      maxDifficulty=difficultyRange; // resets
    }
    minDifficulty+=difficultScale;
    maxDifficulty+=difficultScale;
    difficulty=int(random(maxDifficulty-minDifficulty)+minDifficulty-difficultyRange);
    
    if(difficulty<0)difficulty=0;  
    
    switch(difficulty) {
    case 0:
      spawnFloor(x);
      spawnSingleWall(x);
      spawnBush(x);
      break;
    case 1:
      spawnHill(x); 
      break;
    case 2:
      spawnUnderGround(x); 
      break;
    case 3:
      spawnFloor(x);
      spawnBush(x);
      break;
    case 4:
      spawnFloor(x);
      spawnSingleWall(x);
      break;
    case 5:
      spawnFloor(x);
      spawnTires(x);
      break;
    case 6:
      spawnWater(x);
      break;
    case 7:
      spawnFloor(x);
      spawnDuck(x);
      break;
    case 8:
      spawnFloor(x);
      spawnFloatingBlock(x);
      break;
    case 9:
      spawnFloor(x);
      spawnDoubleWall(x);
      break;
    case 10:
      spawnFloor(x);
      spawnTirePool(x);
      break;
    case 11:
      spawnFloor(x);
      spawnMetalWall(x);
      break;
    case 12:
      spawnFloor(x);
      spawnHeap(x);
      break;
    case 13:
      spawnFloor(x);
      spawnTiltedBoxes(x);
      break;
    case 14:
      spawnFloor(x);
      spawnTireTower(x);
      break;
    case 15:
      spawnFloor(x);
      spawnBoxDuck(x);
      break;
    case 16:
      spawnFloor(x);
      spawnPlatform(x);
      break;
    case 17:
      spawnFloor(x);
      spawnBoxPlatform(x);
      break;
    case 18:
      spawnFloor(x);
      spawnBarrier(x);
      break;
    case 19:
      spawnFloor(x);
      spawnBiuldingFrame(x);
      break;
    case 20:
      spawnFloor(x);
      spawnSteps(x);
      break;
    case 21:
      spawnFloor(x);
      spawnBlocks(x);
      break;
    case 22:
      spawnFloor(x);
      spawnTunnel(x);
      break;  
    case 23:
      spawnFloor(x);
      spawnTowerFrame(x);
      break;
    case 24:
      spawnFloor(x);
      spawnLaserArena(x);
      break;
    case 25:
      spawnFloor(x);
      spawnDounut(x);
      break;
    case 26:
      spawnFloor(x);
      spawnTimeGate(x);
      break;
    case 27:
      spawnSlashArena(x);
      break;
    case 28:
      spawnFloor(x);
      spawnShell(x);
      break;
    default:
      //spawnWater(x);
      //spawnUnderGround(x); 
      spawnFloor(x);
      spawnSingleWall(x);
      spawnBush(x);
    }
  }
}
void spawnFloor(int x) {
  for (int i=0; i<interval; i+=200) {
    entities.add(new Grass(x+i, int(floorHeight), 200, 200 ) );
  }
}
void spawnDoubleWall(int x) {
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
  }
  int index= int(random(7));
  if (index==0) entities.add( new  Powerup(x+600, int(floorHeight-500), 200) );
  if (index==2) entities.add( new  RandomPowerup(x+600, int(floorHeight-300), 1000) );
}
void spawnTunnel(int x) {
  int index= int(random(4));
  if (index==0) entities.add( new  Powerup(x+1000, int(floorHeight-550), 200) );
  if (index==2) entities.add( new  RandomPowerup(x+1500, int(floorHeight-550), 1000) );
  if (index==1) entities.add(new Box(x, int(floorHeight-200) ) ); 

  else entities.add(new IronBox(x, int(floorHeight-200) ) ); 
  entities.add(new IronBox(x+200, int(floorHeight-300) ) ); 
  entities.add(new IronBox(x+400, int(floorHeight-300) ) ); 
  entities.add(new IronBox(x+600, int(floorHeight-300) ) );

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

  if (index==1) entities.add( new  Powerup(x+700, int(floorHeight-350), 200) );
}
void spawnTireTower(int x) {
  entities.add(new Tire(x, int(floorHeight-200) ) ); 
  entities.add(new Tire(x, int(floorHeight-400) ) ); 
  entities.add(new Tire(x, int(floorHeight-600) ) ); 
  entities.add(new Tire(x, int(floorHeight-800) ) );
}

void spawnDuck(int x) {
  int index= int(random(3));
  if (index==0) entities.add(new IronBox(x+400, int(floorHeight-660) ) );
  else  entities.add(new Box(x+400, int(floorHeight-660) ) );
  if (index==1) entities.add( new  TeleportPowerup(x+250, int(floorHeight-350), 200, 500) );
  entities.add(new IronBox(x+400, int(floorHeight-860) ) ); 
  entities.add(new IronBox(x+400, int(floorHeight-460) ) );
  entities.add(new IronBox(x+400, int(floorHeight-260) ) );
}
void spawnBoxDuck(int x) {
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
  entities.add(new PlatForm(x+250, int(floorHeight-200), 300, 25, true) );

  // entities.add(new Box(x+400, int(floorHeight-200) ) );
}
void spawnSteps(int x) {
  int index= int(random(4));
  if (index==1) entities.add( new  TeleportPowerup(x+300, int(floorHeight-300), 200, 1000) );
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
  entities.add(new IronBox(x+1400, int(floorHeight-200) ) );
  if (index==0) entities.add( new  Powerup(x+1700, int(floorHeight-150), 200) );
}
void spawnHeap(int x) {
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

void spawnPlatform(int x) {
  int index= int(random(3));
  if (index==0) entities.add( new  Powerup(x+1000, int(floorHeight-600), 200) );
  entities.add(new PlatForm(x, int(floorHeight-100), 500, 50, true) );
  entities.add(new Box(x+1150, int(floorHeight-480) ) );
  entities.add(new PlatForm(x+400, int(floorHeight-300), 1000, 50, true) );
  entities.add(new Tire(x+1400, int(floorHeight-700) ) );
  entities.add(new PlatForm(x+800, int(floorHeight-500), 900, 50, true) );
}

void spawnBoxPlatform(int x) {
  int index= int(random(5));
  if (index==0) entities.add( new  Powerup(x+700, int(floorHeight-100), 200) );
  if (index==1) entities.add( new  Powerup(x+700, int(floorHeight-600), 200) );
  if (index==2) entities.add( new  RandomPowerup(x+700, int(floorHeight-600), 1000) );

  for (int i=0; i<6; i++) {
    entities.add(new Box(x+i*255, int(floorHeight-400) ) );
  }
  entities.add(new PlatForm(x, int(floorHeight-200), 1500, 50, true) );
}

void spawnBarrier(int x) {
  int index= int(random(5));
  if (index==0) entities.add( new  Powerup(x+1600, int(floorHeight-650), 200) );
  if (index==1) entities.add( new  RandomPowerup(x+1600, int(floorHeight-650), 200) );

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
  int index= int(random(5));
  if (index==0) entities.add( new  Powerup(x+450, int(floorHeight-65), 200) );
  if (index==1) entities.add( new  Powerup(x+450, int(floorHeight-300), 200) );
  if (index==2) entities.add( new  Powerup(x+450, int(floorHeight-550), 200) );
  if (index==3) entities.add( new  RandomPowerup(x+450, int(floorHeight-550), 1000) );

  entities.add(new Glass(x, int(floorHeight-150), 50, 150));
  entities.add(new PlatForm(x, int(floorHeight-200), 900, 50 ) );
  entities.add(new Glass(x+850, int(floorHeight-150), 50, 150));

  entities.add(new Glass(x, int(floorHeight-400), 50, 200));
  entities.add(new PlatForm(x, int(floorHeight-450), 900, 50 ) );
  entities.add(new Glass(x+850, int(floorHeight-400), 50, 200));

  entities.add(new Glass(x, int(floorHeight-650), 50, 200));
  entities.add(new PlatForm(x, int(floorHeight-700), 900, 50 ) );
  entities.add(new Glass(x+850, int(floorHeight-650), 50, 200));
}
void spawnTowerFrame(int x) {
  int index= int(random(2));

  entities.add(new Glass(x, int(floorHeight-400), 50, 400));
  entities.add(new PlatForm(x, int(floorHeight-1000), 50, 600 ) );
  for (int j=0; j<6; j++) {
    for (int i=0; i<4; i++) {
      entities.add(new Glass(x+50+j*200, int(floorHeight-i*150-200), 200, 50));
    }
  }
  if (index==0) {
    entities.add(new PlatForm(x+1250, int(floorHeight-600), 50, 400 ) );
    entities.add(new Glass(x+1250, int(floorHeight-1000), 50, 400));
  } else {
    entities.add(new PlatForm(x+1250, int(floorHeight-350), 50, 350 ) );
    entities.add(new Glass(x+1250, int(floorHeight-550), 50, 200));
    entities.add(new PlatForm(x+1250, int(floorHeight-950), 50, 400 ) );
  }
}
void spawnBlocks(int x) {
  int index= int(random(2));
  // entities.add(new IronBox(x, int(floorHeight-600) ) );
  // entities.add(new IronBox(x, int(floorHeight-400) ) );
  entities.add(new Block(x-100, int(floorHeight-200) ) );
  //  entities.add(new Block(x+200, int(floorHeight-200) ) );
  // entities.add(new Block(x+400, int(floorHeight-200) ) );

  if (index==0) entities.add( new  Powerup(x+1200, int(floorHeight-750), 200) );
  if (index==1) entities.add( new  Powerup(x+300, int(floorHeight-150), 200) );
}
void spawnDounut(int x) {
  int index= int(random(3));
  entities.add( new  LaserPowerup(x-150, int(floorHeight-300), 300) );

  entities.add(new Box(x-0, int(floorHeight-200) ) );
  entities.add(new Box(x-0, int(floorHeight-400) ) );
  entities.add(new Box(x-0, int(floorHeight-600) ) );
  entities.add(new Box(x-200, int(floorHeight-200) ) );
  // entities.add(new Box(x-200, int(floorHeight-400) ) );
  entities.add(new Box(x-200, int(floorHeight-600) ) );
  entities.add(new Box(x-400, int(floorHeight-200) ) );
  entities.add(new Box(x-400, int(floorHeight-400) ) );
  entities.add(new Box(x-400, int(floorHeight-600) ) );
  if (index==0) entities.add( new  Powerup(x+1200, int(floorHeight-800), 200) );
  if (index==1) entities.add( new  Powerup(x+400, int(floorHeight-350), 200) );
  if (index==2) entities.add( new  LaserPowerup(x+400, int(floorHeight-350), 200) );


  entities.add(new Box(x+400, int(floorHeight-600) ) );
  entities.add(new Box(x+400, int(floorHeight-200) ) );
}
void spawnLaserArena(int x) {
  entities.add( new  LaserPowerup(x-400, int(floorHeight-700), 200) );
  entities.add( new  LaserPowerup(x-400, int(floorHeight-500), 200) );
  entities.add( new  LaserPowerup(x-400, int(floorHeight-300), 200) );
  entities.add( new  LaserPowerup(x-400, int(floorHeight-100), 200) );

  for (int i=0; i<5; i++) {
    entities.add(new Box(x+i*250+200, int(floorHeight-200) ) );
    entities.add(new Box(x+i*250+200, int(floorHeight-400) ) );
    entities.add(new Box(x+i*250+200, int(floorHeight-600) ) );
  }
}

void spawnBush(int x) {
  int noBushes = int(random(6));
  for (int i=0; i<noBushes; i++) {
    entities.add(new Bush(x-0+i*100, int(floorHeight-100) ) );
  }
  if (noBushes==4) entities.add( new  Powerup(x+300, int(floorHeight-100), 200) );
}

void spawnTimeGate(int x) {
  entities.add( new  SlowPowerup(x-400, int(floorHeight-700), 500) );
  entities.add( new  SlowPowerup(x-400, int(floorHeight-500), 500) );
  entities.add( new  SlowPowerup(x-400, int(floorHeight-300), 500) );
  entities.add( new  SlowPowerup(x-400, int(floorHeight-100), 500) );

  for (int i=0; i<12; i++) {
    int j = int(random(3));
    entities.add(new Box(x+i*100+100, int(floorHeight-j*200)-200 ) );
  }
}

void spawnSlashArena(int x) {
  int index= int(random(3));
  if (index==0) {
    entities.add( new  TeleportPowerup(x+0, int(floorHeight-100), 100, 400) );
    entities.add(new IronBox(x+100, int(floorHeight-200) ) );
    entities.add(new PlatForm(x+100, int(floorHeight-0), 200, 25, true) );
  } else if (index==1) {
    entities.add( new  TeleportPowerup(x+0, int(floorHeight-300), 100, 400) );
    entities.add(new IronBox(x+100, int(floorHeight-400) ) );
    entities.add(new PlatForm(x+100, int(floorHeight-200), 200, 25, true) );
  } else {
    entities.add( new  TeleportPowerup(x+0, int(floorHeight-500), 100, 400) );
    entities.add(new IronBox(x+100, int(floorHeight-600) ) );
    entities.add(new PlatForm(x+100, int(floorHeight-400), 200, 25, true) );
  }

  index= int(random(3));
  if (index==0) {
    entities.add( new  TeleportPowerup(x+400, int(floorHeight-100), 100, 400) );
    entities.add(new IronBox(x+500, int(floorHeight-200) ) );
    entities.add(new PlatForm(x+500, int(floorHeight-0), 200, 25, true) );
  } else if (index==1) {
    entities.add( new  TeleportPowerup(x+400, int(floorHeight-300), 100, 400) );
    entities.add(new IronBox(x+500, int(floorHeight-400) ) );
    entities.add(new PlatForm(x+500, int(floorHeight-200), 200, 25, true) );
  } else {
    entities.add( new  TeleportPowerup(x+400, int(floorHeight-500), 100, 400) );
    entities.add(new IronBox(x+500, int(floorHeight-600) ) );
    entities.add(new PlatForm(x+500, int(floorHeight-400), 200, 25, true) );
  }
  index= int(random(3));
  if (index==0) {
    entities.add( new  TeleportPowerup(x+800, int(floorHeight-100), 100, 400) );
    entities.add(new IronBox(x+900, int(floorHeight-200) ) );
    entities.add(new PlatForm(x+900, int(floorHeight-0), 200, 25, true) );
  } else if (index==1) {
    entities.add( new  TeleportPowerup(x+800, int(floorHeight-300), 100, 400) );
    entities.add(new IronBox(x+900, int(floorHeight-400) ) );
    entities.add(new PlatForm(x+900, int(floorHeight-200), 200, 25, true) );
  } else {
    entities.add( new  TeleportPowerup(x+800, int(floorHeight-500), 100, 400) );
    entities.add(new IronBox(x+900, int(floorHeight-600) ) );
    entities.add(new PlatForm(x+900, int(floorHeight-400), 200, 25, true) );
  }
  entities.add(new PlatForm(x+1100, int(floorHeight-25), 500, 25, true) );

  for (int i=0; i<interval; i+=200) {
    if (i<interval-600)entities.add(new Water(x+i, int(floorHeight), 200, 200 ) );
    else entities.add(new Grass(x+i, int(floorHeight), 200, 200 ) );
  }
}

void spawnMetalWall(int x) {
  int index= int(random(3));

  entities.add(new Box(x+0, int(floorHeight-200) ) );
  entities.add(new Box(x+0, int(floorHeight-400) ) );
  entities.add(new Box(x+0, int(floorHeight-600) ) );
  entities.add(new Box(x+0, int(floorHeight-800) ) );

  if (index==0)  entities.add(new TeleportPowerup(x+400, 600, 600));
  entities.add(new IronBox(x+600, int(floorHeight-200) ) ); // 3
  entities.add(new IronBox(x+800, int(floorHeight-200) ) ); // 3
  entities.add(new Tire(x+1000, int(floorHeight-200) ) ); // 3

  if (index==1) entities.add(new TeleportPowerup(x+400, 400, 600));
  entities.add(new IronBox(x+600, int(floorHeight-400) ) ); // 3
  entities.add(new IronBox(x+800, int(floorHeight-400) ) ); // 3
  entities.add(new Tire(x+1000, int(floorHeight-400) ) ); // 3
}

void spawnShell(int x) {
  int index= int(random(3));

  entities.add(new IronBox(x-200, int(floorHeight-300) ) );
  entities.add(new IronBox(x+0, int(floorHeight-400) ) );
  entities.add(new IronBox(x+200, int(floorHeight-400) ) );
  entities.add(new Box(x+200, int(floorHeight-600) ) );

  if (index==0) entities.add( new  TeleportPowerup(x+100, int(floorHeight-150), 100, 650) );
  if (index==1) entities.add( new  RandomPowerup(x+100, int(floorHeight-150), 100) );

  entities.add(new IronBox(x+200, int(floorHeight-200) ) );
  entities.add(new IronBox(x+400, int(floorHeight-200) ) );
}
void spawnWater(int x) {
  entities.add(new Box(x+400, int(floorHeight-100) ) );
  entities.add(new Box(x+600, int(floorHeight-100) ) );
  entities.add(new Box(x+800, int(floorHeight-100) ) );

  entities.add(new Box(x+600, int(floorHeight-300) ) );
  entities.add(new Box(x+600, int(floorHeight-500) ) );

  entities.add(new Box(x+1400, int(floorHeight-100) ) );
  entities.add(new Box(x+1600, int(floorHeight-100) ) );

  for (int i=0; i<interval; i+=200) {
    entities.add(new Water(x+i, int(floorHeight), 200, 200 ) );
  }
}

void spawnUnderGround(int x) {
  int index= int(random(3));
  entities.add(new Grass(x+0, int(floorHeight+0), 200, 200) );
  entities.add(new Grass(x+200, int(floorHeight+50), 200, 200) );
  entities.add(new Grass(x+400, int(floorHeight+100), 200, 200)  );
  entities.add(new Grass(x+600, int(floorHeight+150), 200, 200 ) );
  entities.add(new Grass(x+800, int(floorHeight+200), 200, 200 ) );
  entities.add(new Grass(x+1000, int(floorHeight+200), 200, 200 ) );

  entities.add(new Box(x+800, int(floorHeight-200)) );
  if (index==0)entities.add(new Box(x+1000, int(floorHeight-200), 1) );
  entities.add(new Box(x+1000, int(floorHeight-400)) );
  entities.add(new Box(x+1200, int(floorHeight-200)) );

  entities.add(new Grass(x+1200, int(floorHeight+200), 200, 200 ) );
  entities.add(new Grass(x+1400, int(floorHeight+150), 200, 200 ) );
  entities.add(new Grass(x+1600, int(floorHeight+100), 200, 200 ) );
  entities.add(new Grass(x+1800, int(floorHeight+50), 200, 200 ) );
  entities.add(new Grass(x+2000, int(floorHeight+0), 200, 200) );
}

void spawnHill(int x) {
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

  if (index==0)entities.add(new Box(x+1000, int(floorHeight-350), 1) );

  entities.add(new Grass(x+1200, int(floorHeight-150), 200, 200 ) );
  entities.add(new Grass(x+1400, int(floorHeight-150), 200, 200 ) );
  entities.add(new Grass(x+1600, int(floorHeight-100), 200, 200 ) );
  entities.add(new Grass(x+1800, int(floorHeight-50), 200, 200 ) );
  entities.add(new Grass(x+2000, int(floorHeight-0), 200, 200) );
}

