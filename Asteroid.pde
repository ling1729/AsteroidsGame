class Asteroid extends Space{
  Asteroid(double ax, double ay, double adir, double aspeed, float asize) {
    myCenterX = ax;
    myCenterY = ay;
    myPointDirection = adir;
    speed = aspeed;
    mySize = asize;
  }
  public void show() {
    fill(color(171, 111, 0));
    ellipse((float)(myCenterX-globalx), (float)(myCenterY-globaly), mySize, mySize);
  }
}
