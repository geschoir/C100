ArrayList<Seeker> seekers = new ArrayList<Seeker>();
int n = 2500;

int offset = 0;

void setup() {
  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);

  background(#2F1058);

  reset();
}

void draw() {

  if (frameCount % 120 == 0)
    reset();

  //blendMode(BLEND);
  //noStroke();
  //fill(#2F1058, .1);
  //rect(0, 0, width, height);

  translate(width / 2, height / 2);

  //blendMode(ADD);

  
  float min = map(mouseX, 0, width, 0, 100);
  float max = map(mouseY, 0, height, 0, 1000);
  
  min = 1.25;
  max = 40;
  
  //println(min, max);

  for (int i = 0; i < seekers.size() - 1; i++) {

    Seeker A = seekers.get(i);
    Seeker B = seekers.get(i + 1);
    
    for(int k = 0; k < 1; k++) 
      A.update();

    for (int j = i; j < seekers.size(); j++) {

      Seeker C = seekers.get(j);

      if (A != C && A.distance(C) < A.distance(B) && A.distance(C) > min) {
        B = C;
      }
    }

    if (A.distance(B) < max && A.distance(B) > min) {
      strokeWeight(2);
      stroke(20 + abs(sin(millis() * .0001)) * 30, .4 + .2 * abs(sin(i * .01)), 1, map(A.distance(B), min, max, .1, 0));
      line(A.pos.x, A.pos.y, B.pos.x, B.pos.y);
    }
  }

  //endShape();
}

void keyPressed() {
  reset();
}

void reset() {
  offset = (int) random(1024);
  background(#2F1058);
  seekers = new ArrayList<Seeker>(0);
  for (int i = 0; i < n; i++)
    seekers.add(new Seeker());
}

class Seeker {

  PVector pos;
  PVector target;
  PVector head;

  float f;

  Seeker() {
    reset();
  }

  void reset() {
    float a = random(-PI, PI);
    float r = random(10, width / 4);
    float x = 0 + r * sin(a);
    float y = 0 + r * cos(a);
    
    //x = random(-width / 2, width / 2);
    //y = random(-width / 2, width / 2);

    pos = new PVector(x, y);
    target = PVector.random2D();
    head = PVector.random2D();

    f = .005; // .01
  }

  float distance(Seeker s) {
    return dist(pos.x, pos.y, s.pos.x, s.pos.y);
  }

  void update() {

    float rad = noise((pos.x * f + offset), (pos.y * f + offset), millis() * .0001);
    rad = map(rad, 0, 1, -TWO_PI, TWO_PI);

    target = new PVector(1, 0);
    target.rotate(rad);

    head = PVector.lerp(head, target, 1);
    head.normalize();
    head.mult(1);

    pos.add(head);

    if (pos.x < -width / 2)
      pos.x = width / 2 - 1;
    else if (pos.x > width / 2)
      pos.x = - width / 2 + 1;

    if (pos.y < -height / 2)
      pos.y = height / 2 - 1;
    else if (pos.y > height / 2)
      pos.y = - height / 2 + 1;
  }
}