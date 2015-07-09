/*void mouseWheel(MouseEvent event) {  // krympa och förstora
  int temp = event.getCount() ;
  targetScaleFactor += temp * 0.05;
  if (targetScaleFactor<=0) {
    targetScaleFactor=0.1;
  }
  if (targetScaleFactor > 2) {
    targetScaleFactor=2;
  }
}*/

void mousePressed(MouseEvent event) {  // krympa och förstora
    int index, amount=0, interval=110, GUIoffsetX=50, GUIoffsetY=height-150;
    boolean powerupTap= false;
    Powerup pow=null;
    amount= (MAX_POWERUP_DISPLAYING<p.usedPowerup.size()) ? MAX_POWERUP_DISPLAYING:p.usedPowerup.size();
if(gameState==0)gameOverCooldown-=50;
    //for ( Powerup pow : p.usedPowerup) {
    for (int i=0; i<amount; i++) {
      pow =p.usedPowerup.get(i);
      index=p.usedPowerup.indexOf(pow);
      if (dist(width-(GUIoffsetX+pow.w*0.5+index*powerupGUIinterval)*screenFactor, GUIoffsetY+pow.h*0.5*screenFactor, mouseX, mouseY) < 45*screenFactor   ) {
        //fill(0);
        background(pow.powerupColor);
        //rect(width-(GUIoffsetX+pow.w*0.5+index*interval)*screenFactor+200, (GUIoffsetY+pow.h*0.5)*screenFactor, 120*screenFactor, 120*screenFactor);
        pow.toggle=!pow.toggle;
        powerupTap=true;
      }
    }
    if (!powerupTap ) {
      if (width*0.5 < mouseX ) {
        p.startPunch();
        entities.add( new tapOverLayParticle(255, 2));
        entities.add( new tapOverLayParticle(255, 3));
      } else {
        if (width*0.5 > mouseX && height*0.5 < mouseY) { 
          p.duck();
          entities.add( new tapOverLayParticle(255, 1));
        }
        if (width*0.5 > mouseX && height*0.5 > mouseY) { 
          p.jump();
          entities.add( new tapOverLayParticle(255, 0));
        }
      }
    }
}

