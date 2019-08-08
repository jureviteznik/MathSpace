class Meteor{
  float radius;
  float posx;
  float posy;
  float angle;
  
  //time for X after the wrong answer
  float wrongTime;
  
  //change of angle
  float da;
  //change of radius
  float dr;
  
  PImage st1;
  PImage st2;
  int rezultat;
 
  //no idea se kku
  int speed;
  
  //draw and update meteor
  void update(){
    //draw meteor base
    pushMatrix();
      translate(posx,posy);
      imageMode(CENTER);
      image(meteor, 0, 0,100,100);
    popMatrix();
    
    //draw numbers inside the meteor
    pushMatrix();
      translate(posx - 16, posy);
      imageMode(CENTER);
      image(st1, 0, 0, 30, 30);
      translate(32,0);
      image(st2, 0, 0, 30, 30);
    popMatrix();
    
    if(millis() - wrongTime < 500){
      pushMatrix();
       translate(posx,posy);
       imageMode(CENTER);
       image(wrong, 0, 0);
      popMatrix();
    }
    
    //update
    posx = radius * cos(angle) + width/2;
    posy = radius * sin(angle) + height/2;
    angle += da;
    radius -= dr;
    
  }
  
  boolean hitShip(){
    if(radius < spaceShip.height){
      return true;
    }
    return false;
  }
  
  //nubers[] is array of numbers we can select
  Meteor(IntList numbers){
    
    wrongTime = 0;
    
    //meteor spawns at the top in the middle, just above the screen
    //posx = width/2;
    //posy = -meteor.height/2;
   
    int fromWhere = (int)random(2);
    switch(fromWhere){
      case 1:{
        radius = height/2 + meteor.height;
        angle = PI/2;
        break;
      }
      case 0:{
        radius = height/2 + meteor.height;
        angle = -PI/2;
        break;
      }
    }
    
    da = random(0.002,0.008);
    dr = random(0.5, 1);
    
    posx = radius * cos(angle) + width/2;
    posy = radius * sin(angle) + height/2;
    
    
    int index = (int)random(numbers.size());
    rezultat = numbers.get(index);
     switch(numbers.get(index)){
       case 1:{
         st1 = ena;
         break;
       }
       case 2:{
         st1 = dva;
         break;
       }
       case 3:{
         st1 = tri;
         break;
       }
       case 4:{
         st1 = stiri;
         break;
       }
       case 5:{
         st1 = pet;
         break;
       }
       case 6:{
         st1 = sest;
         break;
       }
       case 7:{
         st1 = sedem;
         break;
       }
       case 8:{
         st1 = osem;
         break;
       }
       case 9:{
         st1 = devet;
         break;
       }
     }
     
     index = (int)random(1,10);
     rezultat *= index;
     
     switch(index){
       case 1:{
         st2 = ena;
         break;
       }
       case 2:{
         st2 = dva;
         break;
       }
       case 3:{
         st2 = tri;
         break;
       }
       case 4:{
         st2 = stiri;
         break;
       }
       case 5:{
         st2 = pet;
         break;
       }
       case 6:{
         st2 = sest;
         break;
       }
       case 7:{
         st2 = sedem;
         break;
       }
       case 8:{
         st2 = osem;
         break;
       }
       case 9:{
         st2 = devet;
         break;
       }
       
     }
  }
}