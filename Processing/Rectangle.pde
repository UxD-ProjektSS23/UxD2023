class Rectangle {
 
  int x, y;
  color colorhex;
  
  // Constructor
  public Rectangle(int xpos, int ypos, color hexcolor) {
    x = xpos;
    y = ypos;
    colorhex = hexcolor;
  }
  
  void move (int dir) {
    //move in the direction of the given keycode
    switch(dir) {
      case UP: 
        y = y<1 ? 0 : y-1;
        println ("moving up");
        break;
      case DOWN: 
        y = y>3 ? 4 : y+1;
        println ("moving down");
        break;
      case RIGHT: 
        x = x>3 ? 4 : x+1;
        println ("moving right");
        break;
      case LEFT: 
        x = x<1 ? 0 : x-1;
        println ("moving left");
        break;
      default:
        break;
    }
  }
  
  void display() {
    noStroke();
    fill(colorhex);
    rect (x*fieldsize+50-offset, y*fieldsize+50, fieldsize-100, fieldsize-100);
  }
  
  int getx(){
    return x;
  }
  
  int gety(){
    return y;
  }
}
