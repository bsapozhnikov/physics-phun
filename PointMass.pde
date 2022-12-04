public class PointMass extends Body {

  private final static float MIN_VEL = 5;
  private final static float MIN_ACC = 0.1;
  private float prevX, prevY;
  private float x, y;
  private Vector vel, prevVel;

  public PointMass(float x, float y) {
    this.x = this.prevX = x;
    this.y = this.prevY = y;
    this.vel = this.prevVel = new Vector(1, 0, true);
  }

  public void applyForce(Body other) {
  }

  public void move() {
    this.prevX = this.x;
    this.prevY = this.y;
    this.x += this.vel.getX();
    this.y += this.vel.getY();

    this.prevVel = new Vector(this.vel);
    this.vel.add(this.acceptedForce);
    if (this.vel.getMagnitude() < MIN_VEL && this.acceptedForce.getMagnitude() < MIN_ACC) {
      this.vel = new Vector(1, 0, true);
    }

    println(this.y, this.vel.getY(), this.acceptedForce.getMagnitude());
  }

  public void draw() {
    stroke(255);
    fill(0);
    circle(this.x, this.y, 10);

    stroke(255, 0, 0);
    Vector v = new Vector(this.x, this.y, false);
    Vector v2 = new Vector(this.vel);
    v2.scale(10);
    v.add(v2);
    // line(this.x, this.y, v.getX(), v.getY());
    
    stroke(0, 0, 255);
    v = new Vector(this.x, this.y, false);
    v2 = new Vector(this.acceptedForce);
    v2.scale(10);
    v.add(v2);
    // line(this.x, this.y, v.getX(), v.getY());
  }

  public float getX() { return this.x; }
  public float getY() { return this.y; }
  public float getPrevX() { return this.prevX; }
  public float getPrevY() { return this.prevY; }

  public void bounceOff(Line ln) {
    this.vel = this.prevVel;
    Vector lnVec = ln.getUnitVector();
    float dDir = this.vel.getDirInRadians() - lnVec.getDirInRadians();
    print("bouncing off", degrees(lnVec.getDirInRadians()), degrees(this.vel.getDirInRadians()), degrees(dDir)); 
    this.vel.rotate(-2 * dDir);
    println(" ", degrees(this.vel.getDirInRadians()));

    float prevX = this.getPrevX();
    float prevY = this.getPrevY();
    this.move();
    this.prevX = prevX;
    this.prevY = prevY;

    this.vel.scale(0.9);
  }
}
