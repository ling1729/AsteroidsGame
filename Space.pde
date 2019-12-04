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
	
} 
//modified floater so I can work with it easier