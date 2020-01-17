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
FCircle rightSlime, leftSlime, ball;
FBox lWall, rWall, lGround, rGround, net;

void setup() {
  //make window
  fullScreen(FX2D);

  //init world
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
  font = createFont("Gameplay.ttf", 100);

  //add terrain to world
  leftWall();
  rightWall();
  leftGround();
  rightGround();
  net();
  leftSlime();
  rightSlime();
  volleyball();
}

void draw() {
  if (mode == 1) {
    background(0);
    if (wkey && leftJump) {
      leftSlime.addImpulse(0, -5000);
      leftJump = false;
    }
    if (akey) leftSlime.addImpulse(-150, 0);
    if (dkey) leftSlime.addImpulse(150, 0);

    if (up && rightJump) {
      rightSlime.addImpulse(0, -5000);
      rightJump = false;
    }
    if (left) rightSlime.addImpulse(-150, 0);
    if (right) rightSlime.addImpulse(150, 0);

    //player collisions
    leftJump = false;
    ArrayList<FContact> lcontacts = leftSlime.getContacts();
    for (FContact lc : lcontacts) {
      if (lc.contains(lGround)) leftJump = true;
    }

    rightJump = false;
    ArrayList<FContact> rcontacts = rightSlime.getContacts();
    for (FContact rc : rcontacts) {
      if (rc.contains(rGround)) rightJump = true;
    }

    //ball collisions
    ArrayList<FContact> bcontacts = ball.getContacts();
    for (FContact bc : bcontacts) {
      if (bc.contains(rGround)) {
        lscore++;      
        ball.setPosition(width/4, height-350);
        player = 1;
        mode = 2;
      }
      if (bc.contains(lGround)) {
        rscore++;
        player = 2;
        mode = 2;
      }
    }

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
    score();
    timer++;
    if(timer >= 60) {
    mode = 1;
    timer = 0;
    }
  }
}

void score() {
  fill(purple);
  text("Player " + player + " Scores!", width/7, height/2);
  setup();
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
