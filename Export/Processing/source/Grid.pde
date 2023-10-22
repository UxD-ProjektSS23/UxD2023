class Grid {
  
  int spaces;
  color colorhex;
  
  public Grid (int size, color hexcolor) {
    spaces = size;
    colorhex = hexcolor;
  }
  
  void display(){
    stroke(colorhex);
    strokeWeight(5);
    
    //draw enough lines to make the required spaces in the grid
    for (int i = 0; i < spaces+1; i++) {
    line(0-offset, i*fieldsize, displayHeight-offset, i*fieldsize);
    line(i*fieldsize-offset, 0, i*fieldsize-offset, displayHeight);
    }
  }
}
