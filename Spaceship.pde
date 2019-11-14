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
	public void update() {
		myPointDirection = getAngle(sizew/2, sizeh/2, mouseX, mouseY);
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
	public void show ()  //Draws the floater at the current position  
	{             
		xCorners = new float[]{
		(float) (myCenterX + leng * cos((float) myPointDirection) * 1.5),
		(float) (myCenterX + leng * cos((float) myPointDirection + 2 * PI / 3)),
		(float) (myCenterX + leng * cos((float) myPointDirection + 4 * PI / 3))};
		yCorners = new float[]{
		(float) (myCenterY + leng * sin((float) myPointDirection) * 1.5),
		(float) (myCenterY + leng * sin((float) myPointDirection + 2 * PI / 3)),
		(float) (myCenterY + leng * sin((float) myPointDirection + 4 * PI / 3))};
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
