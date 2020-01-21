void leftSlime() {
  leftSlime = new FCircle(100);
  leftSlime.setPosition(width/4, height-250);

  //set visuals
  leftSlime.attachImage(iwa);
  //leftSlime.setNoStroke();
  //colorMode(HSB);
  //leftSlime.setFillColor(color(random(0, 255), 120, 240));
  //colorMode(RGB);

  //set physical properties
  leftSlime.setStatic(false);
  leftSlime.setDensity(1);
  leftSlime.setFriction(0);
  leftSlime.setRestitution(0);

  //add to world
  world.add(leftSlime);
}

void rightSlime() {
  rightSlime = new FCircle(100);
  rightSlime.setPosition(width - width/4, height-250);

  //set visuals
  rightSlime.attachImage(tooru);
  //rightSlime.setNoStroke();
  //colorMode(HSB);
  //rightSlime.setFillColor(color(random(0, 255), 120, 240));
  //colorMode(RGB);

  //set physical properties
  rightSlime.setStatic(false);
  rightSlime.setDensity(1);
  rightSlime.setFriction(0);
  rightSlime.setRestitution(0);

  //add to world
  world.add(rightSlime);
}

void volleyball() {
  ball = new FCircle(40);
  ball.setPosition(width - width/4, height-350);

  //visuals
  ball.setNoStroke();
  colorMode(HSB);
  ball.setFillColor(color(random(0, 255), 190, 240));
  colorMode(RGB);

  //physical properties
  ball.setRestitution(.9);

  //add
  world.add(ball);
}
