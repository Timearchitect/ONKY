int  difficulty, difficultyRange=10, interval=2200;
float minDifficulty=0, maxDifficulty=difficultyRange;

void generateObstacle(){





}

void loadObstacle() {

  entities.add(new Box(1500, int(floorHeight-200), 1) );
  spawnFloor(-interval);   // behind floor
  spawnFloor(0);  // first floor


  for (int i=1; i<110; i++) {
    minDifficulty+=0.3;
    maxDifficulty+=0.3;
    difficulty=int(random(maxDifficulty-minDifficulty)+minDifficulty-difficultyRange);

    switch(difficulty) {
    case -4:
      spawnHill(i*interval); 
      break;
    case -3:
      spawnUnderGround(i*interval); 
      break;
    case -2:
      spawnFloor(i*interval);
      spawnBush(i*interval);
      break;
    case -1:
      spawnFloor(i*interval);
      spawnSingleWall(i*interval);
      break;
    case 0:
      spawnFloor(i*interval);
      spawnTires(i*interval);
      break;
    case 1:
      spawnWater(i*interval);
      break;
    case 2:
      spawnFloor(i*interval);
      spawnDuck(i*interval);
      break;
    case 3:
      spawnFloor(i*interval);
      spawnFloatingBlock(i*interval);
      break;
    case 4:
      spawnFloor(i*interval);
      spawnDoubleWall(i*interval);
      break;
    case 5:
      spawnFloor(i*interval);
      spawnTirePool(i*interval);
      break;
    case 6:
      spawnFloor(i*interval);
      spawnMetalWall(i*interval);
      break;
    case 7:
      spawnFloor(i*interval);
      spawnHeap(i*interval);
      break;
    case 8:
      spawnFloor(i*interval);
      spawnTiltedBoxes(i*interval);
      break;
    case 9:
      spawnFloor(i*interval);
      spawnTireTower(i*interval);
      break;
    case 10:
      spawnFloor(i*interval);
      spawnBoxDuck(i*interval);
      break;
    case 11:
      spawnFloor(i*interval);
      spawnPlatform(i*interval);
      break;
    case 12:
      spawnFloor(i*interval);
      spawnBoxPlatform(i*interval);
      break;
    case 13:
      spawnFloor(i*interval);
      spawnBarrier(i*interval);
      break;
    case 14:
      spawnFloor(i*interval);
      spawnBiuldingFrame(i*interval);
      break;
    case 15:
      spawnFloor(i*interval);
      spawnSteps(i*interval);
      break;
    case 16:
      spawnFloor(i*interval);
      spawnBlocks(i*interval);
      break;
    case 17:
      spawnFloor(i*interval);
      spawnTunnel(i*interval);
      break;  
    case 18:
      spawnFloor(i*interval);
      spawnTowerFrame(i*interval);
      break;
    case 19:
      spawnFloor(i*interval);
      spawnLaserArena(i*interval);
      break;
    case 20:
      spawnFloor(i*interval);
      spawnDounut(i*interval);
      break;
    case 21:
      spawnFloor(i*interval);
      spawnTimeGate(i*interval);
      break;
    case 22:
      spawnSlashArena(i*interval);
      break;
    case 23:
      spawnFloor(i*interval);
      spawnShell(i*interval);
      break;
    default:
      //spawnWater(i*interval);
      //  spawnUnderGround(i*interval); 
      spawnFloor(i*interval);
      spawnSingleWall(i*interval);
      spawnBush(i*interval);
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
  entities.add(new IronBox(x-200, int(floorHeight-200) ) ); 
  entities.add(new Tire(x, int(floorHeight-200) ) ); 
  entities.add(new Tire(x+200, int(floorHeight-200) ) );
  if (index==0) entities.add(new Tire(x+400, int(floorHeight-200) ) );
  entities.add(new Tire(x+600, int(floorHeight-200) ) );
  entities.add(new Tire(x+800, int(floorHeight-200) ) );

  entities.add(new Tire(x, int(floorHeight-400) ) ); 
  entities.add(new Tire(x+200, int(floorHeight-400) ) );
  if (index==0) entities.add(new Tire(x+400, int(floorHeight-400) ) );
  entities.add(new Tire(x+600, int(floorHeight-400) ) );
  entities.add(new Tire(x+800, int(floorHeight-400) ) );

  entities.add(new IronBox(x+1000, int(floorHeight-200) ) );

  if (index==1) entities.add( new  Powerup(x+500, int(floorHeight-350), 200) );
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
  int index= int(random(3));
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

