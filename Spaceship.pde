class Spaceship extends Space
{   
	private float size = 20;
	private float xVel = 0;
	private float yVel = 0;
	private float xAccel = 0, yAccel=0;
	private float friction = 0.05;
	private float speed = 0.75f;
	private float accel = 0.15f;
	private float leng = size / sqrt(3);
    public Spaceship(float ax, float ay, float rotat) {
    	myCenterX = (float) sizew / 2;
    	myCenterY = (float) sizeh / 2;
		myPointDirection = rotat;
		myColor = color(64, 108, 255);
		corners = 3;
	}
	public void setSpeed(float velX, float velY, float accelX, float accelY){
		xVel = velX;
		yVel = velY;
		xAccel = accelX;
		yAccel = accelY;
	}
	public void updateDirection(){
		myPointDirection = getAngle(sizew/2, sizeh/2, mouseX, mouseY);
	}
	public void update(){
		if (mousePressed == true) {
			xAccel = cos((float) myPointDirection)*accel;
			yAccel = sin((float) myPointDirection)*accel;
			xVel += Math.abs(xAccel) < 0.75 ? xAccel:0;
			yVel += Math.abs(yAccel) < 0.75 ? yAccel:0;
		}
		globalx += xVel * speed;
		globaly += yVel * speed;
		if (xVel > 0) {
			xVel -= friction;
		} else if (abs(xVel) <= friction) {
			xVel = 0;
		} else if (xVel < 0) {
			xVel += friction;
		}
		if (yVel > 0) {
			yVel -= friction;
		} else if (abs(yVel) <= friction) {
			yVel = 0;
		} else if (yVel < 0) {
			yVel += friction;
		}
	}
	public void setCoords(float[] xCoords, float[] yCoords){
		xCorners = xCoords;
		yCorners = yCoords;
	}
	public float getSize(){
		return leng;
	}
	public void show ()  //Draws the floater at the current position  
	{             
		
		fill(myColor);   
		noStroke();    
		beginShape();
		for (int nI = 0; nI < corners; nI++)
		{
			vertex(xCorners[nI], yCorners[nI]);
		}
		endShape(CLOSE);
	}   
}
