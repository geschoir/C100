float f = .001;
float _f = .001;

void setup() {

  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);
  ellipseMode(CORNER);
  //rectMode(CENTER);
}

void draw() {

  background(#2F1058);

  //translate(width / 2 , height / 2);
  //rotate(millis() * .00025);
  //translate(-width / 2 , -height / 2);

  blendMode(ADD);

  int a = 160; // 80//160

  int padding = 40; // 80 //40
  int gap = 2;
  int n = (width - padding * 2 - a) / gap;

  float tmp = millis() * .0001;

  f = map(mouseX, 0, width, 0, .005); 
  f = .0005;
  
  //if(frameCount % 120 == 0) {
  //  _f += .001;
  //  if(_f > .005)
  //    _f = .001;
  //}
  
  //f = lerp(f, _f, .025);
  

  for (int i = 0; i < n; i++) {

    float x = padding + i * gap + a / 2;
    float y = height - padding - a - i * gap + a / 2;
    
    float g = 1;
    //g = 1 - .75 * ((sin(i / (float) n * PI) + 1) / 2);
    
    float rad = map(noise(x * f + tmp, y * f + tmp), 0, 1, -TWO_PI * 2, TWO_PI * 2);

    pushMatrix();
    translate(x, y);
    rotate(rad);

    noStroke();

    float hue = 0;
    hue += 240 * ((sin(i / (float) n + millis() * .001) + 1) / 2);

    //hue = (160 + 80 * i / (float) n + millis() * .1) % 360;

    fill(hue, .9, 1, .1);

    ellipse(0, 0, a * g, a * g);
    //triangle(-a / 2, 0, a / 2, 0, 0, a * .75);

    popMatrix();
  }
}