class Box extends Obstacle{

    Box(int _x,int _y){
      super(_x,_y);
       obstacleColor = color(100,100,50);
      
    }
    void death(){
      super.death();

      for(int i =0; i< 4; i++){
        debris.add( new BoxDebris(this,x,y,random(15)+impactForce*0.5,random(30)-30));
      }
    }

}
class Tire extends Obstacle{

    Tire(int _x,int _y){
      super(_x,_y);
       obstacleColor = color(0,0,0);
      
    }
    void death(){
      super.death();
      for(int i =0; i< 4; i++){
        debris.add( new TireDebris(this,x,y,random(15)+impactForce*0.5,random(40)-30));
      }
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
    void death(){
    
    }
  void hitCollision() {  // hit by punching & smashing
    
  }
}
