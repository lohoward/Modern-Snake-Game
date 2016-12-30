/*Louise Howard
 *modern take on snake
 */

//soundfile
import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;

char route;
ArrayList<BoxPart> Box;
BoxPart face;
BoxFood food;
boolean gameFinished;
int score = 0,SaveNum=0;

AudioPlayer beat;

//viewed from the downward view in 3D
void setup() 
{
  fullScreen(P3D);
  frameRate(10);
  
  
  Box = new ArrayList<BoxPart>();
  Box.add(new BoxPart(300, 200));
  food = new BoxFood();
  smooth();
  face = (BoxPart)Box.get(0);
  gameFinished = false;


  minim = new Minim(this);
  beat = minim.loadFile("beat.aiff");
  beat.loop();
  
}

void draw() 
{
  background(#F0B86F);
  moveBody();
  moveFace();
  checkGameFinished();
  
  //score
  textSize(18);
  fill(#429FDB);
  text("Score: "+score,1500,50);
  
  //adding onto snake body
  if (dist(face.x, face.y, food.x, food.y) < 5)
  {
    food = new BoxFood();
    Box.add(new BoxPart(face.x, face.y));
    score++;
  }
  food.display();
  for (int i = 0; i < Box.size(); i++) 
  {
    BoxPart sp = (BoxPart)Box.get(i);
    sp.display();
  }
}

//controls

void keyPressed() 
{
  if(keyPressed)
  {
  if (keyCode == LEFT) route= 'l';
  if (keyCode == RIGHT) route = 'r';
  if (keyCode == UP) route = 'u';
  if (keyCode == DOWN) route = 'd';
  
  // if s is pressed, screenshot is taken
  if (key == 's'|| key =='S')
  {
    save("Modern_Snake"+SaveNum+".png");
    SaveNum++;//allows screenshots to be saved numerically
  }
  
  // if spacebar is pressed gameover
  if (keyCode == ' ' && gameFinished)
  {
    score=0;
    Box.clear();
    Box.add(new BoxPart(100, 200));
    food = new BoxFood();
    face = (BoxPart)Box.get(0);
    loop();
  }
  }
}

//declare route the box takes
void moveFace()
{
  switch(route)
  {
  case 'u':
    face.y -= 20;
    break;
  case 'd':
    face.y += 20;
    break;
  case 'r':
    face.x += 20;
    break;
  case 'l':   
    face.x -= 20;
    break;
  }
}

void moveBody() 
{
  for (int i = Box.size()-1; i > 0; i--) {
    BoxPart front = (BoxPart)Box.get(i-1);
    BoxPart back = (BoxPart)Box.get(i);
    back.x = front.x;
    back.y = front.y;
  }
}

void checkGameFinished() 
{
  for (int i = 1; i < Box.size(); i++) 
  {
    BoxPart sp = (BoxPart)Box.get(i);
    if (dist(face.x, face.y, sp.x, sp.y) < 5) 
    {
      textAlign(CENTER);
      text("GAME OVER!\nPress spacebar to continue.\nPress ESC to finish.", width/2-20, height/2);
      gameFinished = true;
      noLoop();
    }
  }
  if (face.x < 0 || face.x > width || face.y < 0 || face.y > height) 
  {
    textAlign(CENTER);
    text("GAME OVER!\nPress spacebar to continue.\nPress ESC to finish.", width/2, height/2);
    
    gameFinished = true;
    noLoop();
  }
}

  class BoxFood 
  {
  int x;
  int y;

  BoxFood() 
  {
    x = int(random(width/20))*20;
    y = int(random(height/20))*20;
  }
  void display() 
  {
    fill(255, 100, 100);
    pushMatrix();
    translate(x, y, 0);
    box(20);
    popMatrix();
  }
}

class BoxPart 
{
  int x;
  int y;
  BoxPart(int newX, int newY) 
  {
    x = newX;
    y = newY;
  }
  
  void display() 
  {
    fill(255);
    pushMatrix();
    translate(x, y, 0);
    box(20);
    popMatrix();
  }
}
