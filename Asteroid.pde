
class Asteroid extends Space{
  private float[] randomCorners;
  private Asteroid(double ax, double ay, double adir, double aspeed, float asize) {
    myCenterX = ax;
    myCenterY = ay;
    myPointDirection = adir;
    speed = aspeed;
    mySize = asize;
    corners = 10;
    xCorners = new float[corners];
    yCorners = new float[corners];
    randomCorners = new float[corners];
    for(int i = 0; i < corners; i++){
      xCorners[i] = (float) Math.sin((PI*2) / corners * i) * 10;
      yCorners[i] = (float) Math.cos((PI*2) / corners * i) * 10;
      randomCorners[i] = (float) (Math.random() * (asize)/4)+asize/6;
    }
    myColor = color(171, 111, 0);
  }
  public float getSize(){
    return mySize;
  }

  public void update(){
    for(int i = 0; i < corners; i++){      
      xCorners[i] = (float) (Math.sin((PI*2) / corners * i) * mySize/2 + Math.sin((PI*2) / corners * i) * randomCorners[i] + myCenterX - globalx);
      yCorners[i] = (float) (Math.cos((PI*2) / corners * i) * mySize/2 + Math.cos((PI*2) / corners * i) * randomCorners[i] + myCenterY - globaly);
    }
    myCenterX += Math.cos(myPointDirection) * speed;
    myCenterY += Math.sin(myPointDirection) * speed;
  }

  /*public void show() {
    fill(color(171, 111, 0));
    ellipse((float)(myCenterX-globalx), (float)(myCenterY-globaly), mySize, mySize);
  }*/
}
