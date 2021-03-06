void mouseWheel(MouseEvent event) {  // krympa och förstora
  int temp = event.getCount() ;
  targetScaleFactor += temp * 0.05;
  if (targetScaleFactor<=0) {
    targetScaleFactor=0.1;
  }
  if (targetScaleFactor > 2) {
    targetScaleFactor=2;
  }
}

void mousePressed(MouseEvent event) {  // krympa och förstora
   if (!automate && !p.taunt) {
  if (mouseButton==LEFT) {
    int index, amount=0, interval=110;
    boolean powerupTap= false;
    Powerup pow=null;
    amount= (MAX_POWERUP_DISPLAYING<p.usedPowerup.size()) ? MAX_POWERUP_DISPLAYING:p.usedPowerup.size();

    //for ( Powerup pow : p.usedPowerup) {
    for (int i=0; i<amount; i++) {
      pow =p.usedPowerup.get(i);
      index=p.usedPowerup.indexOf(pow);
      if (dist(width-(GUIoffsetX+iconSize*0.5+index*powerupGUIinterval)*screenFactor, height-(GUIoffsetY-iconSize*0.5)*screenFactor, mouseX, mouseY) < iconSize*0.5*screenFactor   ) {
        //fill(0);
        background(pow.powerupColor);
        //rect(width-(GUIoffsetX+pow.w*0.5+index*interval)*screenFactor+200, (GUIoffsetY+pow.h*0.5)*screenFactor, 120*screenFactor, 120*screenFactor);
        pow.toggle=!pow.toggle;
        powerupTap=true;
        //entities.add( new tapOverLayParticle(mouseX, mouseY, 255, 4));
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
  } else if (mouseButton==RIGHT) {
    entities.add( new LaserProjectile(  int(p.x+p.w*0.8), int(p.y+p.h*0.3), 60, 0));
  } else  entities.add( new BigLaserProjectile(  int(p.x+p.w*0.5+100), int(p.y+p.h*0.2), 10, 0));
 }
}

