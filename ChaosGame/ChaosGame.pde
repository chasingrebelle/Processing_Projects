int noSeeds = 5;
float percent = 0.5;

Point currentPoint;
Point newPoint;
int index;
int oldIndex = -1;
int olderIndex = -1;

Point[] seeds = new Point[noSeeds];


void setup(){
  fullScreen();
  background(0);
  //size(800,600);
  
  currentPoint = new Point(random(width), random(height));
  
  generateSeeds();
}

void draw(){
  //stroke(255,50);
  
  for (int i = 0; i < 1000; i++){
    newPoint = nextPoint(currentPoint);
    newPoint.show();
    currentPoint = newPoint;
  }
  
}



void generateSeeds(){
  float x;
  float y;
  float r = height/2;
  
  for (int i = 0; i < noSeeds; i++){
    strokeWeight(8);
    x = r * cos(-PI/2 + TWO_PI * i / noSeeds) + width/2;
    y = r * sin(-PI/2 + TWO_PI * i / noSeeds) + height/2;
    seeds[i] = new Point(x, y);
    seeds[i].show();
  }
  
}


Point nextPoint(Point p){
  
  index = int(random(seeds.length));
  
  if(abs(oldIndex - index) != 0){
    float newX = lerp(p.x, seeds[index].x, percent);
    float newY = lerp(p.y, seeds[index].y, percent);
    
    Point point = new Point(newX, newY);
    olderIndex = oldIndex;
    oldIndex = index;
    stroke(255*index/noSeeds,0,255 * (1-index/noSeeds), 50);
    return point;
  }else{
    return p;
  }
}
