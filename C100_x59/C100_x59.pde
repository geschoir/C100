void setup() {

  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);
  strokeWeight(10);
  strokeCap(ROUND);
  strokeJoin(ROUND);
}

void draw() {

  float r = 200;

  blendMode(BLEND);
  noStroke();
  fill(#2F1058, .2);
  rect(0, 0, width, height);
  
  blendMode(ADD);

  translate(width / 2, height / 2);

  noFill();
  

  //ellipse(0, 0, r * 2, r * 2);
  
  //fill(0, 1, 1, .2);
  
  int n = (int) (320 - 120 * sin(millis() * .001));
  
  float g = .33;

  for (int i = 0; i < n; i++) {

    float a0 = i * .01 - millis() * .002; //* (i + 1) ;
    float a1 = i * .02 + millis() * .001;// * (i + 1)
    
    //a0 = map(noise(i * .005, millis() * .00025 - i * 1), 0, 1, -TWO_PI, TWO_PI);
    //a1 = map(noise(i * .005, millis() * .00025 + i * 1), 0, 1, -TWO_PI, TWO_PI);
    
    float x0 = r * sin(a0);
    float y0 = r * cos(a0);

    float x1 = r * sin(a1);
    float y1 = r * cos(a1);

    PVector v0 = new PVector(x0, y0);
    PVector v1 = new PVector(x1, y1);

    PVector cp0 = PVector.mult(v0, g);
    PVector cp1 = PVector.mult(v1, g);
    
    float hue = 200 + 60 * (1 - abs((i / (float) n) * 2 - 1));
    
    fill(hue, .9, 1, .01);
    //stroke(hue, .9, 1, .025);
    bezier(v0.x, v0.y, cp0.x, cp0.y, cp1.x, cp1.y, v1.x, v1.y);
    
  }
}
