int n = 40;
int padding = 100;

ArrayList<Stringy> stringies = new ArrayList<Stringy>();

void setup() {

  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);

  for (int i = 0; i < n; i++) {
    float x = 0;
    float y = (i - (n - 1) / 2f) * (width - padding * 2) / n;
    float z = 0;//(i - (n - 1) / 2f) * 20;
    stringies.add(new Stringy(x, y, z));
  }
}

void pick() {
  for (Stringy stringy : stringies) {
    float rand = random(1);
    if (rand < .5)
      stringy.pick();
  }
}

void keyPressed() {
  for (Stringy stringy : stringies) {
    stringy.pick();
  }
}

void draw() {

  //if (frameCount % 10 == 0)
  //  pick();

  blendMode(BLEND);
  background(#2F1058);
  //blendMode(ADD);

  //rotateX(map(mouseY, 0, height, -PI, PI));

  int k = 0;
  for (Stringy stringy : stringies) {
    if ((frameCount / 8) % (n) == k)
      stringy.pick();
    stringy.draw(k++);
  }
}

class Stringy {

  float amp = 0;
  float frq = 0;
  float tmp = 0;
  float fac = 0;

  float x, y, z;

  Stringy(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void pick() {
    fac = 1;
    amp = 100;//random(30, 200);
    frq = .025; //random(.01, .1);//map(mouseX, 0, width, .01, 2);//random(TWO_PI / 250f); //TWO_PI / 100f;
    tmp = random(.001, .01);//.005;//random(0, .01); //TWO_PI / 100f;
  }

  void draw(int k) {

    pushMatrix();
    translate(x, y, z);

    noFill();
    strokeWeight(3);
    //fill(180 + k * 3, .25, 1, .1);
    stroke(180 + k * 3, .5, 1, map(amp, 30, 200, 0, 1));
    //stroke(180 + k * 3, .5, 1, k / (float) n);
    //noStroke();

    beginShape();

    fac = lerp(fac, 0, .01);
    amp = lerp(amp, 0, .01);
    frq = lerp(frq, 0, .01);

    int  a = width - 2 * padding;

    for (int i = 0; i <  a; i++) {

      float x = padding + i;
      float y = 0;



      // normal sine wave
      y += sin(i * frq);
      // reverse it for soft endings
      y *= sin((a - i) * frq);
      // give it some height
      y *= amp;
      // make it move
      y *= sin(millis() * tmp);
      // this is just effect
      y *= sin(i / (float) a * PI * 13f);
      // make it more extrem in the center
      y *= sin(k / (float) n * PI / 2f); 
      // what ever
      y *= sin(fac * PI);


      // fill(240 - k * 3, .75, 1, map(abs(y), 0, amp, 0, 1));
      //stroke(240 - k * 3, .75, 1, map(abs(y), 0, amp, 0, 1));
      stroke(240 - k * 3, .6, 1, 1);
      //stroke(240 - k * 3, .75, 1, 1);

      // translate it to the center
      y += height / 2;


      vertex(x, y);
      //vertex(x, height);
    }

    //vertex(width, width);
    //vertex(0, width);

    endShape();

    popMatrix();
  }
}