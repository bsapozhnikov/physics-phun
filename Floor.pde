public class Floor extends Line {
  
  private final static int Offset = 50;
  
  public Floor() {
    super(0, height - Offset, width, height - Offset);
  }

  public float getY() { return height - Offset; }
  
  public void applyForce(Body other) {
    super.applyForce(other);
    if (!CollisionManager.AreColliding(this, other)) {
      println("applying gravity");
      other.acceptForce(new Force(HALF_PI, 1, true));
    }
  }

  public void move() {}
 
}
