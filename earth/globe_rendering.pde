class earth_render {
  float angle;

  Table table;
  

  PImage earth;
  PShape globe;

  earth_render() {
  }
  void setup() {
    earth = loadImage("earth.jpg");
    noStroke();
    globe = createShape(SPHERE, r);
    globe.setTexture(earth);
  }

  void display() {
pushMatrix();
    background(51);
    translate(width*0.5, height*0.5,-800);
    rotateY(angle);
    angle += 0.005;

    lights();
    fill(200);
    noStroke();

    shape(globe);
    popMatrix();
  }
}
