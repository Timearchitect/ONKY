int difficulty, difficultyRange=10;
float minDifficulty=0, maxDifficulty=difficultyRange;

void loadObstacle() {
  for (int i=1; i<90; i++) {
    minDifficulty+=0.3;
    maxDifficulty+=0.3;
    difficulty=int(random(maxDifficulty-minDifficulty)+minDifficulty-8);
    switch(difficulty) {
    case 0:
      spawnSingleWall(i*2200);
      break;
    case 1:
      spawnTires(i*2200);
      break;
    case 2:
      spawnDuck(i*2200);
      break;
    case 3:
      spawnFloatingBlock(i*2200);
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
      spawnBlock(i*2200);
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
    case 12:
      spawnBoxPlatform(i*2200);
      break;
    case 13:
      spawnBarrier(i*2200);
      break;
    case 14:
      spawnBiuldingFrame(i*2200);
      break;
    case 15:
      spawnTowerFrame(i*2200);
      break;
    case 16:
      spawnBlocks(i*2200);
      break;
    case 17:
      spawnTunnel(i*2200);
      break;  
    case 18:
      spawnBush(i*2200);
      break;
    case 19:
      spawnLaserArena(i*2200);
      break;
    case 20:
      spawnBoxBlock(i*2200);
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
    entities.add(new Box(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    //   entities.add(new Box(x+200, int(floorHeight-600) ) ); // 3
    //  entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    //  entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 2:
    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new Box(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    //  entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    //   entities.add(new Box(x+200, int(floorHeight-400) ) ); // 2
    //   entities.add(new IronBox(x+200, int(floorHeight-200) ) ); // 1
    break;
  case 1:
    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    entities.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    //    entities.add(new IronBox(x+200, int(floorHeight-600) ) ); // 3
    //   entities.add(new IronBox(x+200, int(floorHeight-400) ) ); // 2
    //   entities.add(new Box(x+200, int(floorHeight-200) ) ); // 1
    break;
  }
  int index= int(random(5));
  if (index==0) entities.add( new  Powerup(x+600, int(floorHeight-500), 200) );
}
void spawnTunnel(int x) {
  int index= int(random(3));
  if (index==0) entities.add( new  Powerup(x+1000, int(floorHeight-550), 200) );

  entities.add(new IronBox(x, int(floorHeight-200) ) ); 
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
  int index= int(random(2));
  if (index==0) entities.add(new IronBox(x, int(floorHeight-660) ) );
  else  entities.add(new Box(x, int(floorHeight-660) ) );
  entities.add(new IronBox(x, int(floorHeight-860) ) ); 
  entities.add(new IronBox(x, int(floorHeight-460) ) );
  entities.add(new IronBox(x, int(floorHeight-260) ) );
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

  for (int i=0; i<6; i++) {
    entities.add(new Box(x+i*255, int(floorHeight-400) ) );
  }
  entities.add(new PlatForm(x, int(floorHeight-200), 1500, 50, true) );
}

void spawnBarrier(int x) {
  int index= int(random(5));
  if (index==0) entities.add( new  Powerup(x+1600, int(floorHeight-650), 200) );
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
  if (index==3) entities.add( new  Powerup(x+450, int(floorHeight-550), 200) );

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
void spawnBoxBlock(int x) {
  int index= int(random(3));
  entities.add( new  LaserPowerup(x-400, int(floorHeight-200), 300) );

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
  if (index==1) entities.add( new  Powerup(x+250, int(floorHeight-350), 200) );
  if (index==2) entities.add( new  LaserPowerup(x+250, int(floorHeight-350), 200) );
}
void spawnLaserArena(int x) {
  entities.add( new  LaserPowerup(x-400, int(floorHeight-500), 200) );
  entities.add( new  LaserPowerup(x-400, int(floorHeight-300), 200) );
  entities.add( new  LaserPowerup(x-400, int(floorHeight-100), 200) );

  for (int i=0; i<6; i++) {
    entities.add(new Box(x+i*200+200, int(floorHeight-200) ) );
    entities.add(new Box(x+i*200+200, int(floorHeight-400) ) );
    entities.add(new Box(x+i*200+200, int(floorHeight-600) ) );
  }
}

void spawnBush(int x) {
  int noBushes = int(random(6));
  for (int i=0; i<noBushes; i++) {
    entities.add(new Bush(x-0+i*100, int(floorHeight-100) ) );
  }
  if (noBushes==4) entities.add( new  Powerup(x+300, int(floorHeight-150), 200) );
}

