int n = 100;
ArrayList<Ball> balls = new ArrayList<Ball>();

PGraphics metaTexture;
PShader metaballs;

int padding = 100;
int R = 240;

class Ball extends PVector {

  float r;
  PVector head;
  
  Ball(float x, float y, float r) {
    super(x, y);
    this.r = r;
    head = PVector.random2D();
    head.mult(1);

  }

  void update() {

    add(head);
    
    if(PApplet.dist(x, y, width / 2, height / 2) > R) {
      head = PVector.sub(this, new PVector(width / 2, height / 2));
      head.normalize();
      head.rotate(random(- HALF_PI, HALF_PI));
      head.mult(-1);
    }
  }

  void draw() {
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(x, y, r * 2, r * 2);
  }
}


void setup() {

  size(640, 640, P2D);
  colorMode(HSB, 360, 1, 1, 1);
  imageMode(CENTER);
  reset();

  metaTexture = createGraphics(width, height, P2D);

  metaballs = loadShader("metaballs-2.glsl");
  
  background(#2F1058);
}

void keyPressed() {
  reset();
}

void reset() {

  balls = new ArrayList<Ball>(0);

  for (int i = 0; i < n; i++) {
    float a = random(TWO_PI);
    float r = random(10, 10);

    float x = width / 2 + r * sin(a);
    float y = height / 2 + r * cos(a);
    float d = 400; //random(40, 120);
    balls.add(new Ball(x, y, d / 2));
  }
}

void draw() {

  //println(frameRate);

  float[] ballArray = new float[balls.size() * 3];

  for (int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    ball.update(); 
    
    int base = i * 3;

    ballArray[base + 0] = ball.x / (float) width;
    ballArray[base + 1] = ball.y / (float) height;
    ballArray[base + 2] = ball.r / (float) width;

    metaballs.set("balls", ballArray);
  }
  
  float lowPass = map(mouseX, 0, width, 0, 200);
  //println(lowPass);
  lowPass = 100 + 20 * (sin(millis() * .001) + 1) / 2;
  
  float highPass = lowPass * 1.5;
  
  metaballs.set("LOW_PASS", lowPass);
  metaballs.set("HIGH_PASS", highPass);
  //println(ballArray.length);

  blendMode(BLEND);
  fill(#2F1058, .5);
  noStroke();
  rect(0, 0, width, height);
  
  blendMode(ADD);
  shader(metaballs);
  
  
  //tint(0, 0, 1, .01);
  translate(width / 2, height / 2);
  //rotate(millis() * .00025);
  image(metaTexture, 0, 0);

  //for (Ball ball : balls) 
  //  ball.draw();
}
