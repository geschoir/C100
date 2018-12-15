class ParticleSystem {

  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<Spring> springs = new ArrayList<Spring>();
  ArrayList<Repel> repels = new ArrayList<Repel>();

  ParticleSystem() {
  }

  void addParticle(Particle p) {
    particles.add(p);
  }

  void addSpring(Spring s) {
    springs.add(s);
  }

  void addRepel(Repel r) {
    repels.add(r);
  }

  void startDragging() {
    Particle p = getParticle(mouseX - width / 2, mouseY - height / 2);
    if (p != null)
      p.startDragging();
  }

  void stopDragging() {
    for (Particle p : particles)
      p.stopDragging();
  }

  Particle getParticle(int index) {
    return particles.get(index);
  }

  Particle getParticle(float x, float y) {
    for (Particle p : particles) {
      if (p.hitTest(mouseX - width / 2, mouseY - height / 2))
        return p;
    }
    return null;
  }

  void drawParticles() {
    for (Particle p : particles)
      p.draw();
  }

  void drawSprings() {
    for (Spring s : springs)
      s.draw();
  }

  void drawRepels() {
    for (Repel r : repels)
      r.draw();
  }

  void update() {

    for (Repel r : repels)
      r.update();

    for (Spring s : springs)
      s.update();

    for (Particle p : particles)
      p.update();
  }
}

class Particle extends PVector {

  float r = 10;
  
  PVector target;
  ArrayList<PVector> forces = new ArrayList<PVector>();

  boolean dragging = false;

  Particle(ParticleSystem ps) {
    this(ps, 0, 0, 5);
  }

  Particle(ParticleSystem ps, float x, float y) {
    this(ps, x, y, 5);
  }

  Particle(ParticleSystem ps, float x, float y, float r) {
    super(x, y);
    target = new PVector(x, y);
    this.r = r;
    ps.addParticle(this);
  }

  void update() {

    //PVector target = new PVector(x, y);

    if (dragging) {
      target = new PVector(mouseX - width / 2, mouseY - height / 2);
    } else {
      PVector sumForces = new PVector();
      for (PVector force : forces)
        sumForces.add(force);
      sumForces.div(forces.size());
      target.add(sumForces);
    }

    x = PApplet.lerp(x, target.x, .1);
    y = PApplet.lerp(y, target.y, .1);

    forces = new ArrayList<PVector>();
  }
  
  void setTarget(PVector target) {
    this.target = target;
  }

  void addForce(PVector force) {
    forces.add(force);
  }

  void startDragging() {
    dragging = true;
  }

  void stopDragging() {
    dragging = false;
  }

  boolean hitTest(float x, float y) {
    return (abs(this.x - x) < r && abs(this.y - y) < r);
  }

  void draw() {
    ellipse(x, y, r * 2, r * 2);
  }
}

class Repel {

  Particle A, B;

  float minimumDistance = 40;
  float currentDistance;

  Repel(ParticleSystem ps, Particle A, Particle B, float minimumDistance) {
    this.A = A;
    this.B = B;
    this.minimumDistance = minimumDistance;
    if (A != B)
      ps.addRepel(this);
  }

  void update() {

    PVector diff = PVector.sub(B, A);
    currentDistance = diff.mag();

    if (currentDistance < minimumDistance) {

      diff.normalize();
      diff.mult((currentDistance - minimumDistance) * .5);

      A.addForce(diff);
      B.addForce(PVector.mult(diff, -1));
    }
  }

  void draw() {

    if (currentDistance < minimumDistance) {
      line(A.x, A.y, B.x, B.y);
    }
  }
}

class Spring {

  Particle A, B;

  float maximumDistance = 20;
  float currentDistance;

  Spring(ParticleSystem ps, Particle A, Particle B, float maximumDistance) {
    this.A = A;
    this.B = B;
    this.maximumDistance = maximumDistance;
    if (A != B)
      ps.addSpring(this);
  }

  void update() {

    PVector diff = PVector.sub(B, A);
    currentDistance = diff.mag();

    if (currentDistance > maximumDistance) {

      diff.normalize();
      diff.mult((currentDistance - maximumDistance) * .5);

      A.addForce(diff);
      B.addForce(PVector.mult(diff, -1));
    }
  }

  void draw() {

    //if (currentDistance > maximumDistance) {
      line(A.x, A.y, B.x, B.y);
    //}
  }
}