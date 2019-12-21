enum Screen{
    MENU, GAME, GAMEOVER
};

Screen onScreen;

String skinMap;
String[] skins = {"casino", "first", "scarab"};
String[] extra = {"Tips", "Help\n(TODO)","2","3","4","5"};
String[] modes = {"Marathon", "Sprint", "Turnado"};
String hs = "./Highscores.txt";

Game gameMode;
Boolean displayTips;
int selectedRectX;
int selectedRectY;
int selectedModeX;

PImage[] spaceships = new PImage[3];
PImage spaceShip;
PImage meteor;
PImage stevilcnica;
PImage select;
PImage wrong;
PImage[] bulletANI_ = new PImage[0];
ArrayList<PImage> bulletANI;

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

float distX;
float distY;
int meteorRadius;
float mouseDistance;

int initialTime;
//spawn interval
int interval;

int[][] getHighscores(){
  int[][] highScores = new int[modes.length][3];
  try{
    BufferedReader scoreReader = createReader(hs);
    for(int i = 0; i < modes.length; i++){
        scoreReader.readLine(); //gameMode name
        highScores[i][0] = Integer.parseInt(scoreReader.readLine());
        highScores[i][1] = Integer.parseInt(scoreReader.readLine());
        highScores[i][2] = Integer.parseInt(scoreReader.readLine());
    }
    scoreReader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  
  return highScores;
}

void editHighscore(int value, Game gm){
  String gameMode;
  if(gm instanceof Marathon)  gameMode = "Marathon";
  else if(gm instanceof Sprint)  gameMode = "Sprint";
  else if(gm instanceof Turnado)  gameMode = "Turnado";
  else{
    print("ERROR IN EDIT HIGHSCORE! GAMEMODE NOT ADDED!");
    return;
  }
 
  String[] lines = loadStrings(hs);
  for(int i  = 0; i < lines.length; i++){
    if(lines[i].equals(gameMode)){
      for(int j = 1; j < 4; j++){
        int score = Integer.parseInt(lines[i+j]);
        if(value > score){
          lines[i+j] = value+"";
          value = score;
        }
      }
      break;
    }
  }
  saveStrings(hs, lines);
}

void setup(){
  size(1600,900);
  frameRate(30);
  background(0);
  
  onScreen = Screen.MENU;
  
  skinMap = "Pics/casino";
  gameMode = new Marathon();
  selectedRectX = 0;
  selectedRectY = height/3;
  selectedModeX = 0;
  displayTips = false;
  
  changeSkin();
  
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
  
  result = 0;
  meteorRadius = meteor.height/2;
  
  initialTime = millis();
  interval = 5000; //5 sec
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
      gameMode.drawGameover();
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
  line(0, 5*height/6, width/2, 5*height/6);
  line(width/10, height/3, width/10, height);
  line(2*width/10, height/3, 2*width/10, height);
  line(3*width/10, height/3, 3*width/10, height);
  line(4*width/10, height/3, 4*width/10, height);
  
  
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
  //extra
  fill(255, 0, 0);
  index = 0;
  for(int i = 0;  i < width/2; i += width/10){
    try{
      text(extra[index], i + width/20, 2*height/3 + height/12);
    }catch(Exception e){}
    index++;
  }
  
  //game selection/game modes
  noFill();
  stroke(204, 255, 0);
  strokeWeight(5);
  rect(selectedModeX, 5*height/6, width/10, height/6);
  
  fill(0, 255, 0);
  index = 0;
  for(int i = 0;  i < width/2; i += width/10){
    try{
      text(modes[index], i + width/20, 5*height/6 + height/12);
    }catch(Exception e){}
    index++;
  }
  
  //play
  fill(255,255,255);
  text("PLAY", width/4,height/6);
  
  if(displayTips){
    displayTips();
  }
  
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
       skinMap = "Pics/casino";
    }
    
    changeSkin();
    
  }
  
  //extra selection
  else if(mouseX < width/2 && mouseY <   height
                           && mouseY > 2*height/3){
   
    if(mouseY < 5*height/6){
      if(mouseX < width/10){
        selectedRectX = 0;
        displayTips = !displayTips;
      }else if(mouseX < 2*width/10){
        selectedRectX = width/10;
        //TODO
      }else if(mouseX < 3*width/10){
        selectedRectX = 2*width/10;
        //TODO
      }else if(mouseX < 4*width/10){
        selectedRectX = 3*width/10;
        //TODO
      }else if(mouseX < 5*width/10){
        selectedRectX = 4*width/10;
       
      }
   //game mode selection
    }else{
      if(mouseX < width/10){
        //MARATHON
        selectedModeX = 0;
        selectedRectX = 0;
        gameMode = new Marathon();
        
      }else if(mouseX < 2*width/10){
        //SPRINT
        selectedModeX = width/10;
        selectedRectX = width/10;
        gameMode = new Sprint();
        
      }else if(mouseX < 3*width/10){
        selectedModeX = 2*width/10;
        selectedRectX = 2*width/10;
        gameMode = new Turnado();
        
      }else if(mouseX < 4*width/10){
        selectedModeX = 3*width/10;
        selectedRectX = 3*width/10;
        //TODO
      }else if(mouseX < 5*width/10){
        selectedModeX = 4*width/10;
        selectedRectX = 4*width/10;
       
      }
    }
    
    
    if(mouseY < 5*height/6)  selectedRectY = 2*height/3;
    else{
      selectedRectY = 5*height/6;
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

void mouseGameover(){
  editHighscore(numOfDestroied, gameMode);
  numOfDestroied = 0;
  
  meteors = new ArrayList<Meteor>();
  lives = 0;
  spaceShip = spaceships[0];
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
         
         int result2 = result % 10;
         
         //CHECK IF THE RESULT IS CORRECT
         if(selected.rezultat == result || selected.rezultat == result2){
           
           Bullet b = new Bullet(selected);
           bullets.add(b);
          
           //meteors.remove(selected);
           selected = null;
           result = 0;
           
         }else if(result > 10){
           //we entered 2 number is the result is 10 or bigger, if we didnt get it we reset the result value to 0 cuz we missed it
           result = 0;
           
           selected.wrongTime = millis();
         }  
         
         return;
       }else{
         selected = null;
         result = 0;
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

void displayTips(){
  
  String tips = "1 * x:\n"+
    "1 * 1 = 1\n"+
    "1 * 2 = 2\n"+
    "1 * 3 = 3\n"+
    "1 * 4 = 4\n"+
    "...\n"+
    "\n"+
    "9 * x\n"+
    "This one is eazy\n" +
    "once you know that the digits\n"+
    "in the answer always add up to 9:\n"+
    "1*9 = 9\n"+
    "2*9 = 18 -> 1+8 = 9\n"+
    "3*9 = 27 -> 2+7 = 9\n"+
    "8*9 = 72 -> 7+2 = 9\n"+
    "...\n"+
    "another trick is to multiply the number by 10\n"+ 
    "and then just subtract the same number\n"+
    "example:\n"+
    "4 * 9 = 10 * 4 - 4 = 40 - 4 = 36\n"+
    "6 * 9 = 60 - 6 = 54\n"+
    "\n"+
    "\n"+
    "\n"+
    "\n"+
    "\n"+
    "\n"+
    "\n"+
    "\n"+
    "\n";
    
    textSize(22);
    textAlign(LEFT);
    text(tips,width/2 + 40, 40);
   
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
  
  ena = loadImage(skinMap+"/1.png");
  dva = loadImage(skinMap+"/2.png");
  tri = loadImage(skinMap+"/3.png");
  stiri = loadImage(skinMap+"/4.png");
  pet = loadImage(skinMap+"/5.png");
  sest = loadImage(skinMap+"/6.png");
  sedem = loadImage(skinMap+"/7.png");
  osem = loadImage(skinMap+"/8.png");
  devet = loadImage(skinMap+"/9.png");
  
  ////////////////
  ///FIX THIS/////
  ////////////////
  bulletANI = new ArrayList<PImage>();
  int index = 1;
  
  while(true){
    PImage bullet_image = loadImage(skinMap+"/bullet" + index + ".png");
    if(bullet_image != null){
      bulletANI.add(loadImage(skinMap+"/bullet" + index + ".png"));
      index++;
    }else
      break;
  }
}