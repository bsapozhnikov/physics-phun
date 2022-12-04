public static class CollisionManager {

  private final static float TOUCH_SENSITIVITY = .5;
  
  public static void HandleCollisions(ArrayList<Body> bodies) {
    for (int i = 0; i < bodies.size(); i++) {
      for (int j = i + 1; j < bodies.size(); j++) {
        Body b1 = bodies.get(i);
        Body b2 = bodies.get(j);
        if (AreColliding(b1, b2)) { HandleCollision(b1, b2); }
      }
    }
  }

  public static boolean AreTouching(Body b1, Body b2) {
    if (b1 instanceof Floor) {
      float floor_y = ((Floor)b1).getY();
      if (b2 instanceof PointMass) {
        float point_y = ((PointMass)b2).getY(); 
        return dist(0, point_y, 0, floor_y) < TOUCH_SENSITIVITY;
      }
    }
    else if (b1 instanceof PointMass) {
      if (b2 instanceof Floor) {
        return AreTouching(b2, b1);
      }
    }
    
    return false;
  }

  private static boolean AreColliding(Body b1, Body b2) {
    if (b1 instanceof Line) {
      if (b2 instanceof PointMass) {
        return ((Line)b1).wasCrossedBy((PointMass)b2);
      }
    }
    else if (b1 instanceof PointMass) {
      if (b2 instanceof Line) {
        return AreColliding(b2, b1);
      }
    }
    
    return false;
  }

  private static void HandleCollision(Body b1, Body b2) {
    println("Collision!");
    if (b1 instanceof Line) {
      if (b2 instanceof PointMass) {
        ((PointMass)b2).bounceOff((Line)b1);
      }
    }
     else if (b1 instanceof PointMass) {
      if (b2 instanceof Line) {
        HandleCollision(b2, b1);
      }
    }
 }
  
}
