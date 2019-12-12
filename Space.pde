abstract class Space extends Floater //Do NOT modify the Floater class! Make changes in the Spaceship class 
{   
	protected float[] xCorners;   
  	protected float[] yCorners;  
	protected double speed;
	protected float mySize;
	public double getX(){
		return myCenterX;
	}
	public double getY(){
		return myCenterY;
	}

	public double getPointDirection(){
		return myPointDirection;
	}

	public void setPointDirection(double newDirection){
		myPointDirection = newDirection;
	}
	public void update()
	{          
		myCenterX += Math.cos(myPointDirection) * speed;    
		myCenterY += Math.sin(myPointDirection) * speed;      
	}   
	public void show ()  //Draws the floater at the current position  
	{             
    fill(myColor);   
    stroke(myColor);    
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    endShape(CLOSE);
    //stroke(0);
    //fill(color(171, 111, 0));
    //ellipse((float)(myCenterX-globalx), (float)(myCenterY-globaly), mySize, mySize);
  	}  
} 
//modified floater so I can work with it easier