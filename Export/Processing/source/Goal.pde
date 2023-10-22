class Goal {
 
  int x, y;
  color colorhex;
  
  // Constructor
  public Goal(int xpos, int ypos, color hexcolor) {
    x = xpos;
    y = ypos;
    colorhex = hexcolor;
  }
  
  void display() {
    noStroke();
    fill(colorhex);
    rect (x*fieldsize-offset, y*fieldsize, fieldsize, fieldsize);
  }
  
  public int getx(){
    return x;
  }
  
  public int gety(){
    return y;
  }
  
  public void setpos(int xpos, int ypos){
    x = xpos;
    y = ypos;
  }
}
