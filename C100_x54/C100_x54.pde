int n = 200;
ParticleSystem ps = new ParticleSystem();
void setup() {

  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);

  for (int i = 0; i < n; i++) {

    float a = i / (float) n * TWO_PI;

    float r = 400 * noise(a);

    float x = r * sin(a);
    float y = r * cos(a);

    new Particle(ps, x, y);
  }

  for (int i = 0; i < n; i++) {

    Particle A = ps.particles.get(i % n);
    Particle B = ps.particles.get((i + 1) % n);

    new Spring(ps, A, B, 10);
  }

  for (int i = 0; i < n; i++) {

    Particle A = ps.particles.get(i);

    for (int j = i + 1; j < n; j++) {
      Particle B = ps.particles.get(j);
      new Repel(ps, A, B, 20);
    }
  }
}

void keyPressed() {

  for (int i = 0; i < n; i++) {

    float a = i / (float) n * TWO_PI;

    float r = 400 * noise(a + millis());

    float x = r * sin(a);
    float y = r * cos(a);

    Particle A = ps.particles.get(i % n);
    A.setTarget(new PVector(x, y));
  }
}

void mousePressed() {
  ps.startDragging();
}

void mouseReleased() {
  ps.stopDragging();
}

void draw() {

  //background(#2F1058);
  blendMode(BLEND);
  noStroke();
  fill(#2F1058, .1);
  rect(0, 0, width, height);
  
  blendMode(ADD);

  translate(width / 2, height / 2);

  float f = map(mouseX, 0, width, 0, 1);
  f = .33;
  float temp = millis() * .001;
  
  strokeWeight(4);

  beginShape();

  for (int i = 0; i < n + 1; i++) {

    float a = i / (float) n * TWO_PI;

    float x = sin(a);
    float y = cos(a);

    float noise = noise(x * f + temp, y * f + temp);

    float r = 400 * noise;

    x *= r;
    y *= r;

    Particle A = ps.particles.get(i % n);
    A.setTarget(new PVector(x, y));
    
    fill(map(r, 0, 200, 160, 160) - 60 * sin(millis() * .001), map(r, 0, 400, 1, 0), 1, map(r, 0, 200, .01, .1));
    vertex(A.x, A.y);
  }
  
  endShape(CLOSE);
  
  ps.update();

}