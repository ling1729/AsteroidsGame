
class Asteroid extends Space{
  private Asteroid(double ax, double ay, double adir, double aspeed, float asize) {
    myCenterX = ax;
    myCenterY = ay;
    myPointDirection = adir;
    speed = aspeed;
    mySize = asize;
    corners = 9;
    xCorners = new float[corners];
    yCorners = new float[corners];
    for(int i = 0; i < corners; i++){
      xCorners[i] = (float) Math.sin((PI*2) / corners * i);
      yCorners[i] = (float) Math.sin((PI*2) / corners * i);
    }
  }
  public void show() {
    fill(color(171, 111, 0));
    ellipse((float)(myCenterX-globalx), (float)(myCenterY-globaly), mySize, mySize);
  }
}
