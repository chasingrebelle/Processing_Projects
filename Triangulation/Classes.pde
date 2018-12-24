class Point{
  PVector loc;
  Boolean isInTriangle;
  
  Point(PVector _loc){
    loc = _loc;
    isInTriangle = false;
  }
  
  void show(){
    point(loc.x, loc.y);
  }
}



class Circle{
  Point center;
  Float radius;
  
  Circle(Point c, float r){
    center = c;
    radius = r;
  }
  
  void show(){
    noFill();
    ellipse(center.loc.x, center.loc.y, 2*radius, 2*radius);
  }
}



class Segment{
  Point[] ends;
  Circle diametral;
  
  Segment(Point[] p){
    ends = new Point[2];
    ends = p;                                  
    diametral = new Circle(new Point(new PVector(0,0)),1);
    generateCircle();
  }
  
  void show(){
    line(ends[0].loc.x, ends[0].loc.y, ends[1].loc.x, ends[1].loc.y);
    //diametral.show();
  }
  
  void generateCircle(){
    float x1 = ends[0].loc.x;
    float x2 = ends[1].loc.x;
    float y1 = ends[0].loc.y;
    float y2 = ends[1].loc.y;
    
    diametral.center.loc.x = (x2 + x1)/2;
    diametral.center.loc.y = (y2 + y1)/2;
    diametral.radius = sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))/2;
  }
}



class Triangle{
  Point[] verteces;
  Segment[] sides;
  Circle circumcircle;
  
  Triangle(Point p, Point q, Point r){
    verteces = new Point[3];
    verteces[0] = p;
    verteces[1] = q;
    verteces[2] = r;
    for (Point v : verteces){
      v.isInTriangle = true;
    }
    sides = new Segment[3];
    circumcircle = new Circle(new Point(new PVector(0,0)),1);
    generateSegments();           //TODO generate circle
    generateCircle();
  }
  
  void show(){
    for(Point p : verteces){
      p.show();
    }
    for (Segment s : sides){
      s.show();
    }
    circumcircle.show();
  }
  
  void generateSegments(){
    Point[] p = new Point[2];
    Point[] q = new Point[2];
    Point[] r = new Point[2];
    p[0] = verteces[0];
    p[1] = verteces[1];
    sides[0] = new Segment(p);
    q[0] = verteces[1];
    q[1] = verteces[2];
    sides[1] = new Segment(q);
    r[0] = verteces[2];
    r[1] = verteces[0];
    sides[2] = new Segment(r);
  }
  
  void generateCircle(){
    
    float ax = verteces[0].loc.x;
    float ay = verteces[0].loc.y;
    float bx = verteces[1].loc.x;
    float by = verteces[1].loc.y;
    float cx = verteces[2].loc.x;
    float cy = verteces[2].loc.y;
    
    float d = 2*(ax*(by-cy)+bx*(cy-ay)+cx*(ay-by));
    
    float aa = ax*ax+ay*ay;
    float bb = bx*bx+by*by;
    float cc = cx*cx+cy*cy;   
    circumcircle.center.loc.x = (aa*(by-cy)+bb*(cy-ay)+cc*(ay-by))/d;
    circumcircle.center.loc.y = (aa*(cx-bx)+bb*(ax-cx)+cc*(bx-ax))/d;
    
    
    float abx = ax - bx;
    float aby = ay - by;
    float C = sqrt(abx * abx + aby * aby);
    float bcx = bx - cx;
    float bcy = by - cy;
    float A = sqrt(bcx * bcx + bcy * bcy);
    float cax = cx - ax;
    float cay = cy - ay;
    float B = sqrt(cax * cax + cay * cay);
    
    circumcircle.radius = (A*B*C) / sqrt((A+B+C)*(B+C-A)*(C+A-B)*(A+B-C));
  }
}
