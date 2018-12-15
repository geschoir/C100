void setup() {

  size(640, 640);
  colorMode(HSB, 360, 1, 1, 1);
  hint(DISABLE_DEPTH_TEST);
}

void draw() {

  //background(#2F1058);


  blendMode(BLEND);
  fill(#2F1058, .4);
  rect(0, 0, width, height);

  blendMode(ADD);

  //fill(60, 1, .1, .75);
  //ellipse(width / 2, height / 2, 360, 360);

  translate(0, height);

  float H = 500;

  for (int k = 0; k < 2; k++) {

    for (int j = 0; j < width - 0; j+= 5) {

      beginShape(QUAD_STRIP);

      float h = H * (.0 + 1 * pow(noise(j * .05), 1));
      int n = 100;

      float t = sin(j * .01 + millis() * .001 + k) * cos(j * .025 + millis() * .00025 + k);

      noStroke();
      fill(100 + 20 * sin(millis() * .001) + j * .05, .6 + .4 * map(h, 0, H, 0, 1), .2 + .8 * map(h, 0, H, 0, 1) - k * .4, .25);

      float x = 0;
      float y = 0;

      for (int i = 0; i < n; i += 5) {

        float f = (i / (float) n);

        x = j + pow(i * .1, 2) * t * h / (float) H;
        y = - f * h;

        vertex(x - (1 - f) * 5, y);
        vertex(x + (1 - f) * 5, y);
      }

      endShape();

      //if(j % 50 == 0) {

      //  noFill();
      //  stroke(180, 1, 1);
      //  ellipse(x, y, 6, 6);

      //}
    }
  }
}
