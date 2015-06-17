class Box extends Obstacle{

    Box(int _x,int _y){
      super(_x,_y);
       obstacleColor = color(100,100,50);
      
    }

}
class IronBox extends Obstacle{

    IronBox(int _x,int _y){
      super(_x,_y);
       obstacleColor = color(150,150,150);
      
    }
    void death(){
    
    }

}
class PlatForm extends Obstacle{

  
    PlatForm(int _x,int _y){
      super(_x,_y);
      
      
    }

}
