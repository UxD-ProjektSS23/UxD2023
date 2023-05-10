public static int fieldsize = 200; //size of one Gridspace
public static int fieldnumber = 5; //amount of gridspaces
public int rectx, recty, circlex, circley; //initial positions of the shapes


Rectangle rect;
Grid grid;
Circle circ;
int pressedkey;
char goaldir;
boolean collected = false;
   
void setup() {
  size(1000, 1000); //size of the window (fieldnumber times fieldsize is minimum to show the entire grid) 
  //size(fieldsize*5, fieldsize*5);
  background(0);
  
  //initialize the Grid
  grid = new Grid (fieldnumber);
    
  //initialize the rectangle in the starting position
  rectx = 2;
  recty = 2;
  
  rect = new Rectangle (rectx, recty);
  
  //initialize the circle in a random position
  
  //choose a side side on witch the circle is created
  //TODO: Corners are twice as likely to be chosen and habe a "correct" opposite side
  switch(floor(random(4))) {
      case 0: 
        //North
        circlex = floor(random(5));
        circley = 0;
        goaldir = 'S';
        println ("Circle created North");
        break;
      case 1: 
        //South
        circlex = floor(random(5));
        circley = 4;
        goaldir = 'N';
        println ("Circle created South");
        break;
      case 2: 
        //West
        circlex = 0;
        circley = floor(random(5));
        goaldir = 'E';
        println ("Circle created West");
        break;
      case 3: 
        //East
        circlex = 4;
        circley = floor(random(5));
        goaldir = 'W';
        println ("Circle created East");
        break;
      default:
      println ("could not create circle coordinates");
        break;
    }
    
    print ("Goal is " + goaldir);
    circ = new Circle (circlex, circley);
    
    //TODO: Start Timer
    
}

void draw(){
  background(0);
  
  //draw the Grid
  grid.display ();
   
  //draw the rectangle
  rect.display();
  
  //draw the circle
  circ.display();
}

void keyPressed() {
  //If a key is pressed move the Rectangle and check the Location
  //This will be replaced by motion controls at some point
  moveandcheck(keyCode);
}

void moveandcheck(int pressedkey){
  //move the rectangle
  rect.move(pressedkey);
  
  //was the circle already collected
  if (collected){
    //yes: move the circle too
    circ.move(pressedkey);
    
    //check if the goal is reached
    switch(goaldir) {
      case 'S': 
        //North to South
        if (rect.gety() == 4){
          println("you win");
        }
        break;
      case 'N': 
        //South to North
        if (rect.gety() == 0){
          println("you win");
        }
        break;
      case 'E': 
        //West to East
        if (rect.getx() == 4){
          println("you win");
        }
        break;
      case 'W': 
        //East to West
        if (rect.getx() == 0){
          println("you win");
        }
        break;
      default:
      println ("could not find goaldirection");
        break;
    }
  }
  else{
    //no: check if rectangle and circle share a space
    if (rect.getx() == circlex && rect.gety() == circley){
      collected = true;
    }
  }
}
