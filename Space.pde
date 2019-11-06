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
	   
	public void update()
	{          
		myCenterX += Math.cos(myPointDirection) * speed;    
		myCenterY += Math.sin(myPointDirection) * speed;      
	}   
	public void show ()
	{             
		fill(myColor);   
		noStroke();    
		//translate the (x,y) center of the ship to the correct position
		translate((float) myCenterX, (float) myCenterY);

		//convert degrees to radians for rotate()     
		float dRadians = (float) (myPointDirection * (Math.PI / 180));
		
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
		rotate(-1 * dRadians);
		translate(-1 * (float)myCenterX, -1 * (float)myCenterY);
	}   
} 
//modified floater so I can work with it easier