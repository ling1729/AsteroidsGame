class Star extends Space //note that this class does NOT extend Floater (mine does so idk)
{
	private float distance = 0.1;
	private float sizeEffect = 0.5;
	private double startx = globalx;
	private double starty = globaly;
	private Star(float ax, float ay, float asize) {
		myCenterX=ax;
		myCenterY=ay;
		mySize=asize;
	}
	public void show() {
		fill(255);
		ellipse((float)(myCenterX-globalx-(distance+sizeEffect*mySize/maxStarSize)*(globalx-startx)), (float)(myCenterY-globaly-(distance+sizeEffect*mySize/maxStarSize)*(globaly-starty)), mySize, mySize);
	}
}
