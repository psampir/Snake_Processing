PVector[] snake_pos;
PVector apple_pos, before0, before1;
int snake_length, snake_length_next = 1, snake_speed = 5, points = 0;
String direction = "RIGHT";
boolean game_over = false, menu = true;

PVector move(String direction, PVector snake_pos) {
  if(direction == "UP") 
    snake_pos.y -= 20;
  else if (direction == "DOWN") 
    snake_pos.y += 20; 
  else if (direction == "LEFT") 
    snake_pos.x -= 20;
  else if (direction == "RIGHT")
    snake_pos.x += 20;
  return snake_pos;
}

boolean collision(PVector rect1, PVector rect2) {
  if(rect1.x == rect2.x && rect1.y == rect2.y) 
    return true;
  else
    return false;
}

void setup() {
  size(800, 800);
  snake_pos = new PVector[1000];
  snake_pos[0] = new PVector(0, height / 2);
  apple_pos = new PVector(180, 360);
}

void draw() {
  frameRate(snake_speed); 
  background(50, 170, 50);
  noStroke();
  
  snake_length = snake_length_next;
    
  // saving snake's previous positions
  for (int i = snake_length - 1; i > 0; i --) {
    snake_pos[i] = new PVector(snake_pos[i - 1].x, snake_pos[i - 1].y);
  }
  
  //if(frameCount % 2 == 1)
  //  before0 = new PVector(snake_pos[0].x, snake_pos[0].y);
  //else if (frameCount > 1)
  //  before1 = new PVector(snake_pos[0].x, snake_pos[0].y);
  
  // controls
  if(!game_over && !menu)
  {
    if(keyCode == UP && direction != "DOWN") 
      direction = "UP";
    if (keyCode == DOWN && direction != "UP") 
      direction = "DOWN"; 
    if (keyCode == LEFT && direction != "RIGHT") 
      direction = "LEFT";
    if (keyCode == RIGHT && direction != "LEFT") 
      direction = "RIGHT";
  }
    
  snake_pos[0] = move(direction, snake_pos[0]); // moving the snake
  print("Frame: " + frameCount + "\n");
  
  // checking window boundaries
  if(snake_pos[0].x >= width) 
    snake_pos[0].x = 0;
  if(snake_pos[0].y >= height) 
    snake_pos[0].y = 0;
  if(snake_pos[0].x < 0) 
    snake_pos[0].x = width;
  if(snake_pos[0].y < 0) 
    snake_pos[0].y = height;
    
  // checking collisions
  if(collision(snake_pos[0], apple_pos)) {
    snake_length_next = snake_length + 1;
    snake_speed ++;
    points ++;
    apple_pos = new PVector(int(random(0, 40)) * 20, int(random(0, 40)) * 20);
  } else {
    snake_length_next = snake_length;
  }
  
  //if(key == 'x') game_over = true;
  //if(key == 'w') game_won = true;
  
  //if(frameCount > 2 && snake_length > 1 && (collision(snake_pos[0], before0) || collision(snake_pos[0], before1))){
  //  print("xd\n");
  //  game_over = true;
  //}
  
  for(int i = 1; i < snake_length; i ++) {
    if(collision(snake_pos[0], snake_pos[i])) {
      game_over = true;
      print("Snake pos" + i + ": " + snake_pos[i] + "\n");
    }
      
  }
  
  // drawing on screen
  if(!menu) {
    textAlign(CENTER, CENTER);
    fill(255, 255, 255, 200);
    textSize(30);
    text("Points: " + points, 60, 20);
  }
  
  fill(255, 255, 0);
  for (int i = 0; i < snake_length; i ++){
    rect(snake_pos[i].x, snake_pos[i].y, 20, 20); // draw snake
    print("Snake pos " + i + ": "  + snake_pos[i] + "\n");
    
  }
  print("\n");
  
  print("direction: " + direction);
  
  fill(255, 0, 0);
  rect(apple_pos.x, apple_pos.y, 20, 20); // draw apple
  
  if(menu) {
    textSize(150);
    fill(255, 255, 0);
    text("SNAKE", width / 2, height / 2 - 60);
    fill(255);
    textSize(50);
    text("Hold SPACE to start", width / 2 , height / 2 + 40);
    textSize(30);
    text("Move using arrows", width /2 , height / 2 + 120);
    
    textSize(20);
    text("v1.0.1", width / 2 + 180, height / 2 - 120);
    
    text("Made by Paweł Sampir (2024)", width / 2, height - 20);
    
    if(keyPressed && key == ' '){
      menu = false;
      apple_pos = new PVector(int(random(0, 40)) * 20, int(random(0, 40)) * 20);
    }
  
  }
  
  if(game_over) {
     background(255, 0, 0);
     textSize(100);
     fill(255);
     text("GAME OVER", width / 2, height / 2 - 30);
     print(" GAME OVER!\n");
     move(" ", snake_pos[0]);
     textSize(50);
     
     if(key == ' '){
       game_over = false;
       snake_length_next = 1;
       points = 0;
       snake_speed = 5;
       move("RIGHT", snake_pos[0]);
       snake_pos[0] = new PVector(0, height/2);
     }
     text("Points: " + points, width / 2, height / 2 + 40);
       
  }
}
