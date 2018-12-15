void setup() {

  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);
  sphereDetail(30);
  background(#2F1058);
}

void draw() {

  //background(#2F1058);
  hint(DISABLE_DEPTH_TEST);
  blendMode(BLEND);
  fill(#2F1058, 1);
  rect(0, 0, width, height);
  hint(ENABLE_DEPTH_TEST);
  
  //lights();

  ambientLight(0, 0, .9);
  lightSpecular(0, .25, .5);
  directionalLight(0, 1, .2, 0, -.75, -1);
  //specular(20, 1, 1);
  //shininess(30.0);
  //emissive(40, 1, .25);

  noStroke();
  noFill();
  strokeWeight(2);

  translate(width / 2, height / 2);
  //rotateX(PI / 6f);

  //blendMode(ADD);

  float R = 30;

  //ellipse(0, 0, R, R);

  for (int j = 0; j <= 5; j++) {

    int n = 1 + 6 * j;
    float r = R * j;

    for (int i = 0; i < n; i++) {

      float a = i / (float) n * TWO_PI;

      float x = r * sin(a);
      float y = r * cos(a);

      float nse = noise((x + width / 2) * .005 + millis() * .00025, (y + height / 2) * .005 + millis() * .0005);
      nse = pow(nse, 2);

      float hue = 180 + nse * 100;
      float brg = 1;


      fill(hue, .5, brg, 1);
      //fill(0, 0, 1);

      pushMatrix();
      translate(x, y, 0);
      sphere(160 * nse);
      popMatrix();
    }
  }
}
