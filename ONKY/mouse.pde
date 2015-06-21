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
