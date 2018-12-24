QuadTree qtree;

void setup(){
  size(1000, 1000);
  Rectangle boundary = new Rectangle(width/2, height/2, width/2, height/2);
  qtree = new QuadTree(boundary, 4);
  for(int i = 0; i < 1000; i++){
    float x = randomGaussian() * width/6 + width/2;
    float y = randomGaussian() * height/6 + height/2;
    strokeWeight(4);
    Point p = new Point(x,y);
    qtree.insert(p);
  }
   //<>//
}

void draw(){
  background(0);
  qtree.show();
  stroke(0,255,0);
  rectMode(CENTER);
  Circle range = new Circle(mouseX,mouseY,50);
  strokeWeight(1);
  noFill();
  ellipse(range.x, range.y, range.r*2, range.r*2);
  ArrayList<Point> points = new ArrayList<Point>();
  points = qtree.query(range, points);
  
  strokeWeight(4);
  for (Point p : points){
    point(p.x, p.y); 
  }
}

void mousePressed(){
  Point p = new Point(mouseX+ random(-5,5), mouseY+ random(-5,5));
  qtree.insert(p);
  qtree.show();
}
