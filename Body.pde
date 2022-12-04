public abstract class Body {

  protected Force acceptedForce;
  
  public abstract void applyForce(Body other);
  public abstract void move();
  public abstract void draw();

  public void clearForces() { this.acceptedForce = new Force(); }
  public void acceptForce(Force f) { this.acceptedForce.add(f); } 
}
