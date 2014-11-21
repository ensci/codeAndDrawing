//Aurore Lopez

//Polygone rattaché au code spirale

class Polygon {

  private Vector x; 
  private Vector y; 

  Polygon() {

    x = new Vector();  
    y = new Vector();

  }

  public int getSize() {
    return x.size();
  }

  public void addPoint(float x1, float y1) {
    x.add(x1);
    y.add(y1);
  } 

  public float getX(int n) {
    return (Float) x.elementAt(n); 
  }

  public float getY(int n) {
    return (Float) y.elementAt(n);
  }

  public void setX(int n, float p) {
    x.setElementAt(p,n);
  }

  public void setY(int n, float p) {
    y.setElementAt(p,n);
  }

   public boolean isInside(float px, float py) {

    int nSegments = getSize();

    /* How many times the ray crosses a line-segment  can be used in selection of multiple points */
    int crossings = 0;

    float x1,x2;

    /* Iterate through each line */
    for ( int i = 0; i < getSize()-1; i++ ) {

      /* This is done to ensure that we get the same result when
              the line goes from left to right and right to left */
      if ( getX(i) <  getX(i+1) ) {
        x1 = getX(i);
        x2 = getX(i+1);
      } 
      else {
        x1 = getX(i+1);
        x2 = getX(i);
      }
      /* First check if the ray is possible to cross the line */
      if ( px > x1 && px <= x2 && ( py < getY(i) || py <= getY(i+1) ) ) {
        final float eps = 0.000001;

        /* Calculate the equation of the line */
        float dx =  getX(i+1) - getX(i);
        float dy =  getY(i+1) - getY(i);
        float k;

        if ( abs(dx) < eps ) {
          k = Float.MAX_VALUE;
        } 
        else {
          k = dy/dx;
        }

        float m = getY(i) - k * getX(i);

        /* Find if the ray crosses the line */
        float y2 = k * px + m;
        if ( py <= y2 ) {
          crossings++;
        }
      }
    }
    return (crossings>0) ? true : false;
  }


}




