class Particle{
  
  float[] x;
  float[] y;
  color c;
  
  Particle(){
    x = new float[savedPoints];
    y = new float[savedPoints];
    c = color(random(0,255), random(0,255), random(0,255));
    for(int i = 0; i < savedPoints; i++) {
        x[i] = width/2;
        y[i] = height/2;
      }
    }
  void move(){
    
    // Shift all elements 1 place to the left
    for(int i = 1; i < savedPoints; i++) {
      x[i-1] = x[i];
      y[i-1] = y[i];
    }
    // Put a new value at the end of the array
    x[savedPoints-1] += random(-range, range);
    y[savedPoints-1] += random(-range, range);

    // Wrap points
    if (x[savedPoints-1] < 0){
      x[savedPoints-1] += width;
    }
    if (x[savedPoints-1] > width){
      x[savedPoints-1] -= width;
    }
    if (y[savedPoints-1] < 0){
      y[savedPoints-1] += height;
    }
    if (y[savedPoints-1] > height){
      y[savedPoints-1] -= height;
    }
  }
  
  void show(){
    // Draw a line connecting the points
    float tempX;
    float tempY;
    for(int i = 1; i < savedPoints; i++) {    
      float alpha = float(i)/savedPoints * 204.0;
      stroke(c, alpha);
      strokeWeight(2);
      //if ((x[i-1] - x[i])*(x[i-1] - x[i]) <= range*range && 
      //(y[i-1] - y[i])*(y[i-1] - y[i]) <= range*range){
      //  line(x[i-1], y[i-1], x[i], y[i]);
      //}
      if ((x[i-1] - x[i])*(x[i-1] - x[i]) > range*range){
        // draw from old point to side and then from other side to new point
        continue;
      }
      if ((y[i-1] - y[i])*(y[i-1] - y[i]) > range*range){
        
        continue;
      }
      line(x[i-1], y[i-1], x[i], y[i]);
    }
    strokeWeight(2);
    point(x[savedPoints-1], y[savedPoints-1]);
  }
  
}
