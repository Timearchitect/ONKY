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
  GUI.clear();
  GUI.beginDraw();
  for (int i=0; i<p.lives; i++) GUI.image(p.Life, int((50+i*50)*screenFactor), int(60*screenFactor), 40*screenFactor, 40*screenFactor);
  GUI.endDraw();
}
void UpdatePowerupGUILife() {
  powerupGUI.clear();
  powerupGUI.beginDraw();
  int index, GUIoffsetY=height-150;


  for (Powerup pow : p.usedPowerup) {
    index=p.usedPowerup.indexOf(pow);
    powerupGUI.image(pow.icon, width-(GUIoffsetX+10+index*powerupGUIinterval)*screenFactor-85*screenFactor, GUIoffsetY+5, (110-20)*screenFactor, (110-20)*screenFactor);
    if (pow.upgradeLevel!=0)
      powerupGUI.text(pow.upgradeLevel+" LVL", width-(GUIoffsetX+pow.w*0.5+index*powerupGUIinterval)*screenFactor, GUIoffsetY+pow.h*0.5-80);
  }
  powerupGUI.endDraw();
  powerupGUI.endDraw();
}

