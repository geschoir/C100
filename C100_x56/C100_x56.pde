int n = 160;

void setup() {

  size(640, 640, P3D);
  rectMode(CENTER);
  colorMode(HSB, 360, 1, 1, 1);

  background(#2F1058);
}

void draw() {

  

  translate(width / 2, height / 3.33);
  
  pushMatrix();
  translate(0, 0, -500);
  blendMode(BLEND);
  noStroke();
  fill(#2F1058, 1);
  rect(0, 0, width * 3, height * 2.5);
  popMatrix();

  blendMode(ADD);
  
  rotateX(PI * .33);
  //rotateX(map(mouseY, 0, height, -PI, PI));

  for (int i = 0; i < n; i++) {
    float a = 500;
    float f = i / (float) n;

    pushMatrix();
    translate(0, 0, -i * 2);
    rotateZ(map(noise(i * .005 - millis() * .00025), 0, 1, -PI, PI));

    fill(120 + i, .3, 1, (1 - f));
    noStroke();

    ellipse(0, 0, a / 2, a);

    popMatrix();
  }
}