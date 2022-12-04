public class Force extends Vector {

  public Force() {
    super(0, 0, true);
  } 
  
  /**
  *** If inPolar is true, `a` should be the direction in radians and `b` should be the magnitude
  *** If inPolar is false, `a` should be the x component and `b` should be the y component. 
  **/
  public Force(float a, float b, boolean inPolar) {
    super(a, b, inPolar);
  }
 
}
