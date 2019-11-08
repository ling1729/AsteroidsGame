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
public void setup() 
{
	player = new Spaceship((float) sizew / 2, (float) sizeh / 2, PI);
	size(500, 500);
	generateAst(
		(float) globalx - 100,
		(float) globalx, 
		(float) globalx + sizew, (float)globalx + sizew+100, 
		(float) globaly - 100, (float)globaly, (float) globaly + sizeh, 
		(float) globaly + sizeh + 100, 1, 3, 10
	); //generate initial asteroids
	for (int i =- 1; i < 2; i++) {
		for (int j =- 1; j < 2; j++) {
			genChunk(i, j);
		}
	} //generate initial stars
	chunkx = getChunkx();
	chunky = getChunky();
	//set initial star chunks
}
public void draw() 
{
	background(0);
	drawStars();
	for (int i = 0; i < asteroids.size(); i++) {
		asteroids.get(i).show();
		asteroids.get(i).update();
	} //update and show asteroids
	chunkUpdate(); //check star chunks for updates
	clearChunk(); //checks for star chunks to remove
	clearAst(); //remove asteroids that go too far away
	player.show();
	player.update(); //show and update the player
	count++;
	if (count == 8) {
		count = 0;
		generateAst((float)globalx - 100, (float)globalx, (float)globalx + sizew, (float)globalx + sizew + 100, (float)globaly - 100, (float)globaly, (float) globaly + sizeh, (float) globaly + sizeh + 100, (float) 1, (float) 3, 1);
	} //generate a new asteroid every 8 loops
	count2++;

	if (keyPressed) {
    	if (key == (char)32) {
    		if(count2>10){
        		bullets.add(new Bullet(globalx + 250,globaly + 250, (double) 10, player.getPointDirection()));
        		count2 = 0;
      		}
		}
  	} //add a new bullet if space is pressed and there is a long enough interval between bullets

  for(int i = 0; i < bullets.size(); i++){
    bullets.get(i).update();
    bullets.get(i).show();
  }
  //show and update bullets
}
public void generateAst(float x1, float x2, float x3, float x4, float y1, float y2, float y3, float y4, float sp1, float sp2, int num) {
	for (int i = 0; i < num; i++) {
		asteroids.add(new Asteroid(randnum(x1, x2, x3, x4), randnum(y1, y2, y3, y4), (float)Math.random() * (2 * PI), randnum(sp1, sp2, sp2, sp2), (float)40));
	}
} //function to generate asteroids randomly between two areas

public float randnum(float a, float b, float c, float d) {
	if (Math.random()>0.5) {
		return (float) Math.random() * (b - a) + a;
	} else {
		return (float) Math.random() * (d - c) + c;
	}
} //generate a random number between a, b, and c, d

public void genChunk(int i, int j) {
	generateStar((float) 500 * i, (float) 500 * i + 500, (float) 500 * j, (float) 500 * j + 500, minStarSize, maxStarSize, 50);
	starChunks.add((ArrayList<Star>)stars.clone());
	stars.clear();
} //generate a star chunk at location (j, l)

public void generateStar(float x1, float x2, float y1, float y2, float size1, float size2, int num) {
	for (int i = 0; i < num; i++) {
		stars.add(new Star(randnum(x1, x2, x1, x2), randnum(y1, y2, y1, y2), randnum(size1, size2, size1, size2)));
	}
} //generate stars within a bound

public int getChunkx() {
	return (int) Math.floor(globalx / (500));
} //gets the star chunk x from the player location

public int getChunky() {
	return (int) Math.floor(globaly / (500));
} //gets the star chunk y

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
} //checks for updates in the star chunks

public float getAngle(float x1, float y1, float x2, float y2) {
	float angle = (float) Math.atan2(y2 - y1, x2 - x1);
	return angle;
} //gets the angle from the player to the mouse

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
} //removes star chunks that are too far away

public void clearAst() {
	int x = getChunkx(); 
	int y = getChunky();
	for (int i = 0; i < asteroids.size(); i++) {
		if (asteroids.get(i).getX() < (x - 4) * 500 || asteroids.get(i).getX() > (x + 4) * 500 || asteroids.get(i).getY() < (y - 4) * 500 || asteroids.get(i).getY() > (y + 4)*500)
			asteroids.remove(i);
		i++;
	}
} //removes asteroids that are too far away

public void drawStars() {
	for (int i = 0; i<starChunks.size(); i++) {
		for (int j = 0; j<starChunks.get(i).size(); j++) {
			starChunks.get(i).get(j).show();
		}
	}
} //draws all the stars