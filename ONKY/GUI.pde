int  powerupGUIinterval=135, GUIoffsetX=50, GUIoffsetY=160 ,iconSize=110;
final int MAX_POWERUP_DISPLAYING=4;
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
if (!tutorial) {
  GUI.clear();
  GUI.beginDraw();
  for (int i=0; i<p.lives; i++) GUI.image(p.Life, int((50+i*50)*screenFactor), int(60*screenFactor), 40*screenFactor, 40*screenFactor);
  GUI.endDraw();
  }
}
void UpdatePowerupGUILife() {
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
  powerupGUI.clear();
  powerupGUI.endDraw();
  GUI.beginDraw();
  GUI.clear();
  GUI.endDraw();
}

