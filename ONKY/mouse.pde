void mouseWheel(MouseEvent event) {  // krympa och förstora

    int temp = event.getCount() ;
    scaleFactor += temp * 0.05;
    if (scaleFactor<=0) {
      scaleFactor=0.1;
    }

    if (scaleFactor > 2) {
      scaleFactor=2;
    }

}
