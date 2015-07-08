
void mousePressed(MouseEvent event) {  // krympa och förstora
    int index, amount=0, interval=110, GUIoffsetX=50, GUIoffsetY=height-150;
    boolean powerupTap= false;
    Powerup pow=null;
    amount= (MAX_POWERUP_DISPLAYING<p.usedPowerup.size()) ? MAX_POWERUP_DISPLAYING:p.usedPowerup.size();

    //for ( Powerup pow : p.usedPowerup) {
    for (int i=0; i<amount; i++) {
      pow =p.usedPowerup.get(i);
      index=p.usedPowerup.indexOf(pow);
      if (dist(width-(GUIoffsetX+pow.w*0.5+index*powerupGUIinterval)*screenFactor, GUIoffsetY+pow.h*0.5*screenFactor, mouseX, mouseY) < 45*screenFactor   ) {
        fill(0);
        rect(width-(GUIoffsetX+pow.w*0.5+index*interval)*screenFactor+200, (GUIoffsetY+pow.h*0.5)*screenFactor, 120*screenFactor, 120*screenFactor);
        background(pow.powerupColor);
        pow.toggle=!pow.toggle;
        powerupTap=true;
      }
    }
    if (!powerupTap ) {
      if (width*0.5 < mouseX ) {
        p.startPunch();
        noStroke();
        // fill(powerupColor);
        // rect(50+index*interval, 100, 100, 100);
      } else {
        if (width*0.5 > mouseX && height*0.5 < mouseY) p.duck();
        if (width*0.5 > mouseX && height*0.5 > mouseY) p.jump();
      }
    }
}

