int savedPoints = 500;
int range = 10;
int parts = 10;

Particle[] particles = new Particle[parts];

float[] ax = new float[savedPoints];
float[] ay = new float[savedPoints]; 


void setup() 
{
  background(0);
  //size(800, 600);
  fullScreen();
  for (int i = 0; i < parts; i++){
    particles[i] = new Particle();
  }
  frameRate(40);
}

void draw() 
{
  
  
  for (Particle p : particles){
    for (int i = 0; i < 10; i++){
      p.move(); //<>// //<>//
    }
    p.show();
  }
}
