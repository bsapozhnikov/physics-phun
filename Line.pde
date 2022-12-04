public class Line extends Body {
  
  private float x1, y1, x2, y2;
  
  public Line(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;    
  }
  
  public Vector getUnitVector() { return new Vector(this.x2 - this.x1, this.y2 - this.y1, false); }
  
  public void applyForce(Body other) {
    if (CollisionManager.AreTouching(this, other)) {
      float normal_dir = y1 == y2 ? -HALF_PI : atan((x2 - x1)/(y2 - y1));
      println("line applying normal force in direction", normal_dir);
      other.acceptForce(new Force(normal_dir, 1, true));
    }
  }
  
  public void move() {}
  
  public boolean wasCrossedBy(PointMass p) {
    float px1 = p.getPrevX();
    float py1 = p.getPrevY();
    float px2 = p.getX();
    float py2 = p.getY();
    
    println("checking collision", px1, py1, px2, py2, px1 == px2, py1 == py2);
    if (px1 == px2 && py1 == py2) return false;
    
    Vector lnPos1 = new Vector(this.x1, this.y1, false);
    Vector lnPos2 = new Vector(this.x2, this.y2, false);
    Vector pPos1 = new Vector(p.getPrevX(), p.getPrevY(), false);
    Vector pPos2 = new Vector(p.getX(), p.getY(), false);
    Vector shift = new Vector(lnPos1);
    shift.rotate(PI);
    lnPos2.add(shift);
    println("checking collision after shift", shift.getX(), lnPos2.getX(), lnPos2.getY());
    pPos1.add(shift);
    pPos2.add(shift);
    float rotation = -lnPos2.getDirInRadians();
    pPos1.rotate(rotation);
    pPos2.rotate(rotation);
    println("checking collision after rotation", degrees(rotation), pPos1.getY(), pPos2.getY());
    boolean doesCrossRay = pPos1.getY() * pPos2.getY() <= 0;
    if (!doesCrossRay) { return false; }

    float lnEnd = lnPos2.getMagnitude();
    float a = pPos1.getX();
    float b = pPos1.getY();
    float c = pPos2.getX();
    float d = pPos2.getY();
    float collisionX = a - b * (c - a) / (d - b);
    return 0 <= collisionX && collisionX <= lnEnd;
  }
  
  public void draw() {
    stroke(0);
    line(this.x1, this.y1, this.x2, this.y2);
  }
}
