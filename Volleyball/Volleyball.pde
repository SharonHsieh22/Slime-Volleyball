import fisica.*;
FWorld world;
color cyan   = #5CF3F7;
color blue   = #552DFA;
color pink   = #FC73FB;
color purple = #C60DFF;
color green  = #29FFAF;
color red    = color(224, 80, 61);
color orange = #FF920D;
color yellow = #FFFF50;
boolean up, down, left, right, akey, dkey, wkey, skey, leftJump, rightJump;
int lscore, rscore, player;
int mode = 1;
int timer;
PFont font;
PImage tooru, iwa, rwin, lwin, bg;
FCircle rightSlime, leftSlime, ball;
FBox lWall, rWall, lGround, rGround, net, ceiling;

void setup() {
  //make window
  fullScreen(FX2D);

  //init world
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
  font = createFont("Gameplay.ttf", 100);
  tooru = loadImage("oikawa.png");
  tooru.resize(90, 90);
  iwa = loadImage("iwa.png");
  iwa.resize(90, 90);
  rwin = loadImage("p2win.png");
  lwin = loadImage("p1win.png");
  bg = loadImage("bg.jpg");

  //add terrain to world
  leftWall();
  rightWall();
  leftGround();
  rightGround();
  net();
  ceiling();
  leftSlime();
  rightSlime();
  volleyball();
}

void draw() {
  if (mode == 1) {
    background(0);
    image(bg, 0, -70, width, height+50);
    if (wkey && leftJump) {
      leftSlime.addImpulse(0, -6000);
      leftJump = false;
    }
    if (akey) leftSlime.addImpulse(-150, 0);
    if (dkey) leftSlime.addImpulse(150, 0);
    
    if (skey) leftSlime.addImpulse(0, 1000);

    if (up && rightJump) {
      rightSlime.addImpulse(0, -6000);
      rightJump = false;
    }
    if (left) rightSlime.addImpulse(-150, 0);
    if (right) rightSlime.addImpulse(150, 0);
    
    if(down) rightSlime.addImpulse(0, 1000);
    

    //player collisions
    
    //left player
    leftJump = false;
    ArrayList<FContact> lcontacts = leftSlime.getContacts();
    for (FContact lc : lcontacts) {
      if (lc.contains(lGround)) leftJump = true;
    }
    
    if(leftSlime.getX() > width/2) {
      leftSlime.setPosition(width/2, leftSlime.getY());
      leftSlime.setVelocity(-50, leftSlime.getVelocityY());
    }

    //right player
    rightJump = false;
    ArrayList<FContact> rcontacts = rightSlime.getContacts();
    for (FContact rc : rcontacts) {
      if (rc.contains(rGround)) rightJump = true;
    }
    
    if(rightSlime.getX() < width/2) {
      rightSlime.setPosition(width/2, rightSlime.getY());
      rightSlime.setVelocity(50, rightSlime.getVelocityY());
    }

    //ball collisions
    ArrayList<FContact> bcontacts = ball.getContacts();
    for (FContact bc : bcontacts) {
      if (bc.contains(rGround)) {
        lscore++;                    
        player = 1;        
        mode = 3;
      }
      if (bc.contains(lGround)) {
        rscore++;
        player = 2;   
        mode = 2;
      }
    }
    
    if(rscore >= 1) mode = 4;
    if(lscore >= 1) mode = 5; 


    println(lscore);
    println(rscore);

    world.step();  //get box2D to calculate all the forces and new positions
    world.draw();  //ask box2D to convert this world to processing screen coordinates and draw

    textFont(font);
    textSize(100);
    fill(purple);
    text(lscore, 90, 150);
    text(rscore, width-150, 150);
  } else if (mode == 2) {
    rscore();
    timer++;
    if(timer >= 60) {
    mode = 1;
    timer = 0;
    }
  } else if (mode == 3) {
    lscore();
    timer++;
    if(timer >= 60) {
    mode = 1;
    timer = 0;
    }
  } else if (mode == 4) {
    rwin();
  } else if (mode == 5) {
    lwin();
  }
}

void rscore() {
  fill(purple);
  text("Player " + player + " Scores!", width/7, height/2);
  setup();
}

void lscore() {
  fill(purple);
  text("Player " + player + " Scores!", width/7, height/2);
  setup();  
  ball.setPosition(width/4, height-350);
}

void rwin() {
  background(green);
  image(rwin, -150, 0, 666*2.4, 375*2.4);
  fill(blue);
  text("PLAYER 2", width/1.8, height/2 + 150);
  text("WINS", width/1.8, height/2 + 270);
}

void lwin() {
  background(green);
  image(lwin, 0, 0, 666*2.4, 375*2.4);
  fill(blue);
  text("PLAYER", width/24, height/2 - 60);
  text("1 WINS", width/24, height/2 + 60);
}

void keyPressed() {
  if (keyCode == UP) up = true;
  if (keyCode == DOWN) down = true;
  if (keyCode == LEFT) left = true;
  if (keyCode == RIGHT) right = true;
  if (key == 'w' || key == 'W') wkey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 'd' || key == 'D') dkey = true;
}

void keyReleased() {
  if (keyCode == UP) up = false;
  if (keyCode == DOWN) down = false;
  if (keyCode == LEFT) left = false;
  if (keyCode == RIGHT) right = false;
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 's' || key == 'S') skey  = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 'd' || key == 'D') dkey = false;
}
