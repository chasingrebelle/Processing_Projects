int totalBalls = 2000;
Ball[] balls = new Ball[totalBalls];
float targetX, targetY;
int width, height;
float drag = 0.9;
 
void setup() {
  size(600, 600);
    width = 600;
    height = 600;
    noStroke();
    smooth();
    background(0);
    targetX = width / 2;
    targetY = height / 2;
    fill(color(255, 0, 0));
    for (int i = 0; i < totalBalls; i++) {
        Ball ball = new Ball();
        ball.x = random(width);
        ball.y = random(height);
        ball.vx = random(4) - 2;
        ball.vy = random(4) - 2;
        balls[i] = ball;
    }
};
 
void draw() {
    background(0);
    fill(color(255, 0, 0));
    for (int i = 0; i < totalBalls; i++) {
        balls[i].move();
        balls[i].render();
    }
    for (int i = 0; i < totalBalls; i++) {
        for (int j = i + 1; j < totalBalls; j++) {
            float dx = balls[j].x - balls[i].x;
            float dy = balls[j].y - balls[i].y;
            float dist = sqrt(dx * dx + dy * dy);
            if (dist < (balls[j].radius + balls[i].radius)) {
                // balls have contact so push back...
                float normalX = dx / dist;
                float normalY = dy / dist;
                float midpointX = (balls[i].x + balls[j].x) / 2;
                float midpointY = (balls[i].y + balls[j].y) / 2;
                balls[i].x = midpointX - normalX * balls[i].radius;
                balls[i].y = midpointY - normalY * balls[i].radius;
                balls[j].x = midpointX + normalX * balls[j].radius;
                balls[j].y = midpointY + normalY * balls[j].radius;
                float dVector = (balls[i].vx - balls[j].vx) * normalX;
                dVector += (balls[i].vy - balls[j].vy) * normalY;
                float dvx = dVector * normalX;
                float dvy = dVector * normalY;
                balls[i].vx -= dvx * drag;
                balls[i].vy -= dvy * drag;
                balls[j].vx += dvx * drag;
                balls[j].vy += dvy * drag;
            }
        }
    }
    //println(frameRate);
};
 

 
class Ball {
  float x = 0;
  float y = 0;
  float vx = 0;
  float vy = 0;
  float maxSpeed = 10;
  float gravityX = 0;
  float gravityY = 0.1;
  float radius = 5;
  float forceX = 0;
  float forceY = 0;
  
  
  
  void move(){
    float ax = forceX + gravityX;
    float ay = forceY + gravityY;
    vx = constrain((vx + ax) * drag, -maxSpeed, maxSpeed);
    vy = constrain((vy + ay) * drag, -maxSpeed, maxSpeed);
    x += vx;
    y += vy;
    checkWallCollision();
  }
 
   void checkWallCollision() {
    if (x < radius) {
        x = radius;
        vx *= -drag;
    }     if (x > width - (radius)) {
        x = width - (radius);
        vx *= -drag;
    }     if (y < radius) {
        y = radius;
        vy *= -drag;
    }     if (y > height - (radius)) {
        y = height - (radius);
        vy *= -drag;
    }
}
 
  void render() {
      ellipse(this.x, this.y, this.radius * 2, this.radius * 2);
  }
}
