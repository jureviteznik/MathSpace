class Sprint implements Game{
  int prevNumOfDestroied;
  //check meteor constructor for detail
  float aMax, aMin, rMax, rMin;
  
  //meteor speed increse when you destroy one
  float da, dr; 
  
  public Sprint(){
    aMax = 0.008;
    aMin = 0.002;
    rMax = 0.5;
    rMin = 0.7;
    
    da = 0.0001;
    dr = 0.05;
  }
  
 
 
  public void drawGame(){
    background(background);
    fill(255);
    
    //spawn new meteors
    if(meteors.isEmpty()){
      aMax += da;
      aMin += da;
      rMax += dr;
      rMax += dr;
      meteors.add(new Meteor(mozneStevke, aMin, aMax, rMin, rMax));
    }
   
    //draw number of destroied meteors
    textSize(32);
    textAlign(LEFT, TOP);
    
    text("Score: " + numOfDestroied, 0, 0);
              
    
    //draw spaceship
    
    pushMatrix();
      translate(width/2, height/2);
      rotate(shipAngle + PI/2);
      imageMode(CENTER);
      image(spaceShip, 0, 0);
       
      if(inputNum1 != null){
          translate(0,-spaceShip.height/2);
          image(inputNum1, 0, -15, 30, 30);
      }
      
      
    popMatrix();
    
    //update/draw meteors
    for(int i = 0; i < meteors.size(); i++){
      Meteor m = meteors.get(i);
      if(m != selected) m.update();
      
      if(m.hitShip()){
        lives++;
        //GAME OVER
         if(lives >= spaceships.length){
           onScreen = Screen.GAMEOVER;
         }else{
           spaceShip = spaceships[lives];
         }
        if(m == selected){
          selected = null;      
        }
        meteors.remove(i);
      }
    }
    
    
    //draw input circle
    if(selected != null){
      float angle = atan2(mouseY-selected.posy, mouseX-selected.posx);
      pushMatrix();
        translate(selected.posx, selected.posy);
        imageMode(CENTER);
        image(stevilcnica, 0, 0);
        
        if(angle > 0 && angle < PI/5){
             //3
             angle = PI/10;
           }else if(angle > PI/5 && angle < 2*PI/5){
             //4
             angle = 3*PI/10;
           }else if(angle > 2*PI/5 && angle < 3*PI/5){
             //5
             angle = 5*PI/10;
           }else if(angle > 3*PI/5 && angle < 4*PI/5){
             //6
             angle = 7*PI/10;
           }else if(angle > 4*PI/5 && angle < 5*PI/5){
             //7
             angle = 9*PI/10;
           }else if(angle > -5*PI/5 && angle < -4*PI/5){
             //8
             angle = -9*PI/10;
           }else if(angle > -4*PI/5 && angle < -3*PI/5){
             //9
             angle = -7*PI/10;
           }else if(angle > -3*PI/5 && angle < -2*PI/5){
             //0
             angle = -5*PI/10;
           }else if(angle > -2*PI/5 && angle < -PI/5){
             //1
             angle = -3*PI/10;
           }else if(angle > -PI/5 && angle < 0){
             //2
             angle = -PI/10;
           }
           
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
      popMatrix();
      
      shipAngle = atan2(selected.posy-height/2, selected.posx-width/2);
    }else{
      shipAngle = atan2(mouseY-height/2, mouseX-width/2);
    }
    if(selected != null)  selected.update();
    
    
    //update/draw bullets
    for(int i = 0; i < bullets.size(); i++){
      Bullet b = bullets.get(i);
      b.update();
    }
  }
}
