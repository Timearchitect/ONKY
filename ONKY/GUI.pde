  int  powerupGUIinterval=110, GUIoffsetX=50;
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
  powerupGUI.textFont(font,30);
  UpdatePowerupGUILife() ;
}

void UpdateGUILife() {
  GUI.clear();
  GUI.beginDraw();
  for (int i=0; i<p.lives; i++) GUI.image(p.Life, int(50+i*50), int(60), 40, 40);
  GUI.endDraw();
}
void UpdatePowerupGUILife() {
  powerupGUI.clear();
  powerupGUI.beginDraw();
  int index, GUIoffsetY=height-150;      
  for (Powerup pow : p.usedPowerup) {
    index=p.usedPowerup.indexOf(pow);
    powerupGUI.image(pow.icon, GUIoffsetX+10+index*powerupGUIinterval, GUIoffsetY+10, 100-20, 100-20);
    powerupGUI.text(pow.upgradeLevel, GUIoffsetX+pow.w*0.5+index*powerupGUIinterval, GUIoffsetY+pow.h*0.5+80);
  }
  powerupGUI.endDraw();
  powerupGUI.endDraw();
}

