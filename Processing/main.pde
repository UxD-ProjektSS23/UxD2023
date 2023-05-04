public static int fieldsize = 200; //size of one Gridspace
public static int fieldnumber = 5; //amount of gridspaces
public int rectx, recty, circlex, circley; //initial positions of the shapes


Rectangle rect;
Grid grid;
Circle circ;
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
  //TODO: create only on the edges
  circlex = floor(random(5));
  circley = floor(random(5));
  
  circ = new Circle (circlex, circley);
  
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
  //move the rectangle
  rect.move(keyCode);
  
  //was the circle already collected
  if (collected){
    //yes: move the circle too
    circ.move(keyCode);
  }
  else{
    //no: check if rectangle and circle share a space
    if (rect.getx() == circlex && rect.gety() == circley){
      collected = true;
    }
  }
}
