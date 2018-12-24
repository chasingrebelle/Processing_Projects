Boid[] birds;
int noBirds = 4;
float maxSpeed = 1;

void setup(){
  size(800,600);
  birds = new Boid[noBirds];
  for (int i = 0; i < noBirds; i++){
   birds[i] = new Boid();
  }
}

void draw(){
  background(0);
  for (Boid b : birds){
    b.move();
    b.show();
  }
}
