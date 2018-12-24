float[][] grid;
float[][] next;
float conductivity = 0.5;

void setup(){
  size(1000,1000);
  
  grid = new float[width][height];
  next = new float[width][height];
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
       grid[x][y] = 0.2;
       next[x][y] = 0.2;
    } 
  }
  
}

void draw(){
  background(51);
  
  
  // FIXME WTF are these dark squares???
  for (int i = (width*2/5); i < (width*3/5); i++){
    for (int j = (height*2/5); j < (height*3/5); j++){
      grid [i][10] = 1;
    }
  }
  
  for(int x = 1; x < width-1; x++){
    for(int y = 1; y < height-1; y++){
      // this formula is wrong!! FIXME
       next[x][y] = grid [x][y] + conductivity * laplace2(x,y);
    } 
  }
  
  loadPixels();
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
       color c = color(grid[x][y]*255, 50,(1-grid[x][y])*255);
       int loc = x + y * width;
       pixels[loc] = c;
    } 
  }
  updatePixels();
  println(grid[250][250]);
  swap();
}

void swap(){
  float[][] temp;
  temp = new float[width][height];
  grid = next;
  next = temp;
}

float laplace2(int x, int y){
  float lap2 = 0;
  lap2 = grid[x][y] * -3;
  lap2 += (grid[x][y+1] + grid[x][y-1] + grid[x+1][y] + grid[x-1][y]) * 0.5;
  lap2 += (grid[x+1][y+1] + grid[x-1][y+1] + grid[x+1][y-1] + grid[x-1][y-1]) * 0.25;
   
  return lap2;
}
