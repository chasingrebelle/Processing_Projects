void setup(){
  size(1000, 1000);
  loadPixels();  
  // Loop through every pixel column
  for (int x = 0; x < width; x++) {
  // Loop through every pixel row
    for (int y = 0; y < height; y++) {
      // Use the formula to find the 1D location
      int loc = x + y * width;
      pixels[loc] = color(255-random(130),0,0);
      
      if (x==0 || x == width-1 || y == height-1){
        pixels[loc] = color(255,0,0);
      }
      
      if (y==0){
        pixels[loc] = color(0,0,0);
      }
    }
  }
  updatePixels();
}

void draw(){
  loadPixels();
  for (int x = 1; x < width-1; x++) {
  // Loop through every pixel row
    for (int y = 1; y < height-1; y++) {
      // Use the formula to find the 1D location
      int loc = x + y * width;
      float r = red(pixels[loc]);
      float g = green(pixels[loc]); 
      float b = blue(pixels[loc]);
      // TODO: check loc for right and left
      int leftLoc = (x-1) + y * width;
      int rightLoc = (x+1) + y * width;
      int upLoc = x + (y-1) * width;
      int downLoc = x + (y+1) * width;
      float newR = (red(pixels[leftLoc]) + red(pixels[rightLoc]) + red(pixels[upLoc]) + red(pixels[downLoc]))/4;
      float newG = (green(pixels[leftLoc]) + green(pixels[rightLoc]) + green(pixels[upLoc]) + green(pixels[downLoc]))/4;
      float newB = (blue(pixels[leftLoc]) + blue(pixels[rightLoc]) + blue(pixels[upLoc]) + blue(pixels[downLoc]))/4;
      pixels[loc] = color(newR,newG,newB);
    }
  }
  updatePixels();
}
