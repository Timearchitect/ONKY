int  powerupGUIinterval=135, GUIoffsetX=50, GUIoffsetY=160 ,iconSize=110;
final int MAX_POWERUP_DISPLAYING=4;
void loadGUILayer() {
  GUI=createGraphics(width, height);
  GUI.beginDraw();
  GUI.noSmooth();
  GUI.endDraw();
  UpdateGUILife();

  powerupGUI=createGraphics(width, height);
  powerupGUI.beginDraw();
  powerupGUI.noSmooth();
  powerupGUI.fill(0);
  powerupGUI.textAlign(CENTER);
  powerupGUI.textFont(font, int(36*screenFactor));
  powerupGUI.endDraw();
  UpdatePowerupGUILife() ;

  gameOverGUI=createGraphics(width, height);
  gameOverGUI.beginDraw();
  gameOverGUI.noSmooth();
  gameOverGUI.fill(0);
  gameOverGUI.textAlign(CENTER);
  gameOverGUI.textFont(font, int(36*screenFactor));
  gameOverGUI.endDraw();
}

void UpdateGameOverGUI() {
  gameOverGUI.beginDraw();
  gameOverGUI.loadPixels();
  for (int i = gameOverGUI.pixels.length; i != 0; gameOverGUI.pixels[--i] = 0);
  gameOverGUI.updatePixels();

  gameOverGUI.fill(255);
  gameOverGUI.rect(100*screenFactor, 100*screenFactor, width-200*screenFactor, height-200*screenFactor);
  gameOverGUI.fill(0);
  gameOverGUI.text( ""+obstacleDestroyed +" boxes   "+tokensTaken +" tokens   "+int(score*0.002)  +" meter", width*0.5, height*0.5);  
  gameOverGUI.text( "Your Score: "+int(score*0.002) + "   Totaltoken: "+ tokensTaken, width*0.5, height*0.65);  
  gameOverGUI.text( "time: "+gameOverCooldown, width*0.5, height*0.7);  

  gameOverGUI.fill(255, 0, 0); 
  gameOverGUI.endDraw();
}

void UpdateGUILife() {
  // GUI=createGraphics(0,0);
  if (!tutorial) {
    GUI.beginDraw();
    GUI.loadPixels();
    for (int i = GUI.pixels.length; i != 0; GUI.pixels[--i] = 0);
    GUI.updatePixels();
    GUI.endDraw();


    GUI.clear();
    GUI.beginDraw();
    for (int i=0; i<p.lives; i++) GUI.image(p.Life, int((50+i*50)*screenFactor), int(60*screenFactor), 40*screenFactor, 40*screenFactor);
    GUI.endDraw();
  }
}

void UpdatePowerupGUILife() {
  // powerupGUI=createGraphics(0,0);

  powerupGUI.beginDraw();
  powerupGUI.loadPixels();
  for (int i = powerupGUI.pixels.length; i != 0; powerupGUI.pixels[--i] = 0);
  powerupGUI.updatePixels();
  powerupGUI.endDraw();

  powerupGUI.clear();

  powerupGUI.beginDraw();

  int index, amount=0;
  Powerup pow=null;
  amount= (MAX_POWERUP_DISPLAYING<p.usedPowerup.size()) ? MAX_POWERUP_DISPLAYING:p.usedPowerup.size();

  powerupGUI.clear();
  powerupGUI.beginDraw();

  //for (Powerup pow : p.usedPowerup) {
  for (int i=0; i<amount; i++) {
    pow =p.usedPowerup.get(i);
    index=p.usedPowerup.indexOf(pow);
    powerupGUI.image(pow.icon, width-(GUIoffsetX+iconSize+index*powerupGUIinterval)*screenFactor, height-GUIoffsetY*screenFactor, iconSize*screenFactor, iconSize*screenFactor);
    if (pow.upgradeLevel!=0)
      powerupGUI.text(pow.upgradeLevel+" LVL", width-(GUIoffsetX+pow.w*0.5+index*powerupGUIinterval)*screenFactor, GUIoffsetY+pow.h*0.5-80);
  }
  powerupGUI.endDraw();
}

void clearAllGUI() {
  powerupGUI.beginDraw();
  powerupGUI.loadPixels();
  for (int i = powerupGUI.pixels.length; i != 0; powerupGUI.pixels[--i] = 0);
  powerupGUI.updatePixels();
  powerupGUI.endDraw();
  GUI.beginDraw();
  GUI.loadPixels();
  for (int i = GUI.pixels.length; i != 0; GUI.pixels[--i] = 0);
  GUI.updatePixels();
  GUI.endDraw();
}

