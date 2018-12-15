float n = 12;
float nt = 12;

void setup() {

  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);
}

void draw() {

  //if(frameCount % 60 == 0)
  //  nt = (int) random(3, 12);

  background(#2F1058);
  blendMode(ADD);

  translate(width / 2, height / 2);

  float r = map(mouseX, 0, width, 0, width);
  r = width / 3f;

  //float n = (int) map(mouseY, 0, height, 2, 16);
  n = lerp(n, nt, .01);

  beginShape(QUAD_STRIP);

  for (int i = 0; i < n; i++) {

    float rad = millis() * .001 * (sin(i) + 1);

    float x = r * sin(rad);
    float y = r * cos(rad);

    PVector v = new PVector(x, y);  
    //v = v.mult((10 - i) / (float) n);

    fill(0 + i * 10, 1, 1, 0);
    vertex(0, 0);
    fill(0 + i * 10, 1, 1, .5);
    vertex(v.x, v.y);
  }

  endShape(CLOSE);
}