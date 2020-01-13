import fisica.*;
FWorld world;
color blue   = #5CF3F7;
color pink   = #FC73FB;
color purple = #C60DFF;
color green  = #29FFAF;
color red    = color(224, 80, 61);
color orange = #FF920D;
color yellow = #FFFF50;
boolean up, down, left, right, akey, dkey, wkey, skey, leftJump, rightJump;
int lscore, rscore;
FCircle rightSlime, leftSlime, ball;
FBox lWall, rWall, lGround, rGround, net;

void setup() {
  //make window
  fullScreen(FX2D);

  //init world
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);

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
      setup();
      ball.setPosition(width/4, height-350);
    }
    if (bc.contains(lGround)) {
      rscore++;
      setup();
    }
  }

  println(lscore);
  println(rscore);

  world.step();  //get box2D to calculate all the forces and new positions
  world.draw();  //ask box2D to convert this world to processing screen coordinates and draw
}

void leftWall() {
  lWall = new FBox(100, height);
  lWall.setPosition(-50, height/2);

  //set visuals
  lWall.setNoStroke();
  lWall.setFillColor(green);

  //set physical properties
  lWall.setStatic(true);
  lWall.setDensity(0.2);
  lWall.setFriction(1);
  lWall.setRestitution(0.25);
  world.add(lWall);
}

void rightWall() {
  rWall = new FBox(100, height);
  rWall.setPosition(width+50, height/2);

  //set visuals
  rWall.setNoStroke();
  rWall.setFillColor(green);

  //set physical properties
  rWall.setStatic(true);
  rWall.setDensity(0.2);
  rWall.setFriction(1);
  rWall.setRestitution(0.25);
  world.add(rWall);
}

void leftGround() {
  lGround = new FBox(width/2, 100);
  lGround.setPosition(width/4, height-50);

  //set visuals
  lGround.setNoStroke();
  lGround.setFillColor(green);

  //set physical properties
  lGround.setStatic(true);
  lGround.setDensity(0.2);
  lGround.setFriction(0);
  lGround.setRestitution(0.25);
  world.add(lGround);
}

void rightGround() {
  rGround = new FBox(width/2, 100);
  rGround.setPosition(width-width/4, height-50);

  //set visuals
  rGround.setNoStroke();
  rGround.setFillColor(green);

  //set physical properties
  rGround.setStatic(true);
  rGround.setDensity(0.2);
  rGround.setFriction(0);
  rGround.setRestitution(0.25);
  world.add(rGround);
}

void net() {
  net = new FBox(20, 100);
  net.setPosition(width/2, height-150);

  //set visuals
  net.setNoStroke();
  net.setFillColor(pink);

  //set physical properties
  net.setStatic(true);
  net.setDensity(0.2);
  net.setFriction(1);
  net.setRestitution(0.25);
  world.add(net);
}

void leftSlime() {
  leftSlime = new FCircle(100);
  leftSlime.setPosition(width/4, height-250);

  //set visuals
  leftSlime.setNoStroke();
  colorMode(HSB);
  leftSlime.setFillColor(color(random(0, 255), 120, 240));
  colorMode(RGB);

  //set physical properties
  leftSlime.setStatic(false);
  //leftSlime.setDensity(0.2);
  //leftSlime.setFriction(1);
  leftSlime.setRestitution(.1);

  //add to world
  world.add(leftSlime);
}

void rightSlime() {
  rightSlime = new FCircle(100);
  rightSlime.setPosition(width - width/4, height-250);

  //set visuals
  rightSlime.setNoStroke();
  colorMode(HSB);
  rightSlime.setFillColor(color(random(0, 255), 120, 240));
  colorMode(RGB);

  //set physical properties
  rightSlime.setStatic(false);
  //rightSlime.setDensity(0.2);
  //rightSlime.setFriction(1);
  rightSlime.setRestitution(.1);

  //add to world
  world.add(rightSlime);
}

void volleyball() {
  ball = new FCircle(40);
  ball.setPosition(width - width/4, height-350);

  //visuals
  ball.setNoStroke();
  colorMode(HSB);
  ball.setFillColor(color(random(0, 255), 120, 240));
  colorMode(RGB);

  //physical properties
  ball.setRestitution(.9);

  //add
  world.add(ball);
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
