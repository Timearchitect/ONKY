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
  int index, interval=110, GUIoffsetX=50, GUIoffsetY=height-150;

  if (mouseButton==LEFT) {  

    p.startPunch();

    noStroke();
    // fill(powerupColor);
    // rect(50+index*interval, 100, 100, 100);
    for ( Powerup pow : p.usedPowerup) {
      index=p.usedPowerup.indexOf(pow);
      if (  dist(GUIoffsetX+pow.w*0.5+index*interval, GUIoffsetY+pow.h*0.5, mouseX, mouseY) < 45   ) {
        background(0, 255, 0);
        pow.toggle=!pow.toggle;
      }
    }
  }
}

