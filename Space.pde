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
    
    //translate the (x,y) center of the ship to the correct position

    //convert degrees to radians for rotate()     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    
    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);
    
    //draw the polygon
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    endShape(CLOSE);

    //"unrotate" and "untranslate" in reverse order
    rotate(-1*dRadians);
  	}  
} 
//modified floater so I can work with it easier