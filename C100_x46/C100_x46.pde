int depth = 5;
int n = 4;

float anm = 0;
float anmt = 0;

int count = 0;
ArrayList<Float> pos = new ArrayList<Float>();

void setup() {

  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);
  
  pos.add(0.0);
  pos.add(0.5);
  pos.add(1.04);
  //pos.add(1.62);
  pos.add(2.09);
  //pos.add(2.59);
  //pos.add(PI);
  pos.add(3.66);
  //pos.add(4.74);
  //pos.add(TWO_PI);
  
}

void draw() {

  if (frameCount % 240 == 0) {
    //anmt += TWO_PI / 3;
    count++;
    anmt = pos.get(count % pos.size());
    //if(count % 2 == 0)
    //  anmt = 0;
    
    //anmt += TWO_PI;
    //anmt += random(PI, TWO_PI);
    //anmt %= TWO_PI;
  }

  anm = lerp(anm, anmt, .025);
  //anm = map(mouseX, 0, width, 0, TWO_PI);
  //println(anm);
  //anm += TWO_PI * .001;
  
  //anm = sin((millis() * .01 + 1) / 2);

  blendMode(BLEND);
  fill(#2F1058, .1);
  rect(0, 0, width, height);

  blendMode(ADD);

  translate(width / 2, height / 2);

  noFill();
  //stroke(255);

  for (int i = 0; i < 3; i++) {

    noStroke();
    noFill();
    fill(i * 120, .8, 1, .1);
    translate(i * 5, i * 5);

    drawCircle(0, 0, 0, width / 2.5);
  }
}

void drawCircle(int k, float x, float y, float d) {

  if ( k == depth)
  //if ( k > 0)
    ellipse(x, y, d * .66, d * .66);

  if (k < depth) {
    
    int n = 4;

    for (int i = 0; i < n; i++) {

      //float rad = i / (float) n * TWO_PI;// + (i * millis() *.001);
      float rad = i / (float) n * TWO_PI + ((0 * 1 + i + 0) * anm) + PI / 4;

      float xr = x + d / 2f * sin(rad);
      float yr = y + d / 2f * cos(rad);

      float dr = d * .5;

      int kr = k +1;

      drawCircle(kr, xr, yr, dr);
    }
  }
}