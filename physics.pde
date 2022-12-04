private ArrayList<Body> bodies;

public void setup() {
  frameRate(30);
  size(512, 512);
  this.bodies = new ArrayList<Body>();
  this.bodies.add(new Floor());
  this.bodies.add(new Line(0, height/2, width/2, 2*height/3));
  this.bodies.add(new Line(width/2 + 20, height - 20, width, height/2));
  this.bodies.add(new Line(20, height - 100, 30, height));
  this.bodies.add(new PointMass(width/3, height/3 + 50));
  this.bodies.add(new PointMass(2*width/3, 3*height/4));
}

public void draw() {
  background(255);
  this.bodies.forEach(b -> b.clearForces());
  this.applyForces();
  this.bodies.forEach(b -> b.move());
  CollisionManager.HandleCollisions(this.bodies);
  this.bodies.forEach(b -> b.draw());
}

private void applyForces() {
  for (Body b1 : this.bodies) {
      for (Body b2 : this.bodies) {
        if (b1 == b2) { continue; }
        b1.applyForce(b2);
      }
    }
}
