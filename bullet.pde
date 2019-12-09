class Bullet extends Space {
  public Bullet(double ax, double ay, double ar, double adir) {
    this.myCenterX = ax;
    this.myCenterY = ay;
    this.mySize = (float) ar;
    this.myPointDirection = adir;
    speed = 20;
  }
  public double getSize(){
    return mySize;
  }
  public void show(){
    fill(255,0,0);
    ellipse((float) (myCenterX - globalx), (float) (myCenterY - globaly), mySize, mySize);
  } 
}
//bullet class