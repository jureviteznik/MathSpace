interface Game{
  void drawGame();
}

/*
//////////
/TEMPLATE/
//////////

void drawGame(){
  background(0);
  fill(255);
  
  //spawn new meteors
  if(millis() - initialTime > interval){
    meteors.add(new Meteor(mozneStevke));
    initialTime = millis();
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
  
  //draw spaceship
  
  pushMatrix();
    translate(width/2, height/2);
    rotate(shipAngle + PI/2);
    imageMode(CENTER);
    image(spaceShip, 0, 0);
  popMatrix();
  
  //update/draw meteors
  for(int i = 0; i < meteors.size(); i++){
    Meteor m = meteors.get(i);
    m.update();
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
  
  //update/draw bullets
  for(int i = 0; i < bullets.size(); i++){
    Bullet b = bullets.get(i);
    b.update();
  }
}

*/
