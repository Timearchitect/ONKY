int  powerupGUIinterval=int(110), GUIoffsetX=50;
void loadGUILayer() {
  GUI=createGraphics(width, height);
  GUI.beginDraw();
  GUI.endDraw();
  GUI.noSmooth();
  UpdateGUILife();

  powerupGUI=createGraphics(width, height);
  powerupGUI.beginDraw();
  powerupGUI.endDraw();
  powerupGUI.noSmooth();
  powerupGUI.fill(0);
  powerupGUI.textAlign(CENTER);
  powerupGUI.textFont(font, int(36*screenFactor));
  UpdatePowerupGUILife() ;
}

void UpdateGUILife() {
  // GUI=createGraphics(0,0);
  GUI.clear();
  GUI.flush();
  GUI.beginDraw();
  GUI.clear();
  GUI.flush();
  for (int i=0; i<p.lives; i++) GUI.image(p.Life, int((50+i*50)*screenFactor), int(60*screenFactor), 40*screenFactor, 40*screenFactor);
  GUI.endDraw();
}
void UpdatePowerupGUILife() {
  // powerupGUI=createGraphics(0,0);
  powerupGUI.clear();
  powerupGUI.flush();
  powerupGUI.beginDraw();
  powerupGUI.clear();
    powerupGUI.flush();

  int index, GUIoffsetY=height-150;      
  for (Powerup pow : p.usedPowerup) {
    index=p.usedPowerup.indexOf(pow);
    powerupGUI.image(pow.icon, width-(GUIoffsetX+10+index*powerupGUIinterval)*screenFactor-80*screenFactor, GUIoffsetY+10, (100-20)*screenFactor, (100-20)*screenFactor);
    powerupGUI.text(pow.upgradeLevel, width-(GUIoffsetX+pow.w*0.5+index*powerupGUIinterval)*screenFactor, GUIoffsetY+pow.h*0.5-80);
  }
  powerupGUI.endDraw();
  powerupGUI.endDraw();
}

