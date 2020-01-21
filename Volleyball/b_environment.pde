void leftWall() {
  lWall = new FBox(100, height*2);
  lWall.setPosition(-50, 0);

  //set visuals
  lWall.setNoStroke();
  lWall.setFillColor(green);

  //set physical properties
  lWall.setStatic(true);
  lWall.setDensity(0.2);
  lWall.setFriction(1);
  lWall.setRestitution(0.25);
  lWall.setGrabbable(false);
  world.add(lWall);
}

void rightWall() {
  rWall = new FBox(100, height*2);
  rWall.setPosition(width+50, 0);

  //set visuals
  rWall.setNoStroke();
  rWall.setFillColor(green);

  //set physical properties
  rWall.setStatic(true);
  rWall.setDensity(0.2);
  rWall.setFriction(1);
  rWall.setRestitution(0.25);
  rWall.setGrabbable(false);
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
  lGround.setGrabbable(false);
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
  rGround.setGrabbable(false);
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
  net.setGrabbable(false);
  world.add(net);
}

void ceiling() {
 ceiling = new FBox(width, 100);
 ceiling.setPosition(width/2, -50);
 
   //set visuals
  ceiling.setNoStroke();
  ceiling.setFillColor(green);

  //set physical properties
  ceiling.setStatic(true);
  ceiling.setDensity(0.2);
  ceiling.setFriction(1);
  ceiling.setRestitution(0.25);
  ceiling.setGrabbable(false);
  world.add(ceiling);
}
