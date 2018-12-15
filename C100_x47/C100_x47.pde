void setup() {
  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);
}

void draw() {

  blendMode(BLEND);
  noStroke();
  fill(#2F1058, .2);
  rect(0, 0, width, height);
  blendMode(ADD);

  translate(width/ 2, height / 2);

  int n = 40;
  float R = width / 3;

  noFill();



  for (int j = 0; j < n; j++) {

    float r = j / (float) n * R;

    float noise = noise(j + millis() * .0005) * 1;
    
    strokeWeight(R / n * .5 * sin(millis() * .001 + j) * 2);
    strokeJoin(ROUND);
    strokeCap(ROUND);
    beginShape();

    for (float i = 0; i < TWO_PI; i += .025) {

      float a = i + millis() * .001;

      a += noise;
      
      float rr = r;

      float x = rr * sin(a);
      float y = rr * cos(a);
      
      float alpha = (i - noise) / (float) TWO_PI;
      alpha = pow(alpha, 2);
      alpha *= .25;

      stroke(70 + j * 2, 1, 1,  alpha);

      vertex(x, y);
    }

    endShape();
  }
}