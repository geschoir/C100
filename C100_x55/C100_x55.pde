int n = 20;
ParticleSystem ps = new ParticleSystem();
void setup() {

  size(640, 640);
  colorMode(HSB, 360, 1, 1, 1);
  //hint(ENABLE_DEPTH_SORT);
  //hint(ENABLE_DEPTH_TEST);
  strokeCap(ROUND);
  strokeJoin(ROUND);


  for (int i = 0; i < n; i++) {

    float x = random(-100, 100);
    float y = random(-100, 100);

    new Particle(ps, x, y);
  }

  for (int i = 0; i < n; i++) {

    Particle A = ps.particles.get(i % n);
    Particle B = ps.particles.get((i + 1) % n);

    new Spring(ps, A, B, 40);
  }

  for (int i = 0; i < n; i++) {

    Particle A = ps.particles.get(i);

    for (int j = i + 1; j < n; j++) {
      Particle B = ps.particles.get(j);
      new Repel(ps, A, B, 80);
    }
  }
}

void keyPressed() {

  reset();
}

void reset() {
  for (int i = 0; i < n; i++) {

    float x = random(-width / 1.5, width / 1.5);
    float y = random(-height / 1.5, height / 1.5);

    ps.getParticle(i).setTarget(new PVector(x, y));
  }
}

void mousePressed() {
  ps.startDragging();
}

void mouseReleased() {
  ps.stopDragging();
}

void draw() {

  if (frameCount % 120 == 0)
    reset();

  ps.update();

  //background(#2F1058);

  blendMode(BLEND);
  noStroke();
  fill(#2F1058, .1);
  rect(0, 0, width, height);

  blendMode(ADD);

  translate(width / 2, height / 2);

  strokeWeight(20);

  stroke(0, 0, 1);
  fill(0, .2, 1, .5);

  //noStroke();
  noFill();


  beginShape();

  for (int i = 0; i < n + 3; i++) {

    Particle p = ps.getParticle(i % n);
    stroke(180, .4, 1, .1 + .1 * (1 - abs(((i % n) / (float) n) * 2 - 1)));
    curveVertex(p.x, p.y);
  }

  endShape(CLOSE);



  //ps.drawSprings();
}