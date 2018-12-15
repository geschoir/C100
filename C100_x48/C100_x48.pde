ArrayList<Seeker> seekers = new ArrayList<Seeker>();
int n = 2000;

int offset = 0;

void setup() {
  size(640, 640);
  colorMode(HSB, 360, 1, 1, 1);



  reset();
}

void draw() {

  if (frameCount % 640 == 0)
    reset();

  blendMode(BLEND);
  fill(#2F1058, .01);

  translate(width / 2, height / 2);

  blendMode(ADD);

  for (Seeker seeker : seekers) {
    seeker.draw();
  }
}

void keyPressed() {
  reset();
}

void reset() {
  offset = (int) random(1024);
  background(#2F1058);
  seekers = new ArrayList<Seeker>();
  for (int i = 0; i < n; i++)
    seekers.add(new Seeker());
}

class Seeker {

  PVector pos;
  PVector target;
  PVector head;

  float f;
  float acc = 1;

  Seeker() {
    reset();
  }

  void reset() {
    float a = random(-PI, PI);
    float r = random(0, width);
    float x = 0 + r * sin(a);
    float y = 0 + r * cos(a);

    pos = new PVector(x, y);
    target = PVector.random2D();
    head = PVector.random2D();

    f = random(.001, .001);
    acc = random(1, 1);
  }

  void draw() {

    //float f = map(mouseX, 0, width, 0, .1);
    float rad = noise((pos.x * f + offset), (pos.y * f + offset), 0);
    rad = map(rad, 0, 1, -TWO_PI, TWO_PI);
    //rad *= .1;

    target = new PVector(1, 0);
    target.rotate(rad);

    head = PVector.lerp(head, target, .1);
    head.normalize();
    head.mult(acc);

    pos.add(head);

    if (pos.x < -width / 2 || pos.x > width / 2 || pos.y < -height / 2 || pos.y > height / 2)
      reset();

    pushMatrix();
    translate(pos.x, pos.y);

    fill(map(abs(head.heading()), 0, PI, 120, 180), .8, .025);
    noStroke();

    ellipse(0, 0, 2, 2);
    popMatrix();
  }
}