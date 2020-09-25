class Bullet{
  float posx;
  float posy;
  
  float angle;
  
  float speed = 25;
  
  Meteor goal;
  
  int animationTics = 0;
  int animationDelay = 0;
  
  PImage bullet;
  
  PImage num1;
  PImage num2;
  
  //update and draw
  void update(){
    
    angle = atan2(goal.posy-posy, goal.posx-posx);
    
    /*
    if(animationDelay > 0){
      animationDelay--;
    }else{
      animationDelay = 3;
      int index = animationTics % bulletANI.size();
      bullet = bulletANI.get(index);
      animationTics++;
    }
    */
    
    
    pushMatrix();
      translate(posx,posy);
      imageMode(CENTER);
      rotate(angle + PI/2);
      
      translate(-16, 0);
      image(num1, 0, 0, 30, 30);
      if(num2 != null){
        translate(32,0);
        image(num2, 0, 0, 30, 30);
      }
      
      
      //image(bullet, 0, 0);
    popMatrix();
    
    posx += cos(angle) * speed;
    posy += sin(angle) * speed;
    
    
    //when bullet hits delete the meteor and bullet
    distX = posx - goal.posx;
    distY = posy - goal.posy;
    mouseDistance = sqrt((distX*distX) + (distY*distY));
     
    if(mouseDistance <= meteorRadius){ 
      meteors.remove(goal);
      bullets.remove(this);
      numOfDestroied++;
    }
      
    animationTics++;
  
  }
  
  Bullet(Meteor m, PImage n1, PImage n2){
    posx = width/2;
    posy = height/2;
    
    num1 = n1;
    num2 = n2;
    
    goal = m;
    
  }
}
