void setup() {

  size(640, 640, P3D);
  colorMode(HSB, 360, 1, 1, 1);
  rectMode(CENTER);

  //hint(ENABLE_DEPTH_SORT);
  //hint(ENABLE_DEPTH_TEST);

  background(#2F1058);
}

void draw() {

  //background(0);

  translate(width / 2, height / 2);
  lights();

  pushMatrix();
  blendMode(BLEND);
  noStroke();
  fill(#2F1058, .1);
  translate(0, 0, -1000);
  rect(0, 0, width * 4, height * 4);
  popMatrix();
  
  scale(.88);
  //rotateZ(millis() * .00025);
  rotateY(millis() * .00025);



  blendMode(ADD);

  noFill();
  stroke(255);
  strokeWeight(4);
  strokeCap(ROUND);
  strokeJoin(ROUND);

  noStroke();
  directionalLight(102, 102, 102, 0, 0, -1);
  lightSpecular(204, 204, 204);
  directionalLight(102, 102, 102, 0, 1, -1);
  lightSpecular(102, 102, 102);
  
  int n = 100;
  float r = 200;

  float f = .01;//map(mouseX, 0 , width, 0, .01);
  float g = -.01; //cos(millis() * .0001);//map(mouseY, 0 , width, 0, .001);//-.0001;
  float h = map(mouseX, 0 , width, 0, 100);

  int gap = 10;
  
  float temp = millis() * .1;

  for (float k = 0; k < 10; k += 1) {

    beginShape();

    for (float i = 0; i < n; i++) {

      //float a = (sin(i + (millis() + k * gap) * f) + 1) / 2 * TWO_PI;
      //float b = (cos(i + (millis() + k * gap) * g) + 1) / 2 * PI;
      //float c = (sin(i + (millis() + k * gap) * h) + 1) / 2f * PI;

      //float a = i;
      //float b = PI / 3; 
      
      //float a = pow(noise(i / n + temp + k * .01), 1) * TWO_PI;
      //float b = pow(noise(-i / n + temp + k * .01), 1) * PI;
      
      float a = ((i + temp - 0) / n) * TWO_PI;//random(TWO_PI);
      float b = ((i + temp + 0) / n ) * PI;//random(PI);

      float x = r * cos(a) * sin(b);
      float y = r * sin(a) * sin(b);
      float z = r * cos(b + k * .1);

      PVector v1 = new PVector(x, y, z);
      //v1.mult(i / n);
      
      PVector v2 = PVector.mult(v1, 1);
      
      float o = (sin(i / n) + 1) / 2f;

      stroke(120 + 100 * o - 15 * k, .9, 1, .25);
      vertex(v1.x, v1.y, v1.z);
      //fill(120 + 100 * o, 1, 1, .25);
      //vertex(v2.x, v2.y, v2.z);
    }

    endShape();
  }
}

class Seeker {

  PVector pos;
  PVector dir;

  Seeker() {
  }
}