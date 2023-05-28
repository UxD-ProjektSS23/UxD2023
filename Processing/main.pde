public static int fieldsize = 200; //size of one Gridspace
public static int fieldnumber = 5; //amount of gridspaces
public int rectx, recty, circlex, circley; //initial positions of the shapes

//Objects
Rectangle rect;
Grid grid;
Circle circ;
Goal [] goalspots = new Goal [4];

//colors
color rectcolor = #FF0808; //red
color circcolor = #FAFF00; //yellow
color goalcolor = #14FF00; //green

//variables
int goals = 0;
int pressedkey;
int goalx, goaly;
boolean collected;
int starttime, endtime;
String time;
   
void setup() {
  size(1000, 1000); //size of the window (fieldnumber times fieldsize is minimum to show the entire grid) 
  //size(fieldsize*5, fieldsize*5);
  background(0);
  collected = false;
  
  //initiates all goals outside of the Grid. there is probably a better way have unused goals but for now its spaces outside of the Grid
  goalspots[0] = new Goal (6,6, goalcolor);
  goalspots[1] = new Goal (6,6, goalcolor);
  goalspots[2] = new Goal (6,6, goalcolor);
  goalspots[3] = new Goal (6,6, goalcolor);
  
  //initialize the Grid
  grid = new Grid (fieldnumber);
    
  //initialize the rectangle in the starting position
  rectx = floor(random(5));
  recty = floor(random(5));
  
  //debug override
  //rectx = 2;
  //recty = 2;
  
  rect = new Rectangle (rectx, recty, rectcolor);
  
  //initialize the circle in a random position
  circlex = floor(random(5));
  circley = floor(random(5));
  
  //debug override
  //circlex = 2;
  //circley = 2;
  
   circ = new Circle (circlex, circley, circcolor);
  
  //determine the goalspace
  if (abs(circlex-2)==abs(circley-2)){
    if (circlex == 2) {
      //special case circle is in the Middle
      goals = 4;
      goalspots[0].setpos(0,2);
      goalspots[1].setpos(2,0);
      goalspots[2].setpos(2,4);
      goalspots[3].setpos(4,2);
    }
    else {
      //if the circle is on a diagonal there are two goal spaces
      goals = 2;
      //Projection on the x-Axis
      goaly = circley;
      goalx = circlex>2 ? 0 : 4;
      goalspots[0].setpos(goalx,goaly);
      //Projektion on the y-Axis
      goalx = circlex;
      goaly = circley>2 ? 0 : 4;
      goalspots[1].setpos(goalx,goaly);
    }
  }
  //otherwise there is only one goal space
  else{
    goals = 1;
    if (abs(circlex-2)>abs(circley-2)) {
      //x ist die dominante Seite
      goaly = circley;
      goalx = circlex>2 ? 0 : 4;
      goalspots[0].setpos(goalx,goaly);
      
    } else {
      //y ist die dominante Seite
      goalx = circlex;
      goaly = circley>2 ? 0 : 4;
      goalspots[0].setpos(goalx,goaly);
    }
  }
    starttime = millis();
    time = "Starttime: " + day() + '.' + month() + '.' + year() + ' ' + hour() + ':' + minute() + ':' + second();
    println (time);
    
}

void draw(){
  background(0);
  //show the goal space for testing purposes
  showgoal();
  
  //draw the Grid
  grid.display ();
   
  //draw the rectangle
  rect.display();
  
  //draw the circle
  circ.display();
}

void keyPressed() {
  //This will be replaced by motion controls at some point
  
  if (keyCode == ' '){
    //Spacebar for collection
    collect();
  }
    
  //If a key is pressed move the Rectangle and check the Location
  moveandcheck(keyCode);
}

private void moveandcheck(int pressedkey){

  //move the rectangle
  rect.move(pressedkey);
  
  //was the circle already collected
  if (collected){
    //yes: move the circle too
    circ.move(pressedkey);
    
    //check if you reached a goal space
    for (int i = 0; i<goals; i++){
      if (goalspots[i].getx() == rect.getx() && goalspots[i].gety() ==rect.gety()){
        println("you win");
        resetgame();
      }
    }
  }
}

private void collect (){
  //collect the Circle if it is on the same space as the rectangle
  if (rect.getx() == circlex && rect.gety() == circley){
      collected = true;
      println ("Circle collected");
    }
    else {
      println ("no Circle to collect");
    }
}

private void showgoal(){
  //display the 4 goal spaces
  goalspots[0].display();
  goalspots[1].display();
  goalspots[2].display();
  goalspots[3].display();
}

private void resetgame(){
  //take the time for complettion and reset the game
  time = "Endtime: " + day() + '.' + month() + '.' + year() + ' ' + hour() + ':' + minute() + ':' + second();
  println (time);
  endtime = millis() - starttime;
  println("Time to solve: " + endtime + " milliseconds");
  
  //TODO: write Time-data to file
  setup();
}
