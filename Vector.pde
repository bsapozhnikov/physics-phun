public class Vector {

  private float dirInRads, mag;
  
  /**
  *** If inPolar is true, `a` should be the direction in radians and `b` should be the magnitude
  *** If inPolar is false, `a` should be the x component and `b` should be the y component. 
  **/
  public Vector(float a, float b, boolean inPolar) {
    if (inPolar) {
      this.dirInRads = a;
      this.mag = b;
    }
    else {
      this.dirInRads = atan(b/a);
      if (a < 0) { this.dirInRads += PI; }
      this.mag = mag(a, b);
      //println("converting vector", a, b, "to", degrees(this.dirInRads), this.mag);
    }
  }
  
  public Vector(Vector v) {
    this.dirInRads = v.dirInRads;
    this.mag = v.mag;
  }
  
  public float getX() {
    float x = this.mag * cos(this.dirInRads);
    //println("getting X", degrees(this.dirInRads), this.mag, x);
    return x;
  }
  public float getY() { return this.mag * sin(this.dirInRads); }
  public float getDirInRadians() { return this.dirInRads; }
  public float getMagnitude() { return this.mag; }
  
  public void rotate(float deltaInRadians) { this.dirInRads += deltaInRadians; }
  public void scale(float c) { this.mag *= c; }
  public void add(Vector o) {
    Vector v = new Vector(this.getX() + o.getX(), this.getY() + o.getY(), false);
    this.dirInRads = v.dirInRads;
    this.mag = v.mag;
  }
  
}
