int  powerupGUIinterval=int(110), GUIoffsetX=50;
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
  int index, amount=0, GUIoffsetY=height-150;
  Powerup pow=null;
  amount= (MAX_POWERUP_DISPLAYING<p.usedPowerup.size()) ? MAX_POWERUP_DISPLAYING:p.usedPowerup.size();

  powerupGUI.clear();
  powerupGUI.beginDraw();

  //for (Powerup pow : p.usedPowerup) {
  for (int i=0; i<amount; i++) {
    pow =p.usedPowerup.get(i);
    index=p.usedPowerup.indexOf(pow);
    powerupGUI.image(pow.icon, width-(GUIoffsetX+10+index*powerupGUIinterval)*screenFactor-85*screenFactor, GUIoffsetY+5*screenFactor, (110-20)*screenFactor, (110-20)*screenFactor);
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

