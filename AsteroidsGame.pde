//your variable declarations here
private double globalx = 0;
private double globaly = 0;
private int chunky;
private int chunkx;
private int sizew = 500;
private int sizeh = 500;
private float minStarSize = 1;
private float maxStarSize = 10;
private int count = 0;
private int count2 = 0;
private ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
private ArrayList<Star> stars = new ArrayList<Star>();
private ArrayList<ArrayList<Star>> starChunks = new ArrayList<ArrayList<Star>>();
private ArrayList<Bullet> bullets = new ArrayList<Bullet>();
private Spaceship player;

//variable declarations

public void setup() 
{
	player = new Spaceship(250, 250, PI);
	size(500, 500);
	generateAst(
		(float) globalx - 200,
		(float) globalx - 100, 
		(float) globalx + sizew + 100, 
		(float) globalx + sizew + 200, 
		(float) globaly - 200,
		(float) globaly - 100, 
		(float) globaly + sizeh + 100, 
		(float) globaly + sizeh + 200, 1, 3, 10
	);
	for (int i =- 1; i < 2; i++) {
		for (int j =- 1; j < 2; j++) {
			genChunk(i, j);
		}
	}
	chunkx = getChunkx();
	chunky = getChunky();

	player.setCoords(new float[]{
		(float) (player.getX() + player.getSize() * cos((float) player.getPointDirection()) * 1.5),
		(float) (player.getX() + player.getSize() * cos((float) player.getPointDirection() + 2 * PI / 3)),
		(float) (player.getX() + player.getSize() * cos((float) player.getPointDirection() + 4 * PI / 3))}
		, new float[]{
		(float) (player.getY() + player.getSize() * sin((float) player.getPointDirection()) * 1.5),
		(float) (player.getY() + player.getSize() * sin((float) player.getPointDirection() + 2 * PI / 3)),
		(float) (player.getY() + player.getSize() * sin((float) player.getPointDirection() + 4 * PI / 3))}
	);

	//Declare player, generate initial asteroids, and generate initial stars

}
public void generateAst(float x1, float x2, float x3, float x4, float y1, float y2, float y3, float y4, float sp1, float sp2, int num) {
	for (int i = 0; i < num; i++) {
		asteroids.add(new Asteroid(randnum(x1, x2, x3, x4), randnum(y1, y2, y3, y4), (float)Math.random() * (2 * PI), randnum(sp1, sp1, sp2, sp2), (float)(Math.random() * 20 + 10)));
	}
} //function to generate Asteroids within given bounds

/*public void randomCoords(double centerX, double centerY, double minCircler, double maxCircler, int points, float[] xCoords, float[] yCoords){
	for(int i = 0; i < points; i ++){
		xCoords[i] = minCircler + Math.random() * maxCircler
	}
} Random shaped asteroids, an implementation for another time */ 
double prevMouseX = mouseX;
double prevMouseY = mouseY;
boolean released = false;
public void draw() 
{
	background(0); //clear canvas
	drawStars(); //draw stars
	for (int i = 0; i < asteroids.size(); i++) {
		asteroids.get(i).show();
		asteroids.get(i).update();
	} //show and update asteroids

	chunkUpdate();
	clearChunk();
	clearAst();

	//update star chunks and clear asteroids that are too far away

	if(mouseX != prevMouseX || mouseY != prevMouseY){
		player.updateDirection();
	}
	player.setCoords(new float[]{
			(float) (player.getX() + player.getSize() * cos((float) player.getPointDirection()) * 1.5),
			(float) (player.getX() + player.getSize() * cos((float) player.getPointDirection() + 2 * PI / 3)),
			(float) (player.getX() + player.getSize() * cos((float) player.getPointDirection() + 4 * PI / 3))}
			, new float[]{
			(float) (player.getY() + player.getSize() * sin((float) player.getPointDirection()) * 1.5),
			(float) (player.getY() + player.getSize() * sin((float) player.getPointDirection() + 2 * PI / 3)),
			(float) (player.getY() + player.getSize() * sin((float) player.getPointDirection() + 4 * PI / 3))}
		);
	player.show();
	player.update();

	//show and update player

	count++;
	if (count == 8) {
		count = 0;
		generateAst((float)globalx - 100, (float)globalx, (float)globalx + sizew, (float)globalx + sizew + 100, (float)globaly - 100, (float)globaly, (float) globaly + sizeh, (float) globaly + sizeh + 100, (float) 1, (float) 3, 1);
	}

	//generate a new asteroid outside vision every 8 frames (around 5 per second)

	count2++;
  if (keyPressed) {
    if (key == (char)32) {
      if(count2>10){
        bullets.add(new Bullet(globalx + 250,globaly + 250, (double) 10, player.getPointDirection()));
        count2 = 0;
      }
    }
    if (key == 'h' && released){
    	hyperSpace();
    	released = false;
    }
  }
  //see if key is pressed and add a new bullet if there is a long enough delay
  for(int i = 0; i < bullets.size(); i++){
    bullets.get(i).update();
    bullets.get(i).show();
    for(int j = 0; j < asteroids.size(); j ++){
    	if(pnpoly(convertDouble(asteroids.get(j).getXCoord()), convertDouble(asteroids.get(j).getXCoord()), bullets.get(i).getX(), bullets.get(i).getY()))
    		test = true;
    }
  } //show and update bullets
  prevMouseX = mouseX;
  prevMouseY = mouseY;
  System.out.println(test);
}
boolean test = false;
public static double[] convertDouble(float[] input)
{
    if (input == null)
    {
        return null; // Or throw an exception - your choice
    }
    double[] output = new double[input.length];
    for (int i = 0; i < input.length; i++)
    {
        output[i] = input[i];
    }
    return output;
}
static boolean pnpoly(double[] vertx, double[] verty, double testx, double testy)
{
    int nvert = vertx.length;
    int i, j;
    boolean c = false;
    for (i = 0, j = nvert-1; i < nvert; j = i++) {
        if ( ((verty[i]>testy) != (verty[j]>testy)) &&
                (testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
            c = !c;
    }
    return c;
}   

void keyReleased() {
		released = true;
}


public float randnum(float a, float b, float c, float d) {
	if (Math.random()>0.5) {
		return (float) Math.random() * (b - a) + a;
	} else {
		return (float) Math.random() * (d - c) + c;
	}
} //generate random number within two bounds

public void genChunk(int i, int j) { //i is y and j is x
	generateStar((float) 500 * i, (float) 500 * i + 500, (float) 500 * j, (float) 500 * j + 500, minStarSize, maxStarSize, 50);
	starChunks.add((ArrayList<Star>)stars.clone());
	stars.clear();
} //generate a star chunk with id j, i

public void generateStar(float x1, float x2, float y1, float y2, float size1, float size2, int num) {
	for (int i = 0; i < num; i++) {
		stars.add(new Star(randnum(x1, x2, x1, x2), randnum(y1, y2, y1, y2), randnum(size1, size2, size1, size2)));
	}
} //generates stars with parameters

public int getChunkx() {
	return (int) Math.floor(globalx / (500));
} //returns chunk idx from x position

public int getChunky() {
	return (int) Math.floor(globaly / (500));
} //returns chunk idy from y position

public void chunkUpdate(){
	if (chunkx > getChunkx()) {
		genChunk(getChunkx() - 1, getChunky() - 1);
		genChunk(getChunkx() - 1, getChunky());
		genChunk(getChunkx() - 1, getChunky() + 1);
		chunkx = getChunkx();
	}
	if (chunkx<getChunkx()) {
		genChunk(getChunkx() + 1, getChunky() - 1);
		genChunk(getChunkx() + 1, getChunky());
		genChunk(getChunkx() + 1, getChunky() + 1);
		chunkx=getChunkx();
	}

	if (chunky>getChunky()) {
		genChunk(getChunkx() - 1, getChunky() - 1);
		genChunk(getChunkx(), getChunky() - 1);
		genChunk(getChunkx() + 1, getChunky() - 1);
		chunky=getChunky();
	}
	if (chunky<getChunky()) {
		genChunk(getChunkx() - 1, getChunky() + 1);
		genChunk(getChunkx(), getChunky() + 1);
		genChunk(getChunkx() + 1, getChunky() + 1);
		chunky=getChunky();
	}
} //updates the star chunks

public float getAngle(float x1, float y1, float x2, float y2) {
	float angle = (float) Math.atan2(y2 - y1, x2 - x1);
	return angle;
} //gets the angle from one point to another

public void clearChunk() {
	int loadlimit = 2;
	int x = getChunkx(); 
	int y = getChunky();
	for (int i = 0; i<starChunks.size(); i++) {
		if (starChunks.get(i).get(0).getX() < (x - loadlimit + 1) * 500||
			starChunks.get(i).get(0).getX() > (x + loadlimit) * 500||
			starChunks.get(i).get(0).getY() < (y - loadlimit + 1) * 500||
			starChunks.get(i).get(0).getY() > (y + loadlimit) * 500)
			starChunks.remove(i);
		i++;
	}
} //clears star chunks that can't be seen

public void clearAst() {
	int x = getChunkx(); 
	int y = getChunky();
	for (int i = 0; i < asteroids.size(); i++) {
		if (asteroids.get(i).getX() < (x - 4) * 500 || asteroids.get(i).getX() > (x + 4) * 500 || asteroids.get(i).getY() < (y - 4) * 500 || asteroids.get(i).getY() > (y + 4)*500)
			asteroids.remove(i);
		i++;
	}
} //clears asteroids that are too far away

public void drawStars(){
	for (int i = 0; i < starChunks.size(); i++) {
		for (int j = 0; j < starChunks.get(i).size(); j++) {
			starChunks.get(i).get(j).show();
		}
	}
} //draws the stars

public void hyperSpace(){
	player.setPointDirection(Math.random() * 2 * PI);
	globalx += Math.random() * 1000 - 500;
	globaly += Math.random() * 1000 - 500;
	player.setSpeed(0, 0, 0, 0);
}