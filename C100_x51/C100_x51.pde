ArrayList<Seeker> seekers = new ArrayList<Seeker>();
int n = 1000;

void setup() {

  size(640, 640, P3D);
  rectMode(CENTER);
  colorMode(HSB, 360, 1, 1, 1);

  for (int i = 0; i < n; i++)
    seekers.add(new Seeker());

  background(#2F1058);
}

void draw() {

 // background(#2F1058);
  
  pushMatrix();
  blendMode(BLEND);
  translate(width / 2, height / 2, -1000);
  
  fill(#2F1058, 1);
  rect(0, 0, width * 3, height * 3);
  
  popMatrix();

  translate(width / 2, height / 2);
  
  //rotateY(millis() * .001);

  blendMode(ADD);
  noFill();

  int i = 0;
  for (Seeker seeker : seekers) {
    
    strokeWeight(2);
    //noStroke();
    stroke(120 + 80 * i / (float) n, 1, 1, map(seeker.x, -200, 200, .75, .25));

    seeker.update();
    seeker.draw();

    i += 1;
  }
}



class Seeker {

  float a, b;
  float r = 200;
  
  float x, y, z;

  Seeker() {

    a = random(TWO_PI);
    b = random(PI);
  }

  void update() {

    float f = .001; //.00025; 
    float fB = -.001; //.00025; 
    float temp = millis() * .0001; // .001

    x = r * cos(a) * sin(b);
    y = r * sin(a) * sin(b);
    z = r * cos(b);

    float radA = noise(x * f + temp, y * f + temp, z * f + temp);
    radA = map(radA, 0, 1, -PI, PI);
    radA *= .005;
    
    float radB = noise(x * fB + temp, y * fB + temp, z * fB + temp);
    radB = map(radB, 0, 1, -PI, PI);
    radB *= .005;

    a += radA;
    b += radB;
  }

  void draw() {

    pushMatrix();
    rotateX(a);
    rotateY(b);
    translate(r, 0, 0);

    rotateY(-b);
    rotateX(-a);

    ellipse(0, 0, 20, 20);

    popMatrix();
  }
}