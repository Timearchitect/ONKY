
void mousePressed(MouseEvent event) {  // krympa och förstora
  int index, interval=110, GUIoffsetX=50, GUIoffsetY=height-150;
  boolean powerupTap= false;
  for ( Powerup pow : p.usedPowerup) {
    index=p.usedPowerup.indexOf(pow);
    if (  dist(width-(GUIoffsetX+pow.w*0.5+index*powerupGUIinterval)*screenFactor, GUIoffsetY+pow.h*0.5*screenFactor, mouseX, mouseY) < 45*screenFactor   ) {
      fill(0);
      rect(width-(GUIoffsetX+pow.w*0.5+index*interval)*screenFactor+200,(GUIoffsetY+pow.h*0.5)*screenFactor,100,100);
      
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

