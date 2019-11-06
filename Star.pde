class Star extends Floater //note that this class does NOT extend Floater (mine does so idk)
{
	float distance = 0.1;
	float sizeEffect = 0.5;
	double startx = globalx;
	double starty = globaly;
	Star(float ax, float ay, float asize) {
			myCenterX=ax;
			myCenterY=ay;
			mySize=asize;
	}
	public void show() {
			fill(255);
			ellipse((float)(myCenterX-globalx-(distance+sizeEffect*mySize/maxStarSize)*(globalx-startx)), (float)(myCenterY-globaly-(distance+sizeEffect*mySize/maxStarSize)*(globaly-starty)), mySize, mySize);
	}
}
