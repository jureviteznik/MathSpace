import processing.sound.*;

enum Screen{
    MENU, GAME, GAMEOVER, GAMEPAUSE
};

Screen onScreen;

String skinMap;
String[] skins = {"scarab", "doodle","buzz","school","pokemon"};
String[] modes = {"Marathon", "Sprint", "Turnado", "Twirl"};
String[] modeDescription = {
    //marathon 
    "After 10 slutions you level up and equations spawn faster!",
    //Sprint
    "Each slutions speeds the game up!",
    //Turnado
    "Spinning gets faster and faster!",
    //Twirl
    "Fisrt only 1 equation will apear, then 2, then 3,.. and so on!"
  };

Game gameMode;
int selectedRectX;
int selectedRectY;
int selectedModeX;

SoundFile backgroundMusic;
SoundFile wrongSound;
SoundFile correctSound;
SoundFile shipHitSound;
float musicVolume;
HScrollbar volumeSlider;


PImage[] spaceships = new PImage[3];
PImage spaceShip;
PImage inputNum1;
PImage inputNum2;
PImage background;
PImage meteor;
PImage stevilcnica;
PImage select;
PImage wrong;
PImage[] bulletANI_ = new PImage[0];
ArrayList<PImage> bulletANI;

PImage nic;
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
int numOfDestroied;
int numOfMissed;

float distX;
float distY;
int meteorRadius;
float mouseDistance;

int initialTime;


void setup(){
  size(1600,900);
  frameRate(30);
  background(0);
  
  onScreen = Screen.MENU;
  
  background = loadImage("Pics/background.png");
  
  skinMap = "Pics/scarab";
  gameMode = new Marathon();
  selectedRectX = 0;
  selectedRectY = height/3;
  selectedModeX = 0;
  
  changeSkin();
  
  backgroundMusic = new SoundFile(this, "Sounds/background1.wav");
  backgroundMusic.loop();
  musicVolume = 0.7;
  volumeSlider = new HScrollbar(width/2, height - height/20, width/2, height/20, 1); 
  backgroundMusic.amp(musicVolume);
  
  wrongSound = new SoundFile(this, "Sounds/wrong1.mp3");
  correctSound = new SoundFile(this, "Sounds/correct1.wav");
  shipHitSound = new SoundFile(this, "Sounds/shipHit1.wav");
  

  
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
  
  lives = 0;
  numOfDestroied = 0;
  numOfMissed = 0;
  
  result = 0;
  meteorRadius = meteor.height/2;
  
  initialTime = millis();
}

void draw(){
  switch(onScreen){
    case MENU:{
      drawMenu();
      break;
    }
    case GAME:{
      gameMode.drawGame();
      break;
    }
    case GAMEOVER:{
      drawGameover();
      break;
    }
    case GAMEPAUSE:{
      drawGamepause();
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
      resetGame();
      break;
    }
    case GAMEPAUSE:{
      onScreen = Screen.GAME;
      break;
    }
  }
 
}

void keyPressed(){
  switch(onScreen){
    case MENU:{
      break;
    }
    case GAME:{
      if(key == ESC){
        key = 0;
        onScreen = Screen.GAMEPAUSE;
      }
      
      break;
    }
    case GAMEOVER:{
      break;
    }
    case GAMEPAUSE:{
      if(key == ESC){
        key = 0;
        resetGame();
      }
      break;
    }
  }
}

public void drawGameover(){
    background(background);
    textSize(width/10);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2 ,height/2);
    
    textSize(width/20);
    text("Correct: " + numOfDestroied, width/2 ,height - height/3);
    text("Wrong: " + numOfMissed, width/2 ,height - height/4);
    //TODO ADD CLICK TO MENU
    
  };

public void drawGamepause(){
    background(background);
    textSize(width/10);
    textAlign(CENTER, CENTER);
    text("PAUSE", width/2 ,height/2);
    
    textSize(width/20);
    text("Mouse click to resume", width/2 ,height - height/3);
    text("Press ESC to exit to menu", width/2 ,height - height/4);
}

void drawMenu(){
  background(background);
  
  //VOLUME
  textAlign(LEFT, BOTTOM);
  text("Volume:", width/2 + 5, height-height/14);
  volumeSlider.update();
  volumeSlider.display();
  backgroundMusic.amp(volumeSlider.getVol());
  wrongSound.amp(volumeSlider.getVol());
  correctSound.amp(volumeSlider.getVol());
  shipHitSound.amp(volumeSlider.getVol());
  textAlign(CENTER, CENTER);
  
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
  line(0, 5*height/6, width/2, 5*height/6);
  line(width/10, height/3, width/10, 5*height/6);
  line(2*width/10, height/3, 2*width/10, 5*height/6);
  line(3*width/10, height/3, 3*width/10, 5*height/6);
  line(4*width/10, height/3, 4*width/10, 5*height/6);
  
  
  //draw skin stuff
  noFill();
  stroke(204, 102, 0);
  strokeWeight(5);
  rect(selectedRectX, selectedRectY, width/10, height/6);
  
  textSize(32);
  textAlign(CENTER);
  
  //skin selection
  fill(255, 204, 0);
  int index = 0;
  for(int j = height/3; j < 2*height/3; j += height/6){
    for(int i = 0;  i < width/2; i += width/10){
      try{
        text(skins[index], i + width/20, j + height/12);
      }catch(Exception e){}
      index++;
    }
    
  }
  //mode selection
  fill(0, 255, 0);
  index = 0;
  for(int i = 0;  i < width/2; i += width/10){
    try{
      text(modes[index], i + width/20, 2*height/3 + height/12);
    }catch(Exception e){}
    index++;
  }
  
  //game selection/game modes
  noFill();
  stroke(204, 255, 0);
  strokeWeight(5);
  rect(selectedModeX, 4*height/6, width/10, height/6);
  
  index = 0;
  if(gameMode instanceof Marathon){
      index = 0;
  }else if(gameMode instanceof Sprint){
    index = 1;
  }else if(gameMode instanceof Turnado){
    index = 2;
  }else if(gameMode instanceof Twirl){
    index = 3;
  }
  fill(255,0, 0);
  text(modeDescription[index], 0, 21*height/24, width/2, height);
  /*
  for(int i = 0;  i < width/2; i += width/10){
    try{
      text(modes[index], i + width/20, 5*height/6 + height/12);
    }catch(Exception e){}
    index++;
  }
  */
  
  //play button
  fill(255,255,255);
  text("PLAY", width/4,height/6);
  
  
}



void mouseMenu(){
  
  //skin selection
  if(mouseX < width/2 && mouseY < 2*height/3 && mouseY > height/3){
    int sel = 0;
    
    if(mouseX < width/10){
      selectedRectX = 0;
      sel = 0;
    }else if(mouseX < 2*width/10){
      selectedRectX = width/10;
      sel = 1;
    }else if(mouseX < 3*width/10){
      selectedRectX = 2*width/10;
      sel = 2;
    }else if(mouseX < 4*width/10){
      selectedRectX = 3*width/10;
      sel = 3;
    }else if(mouseX < 5*width/10){
      selectedRectX = 4*width/10;
      sel = 4;
    }
    
    if(mouseY < height/2)  selectedRectY = height/3;
    else{
      selectedRectY = height/2;
      sel += 5;
    }
    
    try{
      skinMap = "Pics/" + skins[sel];
    }catch(Exception e){
       //skinMap = "Pics/casino";
    }
    
    changeSkin();
    
  }
  
  //extra selection
  else if(mouseX < width/2 && mouseY <   height
                           && mouseY > 2*height/3){
   
   //game mode selection
    if(mouseY < 5*height/6){
      if(mouseX < width/10){
        //MARATHON
        selectedModeX = 0;
        gameMode = new Marathon();
        
      }else if(mouseX < 2*width/10){
        //SPRINT
        selectedModeX = width/10;
        gameMode = new Sprint();
        
      }else if(mouseX < 3*width/10){
        selectedModeX = 2*width/10;
        gameMode = new Turnado();
        
      }else if(mouseX < 4*width/10){
        selectedModeX = 3*width/10;
        gameMode = new Twirl();
      }else if(mouseX < 5*width/10){
        //selectedModeX = 4*width/10;
       
      }
    }else{
      
    }
    
    
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

void mouseGame(){
  if(selected != null){
    mouseDistance = dist(mouseX, mouseY, selected.posx, selected.posy);
    
    if(mouseDistance <= stevilcnica.width/2){   
         float angle = atan2(mouseY-selected.posy, mouseX-selected.posx);
         
         if(angle > 0 && angle < PI/5){
           //3
           result = result*10 + 3;
           if(inputNum1 == null) inputNum1 = tri;
           else inputNum2 = tri;
         }else if(angle > PI/5 && angle < 2*PI/5){
           //4
           result = result*10 + 4;
           if(inputNum1 == null) inputNum1 = stiri;
           else inputNum2 = stiri;
         }else if(angle > 2*PI/5 && angle < 3*PI/5){
           //5
           result = result*10 + 5;
           if(inputNum1 == null) inputNum1 = pet;
           else inputNum2 = pet;
         }else if(angle > 3*PI/5 && angle < 4*PI/5){
           //6
           result = result*10 + 6;
           if(inputNum1 == null) inputNum1 = sest;
           else inputNum2 = sest;
         }else if(angle > 4*PI/5 && angle < 5*PI/5){
           //7
           result = result*10 + 7;
           if(inputNum1 == null) inputNum1 = sedem;
           else inputNum2 = sedem;
         }else if(angle > -5*PI/5 && angle < -4*PI/5){
           //8
           result = result*10 + 8;
           if(inputNum1 == null) inputNum1 = osem;
           else inputNum2 = osem;
         }else if(angle > -4*PI/5 && angle < -3*PI/5){
           //9
           result = result*10 + 9;
           if(inputNum1 == null) inputNum1 = devet;
           else inputNum2 = devet;
         }else if(angle > -3*PI/5 && angle < -2*PI/5){
           //0
           result = result*10 + 0;
           if(inputNum1 == null) inputNum1 = nic;
           else inputNum2 = nic;
         }else if(angle > -2*PI/5 && angle < -PI/5){
           //1
           result = result*10 + 1;
           if(inputNum1 == null) inputNum1 = ena;
           else inputNum2 = ena;
         }else if(angle > -PI/5 && angle < 0){
           //2
           result = result*10 + 2;
           if(inputNum1 == null) inputNum1 = dva;
           else inputNum2 = dva;
         }
         
         int result2 = result % 10;
         
         //CHECK IF THE RESULT IS CORRECT
         if(selected.rezultat == result || selected.rezultat == result2){
           correctSound.play();
           
           Bullet b = new Bullet(selected, inputNum1, inputNum2);
           bullets.add(b);
           
           //meteors.remove(selected);
           selected = null;
           result = 0;
           inputNum1 = null;
           inputNum2 = null;
           
         }else if(result > 10){
           //we entered 2 number is the result is 10 or bigger, if we didnt get it we reset the result value to 0 cuz we missed it
           wrongSound.play();
           result = 0;
           inputNum1 = null;
           inputNum2 = null;
           numOfMissed++;
           selected.wrongTime = millis();
         }  
         
         return;
       }else{
         selected = null;
         result = 0;
         inputNum1 = null;
         inputNum2 = null;
       }
  }else{
    for(int i = 0; i < meteors.size(); i++){
       Meteor m = meteors.get(i);
       mouseDistance = dist(mouseX, mouseY, m.posx, m.posy);
       if(mouseDistance <= meteorRadius/2){
          selected = m;
       }
    }
  }
}

void resetGame(){
  numOfDestroied = 0;
  numOfMissed = 0;
  meteors = new ArrayList<Meteor>();
  lives = 0;
  spaceShip = spaceships[0];
  onScreen = Screen.MENU;
  if(gameMode instanceof Marathon){
    gameMode = new Marathon();
  }else if(gameMode instanceof Sprint){
    gameMode = new Sprint();
  }else if(gameMode instanceof Turnado){
    gameMode = new Turnado();
  }else if(gameMode instanceof Twirl){
    gameMode = new Twirl();
  }
}

void changeSkin(){
  spaceships[0] = loadImage(skinMap+"/space_ship1.png");
  spaceships[1] = loadImage(skinMap+"/space_ship2.png");
  spaceships[2] = loadImage(skinMap+"/space_ship3.png");
  spaceShip = spaceships[0];
  meteor = loadImage(skinMap+"/meteor.png");
  stevilcnica = loadImage(skinMap+"/select_circle.png");
  select = loadImage(skinMap+"/select.png");
  wrong = loadImage(skinMap+"/wrong.png");
  
  nic = loadImage(skinMap+"/0.png");
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

/*
code from https://processing.org/examples/scrollbar.html
used for a volume slider 
*/
class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
  
  float getVol(){
    return (spos / swidth) - 1;
  }
}
