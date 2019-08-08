enum Screen{
    MENU, GAME, GAMEOVER
};

Screen onScreen;

String skinMap;
String[] skins = {"casino", "first"};
int selectedSkinX;
int selectedSkinY;

PImage spaceShip;
PImage meteor;
PImage stevilcnica;
PImage select;
PImage wrong;
PImage bullet;

PImage ena;
PImage dva;
PImage tri;
PImage stiri;
PImage pet;
PImage sest;
PImage sedem;
PImage osem;
PImage devet;

float shipAngle;

IntList mozneStevke;

ArrayList<Meteor> meteors;
Meteor selected;

ArrayList<Bullet> bullets;

int result;

int lives;

float distX;
float distY;
int meteorRadius;
float mouseDistance;

int initialTime;
//spawn interval
int interval;

void setup(){
  size(1600,900);
  frameRate(30);
  background(0);
  
  onScreen = Screen.MENU;
  
  skinMap = "Pics/casino";
  selectedSkinX = 0;
  selectedSkinY = height/3;
  
  spaceShip = loadImage(skinMap+"/space_ship.png");
  meteor = loadImage(skinMap+"/meteor.png");
  stevilcnica = loadImage(skinMap+"/select_circle.png");
  select = loadImage(skinMap+"/select.png");
  wrong = loadImage(skinMap+"/wrong.png");
  bullet = loadImage(skinMap+"/bullet.png");
  
  ena = loadImage(skinMap+"/1.png");
  dva = loadImage(skinMap+"/2.png");
  tri = loadImage(skinMap+"/3.png");
  stiri = loadImage(skinMap+"/4.png");
  pet = loadImage(skinMap+"/5.png");
  sest = loadImage(skinMap+"/6.png");
  sedem = loadImage(skinMap+"/7.png");
  osem = loadImage(skinMap+"/8.png");
  devet = loadImage(skinMap+"/9.png");
  
  meteors = new ArrayList<Meteor>();
  bullets = new ArrayList<Bullet>();
  mozneStevke = new IntList();
  mozneStevke.append(1);
  mozneStevke.append(2);
  mozneStevke.append(3);
  mozneStevke.append(4);
  mozneStevke.append(5);
  mozneStevke.append(6);
  mozneStevke.append(7);
  mozneStevke.append(8);
  mozneStevke.append(9);
  
  lives = 3;
  
  result = 0;
  meteorRadius = meteor.height/2;
  
  initialTime = millis();
  interval = 3000; //3 sec
}

void draw(){
  switch(onScreen){
    case MENU:{
      drawMenu();
      break;
    }
    case GAME:{
      drawGame();
      break;
    }
    case GAMEOVER:{
      drawGameover();
      break;
    }
  }
}

void mousePressed(){
  switch(onScreen){
    case MENU:{
      mouseMenu();
      break;
    }
    case GAME:{
      mouseGame();
      break;
    }
    case GAMEOVER:{
      mouseGameover();
      break;
    }
  }
 
}

void drawMenu(){
  background(0);
  
  shipAngle = atan2(mouseY-3*height/4, mouseX-3*width/4);
  
  //draw spaceship
  pushMatrix();
    translate(3*width/4, 3*height/4);
    rotate(shipAngle + PI/2);
    imageMode(CENTER);
    image(spaceShip, 0, 0);
  popMatrix();
  
  //draw meteor and nuber selector
  pushMatrix();
    translate(3*width/4, height/4);
    imageMode(CENTER);
    image(stevilcnica, 0, 0);
    image(meteor, 0, 0, 100, 100);
  popMatrix();
    float angle;
    
    if(mozneStevke.hasValue(3)){
         //3
         pushMatrix();
        translate(3*width/4, height/4);
        angle = PI/10;
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
        popMatrix();
     }
    if(mozneStevke.hasValue(4)){
       //4
       pushMatrix();
    translate(3*width/4, height/4);
       angle = 3*PI/10;
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
        popMatrix();
     }
    if(mozneStevke.hasValue(5)){
       //5
       pushMatrix();
    translate(3*width/4, height/4);
       angle = 5*PI/10;
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
        popMatrix();
     }
    if(mozneStevke.hasValue(6)){
       //6
       pushMatrix();
    translate(3*width/4, height/4);
       angle = 7*PI/10;
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
        popMatrix();
     }
    if(mozneStevke.hasValue(7)){
       //7
       pushMatrix();
    translate(3*width/4, height/4);
       angle = 9*PI/10;
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
        popMatrix();
     }
    if(mozneStevke.hasValue(8)){
       //8
       pushMatrix();
    translate(3*width/4, height/4);
       angle = -9*PI/10;
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
        popMatrix();
     }
    if(mozneStevke.hasValue(9)){
       //9
       pushMatrix();
    translate(3*width/4, height/4);
       angle = -7*PI/10;
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
        popMatrix();
     }
    if(mozneStevke.hasValue(1)){
       //1
       pushMatrix();
    translate(3*width/4, height/4);
       angle = -3*PI/10;
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
        popMatrix();
     }
    if(mozneStevke.hasValue(2)){
       //2
       pushMatrix();
        translate(3*width/4, height/4);
       angle = -PI/10;
        rotate(angle + PI/2);
        translate(0,-100);
        image(select,0,0);
        popMatrix();
     }


  //draw lines
  stroke(255);
  strokeWeight(5);
  line(width/2, 0, width/2, height);
  line(0, height/3, width/2, height/3);
  line(0, 2*height/3, width/2, 2*height/3);
  
  strokeWeight(3);
  line(0, height/2, width/2, height/2);
  line(width/10, height/3, width/10, 2*height/3);
  line(2*width/10, height/3, 2*width/10, 2*height/3);
  line(3*width/10, height/3, 3*width/10, 2*height/3);
  line(4*width/10, height/3, 4*width/10, 2*height/3);
  
  
  //draw skin stuff
  noFill();
  stroke(204, 102, 0);
  strokeWeight(5);
  rect(selectedSkinX, selectedSkinY, width/10, height/6);
  
  textSize(32);
  textAlign(CENTER);
  int index = 0;
  for(int j = height/3; j < height; j += height/3){
    for(int i = 0;  i < width/2; i += width/10){
      try{
        text(skins[index], i + width/20, j + height/12);
      }catch(Exception e){}
      index++;
    }
  }
  
  //game selection
  
  
  //play
  text("PLAY", width/4,height/6);
  
}

void drawGameover(){
   background(0);
   textSize(width/10);
   text("GAME OVER", 100 ,height/2);
};

void drawGame(){
  background(0);
  fill(255);
  text(lives+"", 10,10);
  
 //GAME OVER
 if(lives < 1){
   onScreen = Screen.GAMEOVER;
 }
 
  
  //spawn new meteors
  if(millis() - initialTime > interval){
    meteors.add(new Meteor(mozneStevke));
    initialTime = millis();
  }
  
   
  
  //draw input numbers
  //MUST BE AFTER DRAW METEORS!!!!!!!!!!!!!!!!!!!!!!!!! (BUT NOT RN CUZ I NEED THE PICS)
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
      lives--;
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

void mouseMenu(){
  //game selection
  //TODO
  
  //skin selection
  if(mouseX < width/2 && mouseY < 2*height/3 && mouseY > height/3){
    int sel = 0;
    
    if(mouseX < width/10){
      selectedSkinX = 0;
      sel = 0;
    }else if(mouseX < 2*width/10){
      selectedSkinX = width/10;
      sel = 1;
    }else if(mouseX < 3*width/10){
      selectedSkinX = 2*width/10;
      sel = 2;
    }else if(mouseX < 4*width/10){
      selectedSkinX = 3*width/10;
      sel = 3;
    }else if(mouseX < 5*width/10){
      selectedSkinX = 4*width/10;
      sel = 4;
    }
    
    if(mouseY < height/2)  selectedSkinY = height/3;
    else{
      selectedSkinY = height/2;
      sel += 5;
    }
    
    try{
      skinMap = "Pics/" + skins[sel];
    }catch(Exception e){
       skinMap = "Pics/casino";
    }
    
    changeSkin();
    
  }
  
  if(mouseX < width/2 && mouseY < height/3){
    onScreen = Screen.GAME;
    if(mozneStevke.size() == 0){
      mozneStevke.append(1);
      mozneStevke.append(2);
      mozneStevke.append(3);
      mozneStevke.append(4);
      mozneStevke.append(5);
      mozneStevke.append(6);
      mozneStevke.append(7);
      mozneStevke.append(8);
      mozneStevke.append(9);
    }
  }
  
  //number selection
  mouseDistance = dist(mouseX, mouseY, 3*width/4, height/4);
  if(mouseDistance <= stevilcnica.width/2){   
         float angle = atan2(mouseY-height/4, mouseX-3*width/4);
         
         if(angle > 0 && angle < PI/5){
           //3
           if(mozneStevke.hasValue(3)){
             for(int i = 0; i < mozneStevke.size(); i++){
               if(mozneStevke.get(i) == 3){
                 mozneStevke.remove(i);
               }
             }
           }else{
             mozneStevke.append(3);
           }
         }else if(angle > PI/5 && angle < 2*PI/5){
           //4
           if(mozneStevke.hasValue(4)){
             for(int i = 0; i < mozneStevke.size(); i++){
               if(mozneStevke.get(i) == 4){
                 mozneStevke.remove(i);
               }
             }
           }else{
             mozneStevke.append(4);
           }
         }else if(angle > 2*PI/5 && angle < 3*PI/5){
           //5
           if(mozneStevke.hasValue(5)){
             for(int i = 0; i < mozneStevke.size(); i++){
               if(mozneStevke.get(i) == 5){
                 mozneStevke.remove(i);
               }
             }
           }else{
             mozneStevke.append(5);
           }
         }else if(angle > 3*PI/5 && angle < 4*PI/5){
           //6
           if(mozneStevke.hasValue(6)){
             for(int i = 0; i < mozneStevke.size(); i++){
               if(mozneStevke.get(i) == 6){
                 mozneStevke.remove(i);
               }
             }
           }else{
             mozneStevke.append(6);
           }
         }else if(angle > 4*PI/5 && angle < 5*PI/5){
           //7
           if(mozneStevke.hasValue(7)){
             for(int i = 0; i < mozneStevke.size(); i++){
               if(mozneStevke.get(i) == 7){
                 mozneStevke.remove(i);
               }
             }
           }else{
             mozneStevke.append(7);
           }
         }else if(angle > -5*PI/5 && angle < -4*PI/5){
           //8
           if(mozneStevke.hasValue(8)){
             for(int i = 0; i < mozneStevke.size(); i++){
               if(mozneStevke.get(i) == 8){
                 mozneStevke.remove(i);
               }
             }
           }else{
             mozneStevke.append(8);
           }
         }else if(angle > -4*PI/5 && angle < -3*PI/5){
           //9
           if(mozneStevke.hasValue(9)){
             for(int i = 0; i < mozneStevke.size(); i++){
               if(mozneStevke.get(i) == 9){
                 mozneStevke.remove(i);
               }
             }
           }else{
             mozneStevke.append(9);
           }
         }else if(angle > -2*PI/5 && angle < -PI/5){
           //1
            if(mozneStevke.hasValue(1)){
             for(int i = 0; i < mozneStevke.size(); i++){
               if(mozneStevke.get(i) == 1){
                 mozneStevke.remove(i);
               }
             }
           }else{
             mozneStevke.append(1);
           }
         }else if(angle > -PI/5 && angle < 0){
           //2
           if(mozneStevke.hasValue(2)){
             for(int i = 0; i < mozneStevke.size(); i++){
               if(mozneStevke.get(i) == 2){
                 mozneStevke.remove(i);
               }
             }
           }else{
             mozneStevke.append(2);
           }
         }
  }
  
}

void mouseGameover(){
  meteors = new ArrayList<Meteor>();
  lives = 3;
  onScreen = Screen.MENU;
}

void mouseGame(){
  if(selected != null){
    mouseDistance = dist(mouseX, mouseY, selected.posx, selected.posy);
    
    if(mouseDistance <= stevilcnica.width/2){   
         float angle = atan2(mouseY-selected.posy, mouseX-selected.posx);
         
         if(angle > 0 && angle < PI/5){
           //3
           result = result*10 + 3;
         }else if(angle > PI/5 && angle < 2*PI/5){
           //4
           result = result*10 + 4;
         }else if(angle > 2*PI/5 && angle < 3*PI/5){
           //5
           result = result*10 + 5;
         }else if(angle > 3*PI/5 && angle < 4*PI/5){
           //6
           result = result*10 + 6;
         }else if(angle > 4*PI/5 && angle < 5*PI/5){
           //7
           result = result*10 + 7;
         }else if(angle > -5*PI/5 && angle < -4*PI/5){
           //8
           result = result*10 + 8;
         }else if(angle > -4*PI/5 && angle < -3*PI/5){
           //9
           result = result*10 + 9;
         }else if(angle > -3*PI/5 && angle < -2*PI/5){
           //0
           result = result*10 + 0;
         }else if(angle > -2*PI/5 && angle < -PI/5){
           //1
           result = result*10 + 1;
         }else if(angle > -PI/5 && angle < 0){
           //2
           result = result*10 + 2;
         }
         
         
         //CHECK IF THE RESULT IS CORRECT
         if(selected.rezultat == result){
           
           Bullet b = new Bullet(selected);
           bullets.add(b);
          
           //meteors.remove(selected);
           selected = null;
           result = 0;
           
         }else if(result > 10){
           //if the entered number is bigger then 10 that means we entered 2 numbers and since the biggest number is 81 (9*9) if that is not the result, we reset the input
           result = 0;
           
           selected.wrongTime = millis();
         }  
         
         return;
       }else{
         selected = null;
         result = 0;
       }
  }
   
  for(int i = 0; i < meteors.size(); i++){
     Meteor m = meteors.get(i);
     mouseDistance = dist(mouseX, mouseY, m.posx, m.posy);
     if(mouseDistance <= meteorRadius){
        selected = m;
     }
  }
}

void changeSkin(){
  spaceShip = loadImage(skinMap+"/space_ship.png");
  meteor = loadImage(skinMap+"/meteor.png");
  stevilcnica = loadImage(skinMap+"/select_circle.png");
  select = loadImage(skinMap+"/select.png");
  wrong = loadImage(skinMap+"/wrong.png");
  bullet = loadImage(skinMap+"/bullet.png");
  
  ena = loadImage(skinMap+"/1.png");
  dva = loadImage(skinMap+"/2.png");
  tri = loadImage(skinMap+"/3.png");
  stiri = loadImage(skinMap+"/4.png");
  pet = loadImage(skinMap+"/5.png");
  sest = loadImage(skinMap+"/6.png");
  sedem = loadImage(skinMap+"/7.png");
  osem = loadImage(skinMap+"/8.png");
  devet = loadImage(skinMap+"/9.png");
}