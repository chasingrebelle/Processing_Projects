ArrayList<Point> points;
ArrayList<Segment> lines;
ArrayList<Triangle> triangles;
int noP = 3;

void setup(){
  background(0);
  size(600, 400);
  points = new ArrayList<Point>();
  for (int i = 0; i < noP; i++){
    PVector loc = new PVector(random(width), random(height));
    points.add(new Point(loc));
  }
  triangles = new ArrayList<Triangle>();
  makeTriangle(points.get(0), points.get(1), points.get(2));
}

void draw(){
  stroke(255); //<>//
  strokeWeight(1);
  for (Point p : points){
    p.show();
  }
  for (Triangle t : triangles){
    t.show();
  }
}

void choosePoints(){
  
}

void makeTriangle(Point a, Point b, Point c){
  if (a.isInTriangle & b.isInTriangle & c.isInTriangle){
    return;
  }else{
    triangles.add(new Triangle(a,b,c));
  }
}
