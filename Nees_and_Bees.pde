//Nees and Bees
//6/2/20
//Elliot Shapiro

int frame,max_frames;

int rows,columns;
float stroke_weight,box_side_length,box_spacing;
float start_x,start_y;

float[] motion;

void setup()
{
  size(700,700);
  frameRate(25);
  smooth(8);
  
  frame = 0;
  max_frames = 50;
  
  rows = 11;
  columns = 6;
  
  stroke_weight = 5;
  box_side_length = 40;
  box_spacing = 10;
  
  start_x = columns*(box_side_length+box_spacing)-box_spacing;
  start_x /= -2;
  start_x += width/2;
  start_y = 30;
  
  motion = new float[2];
  //x_offset
  motion[0] = map(random(1),0,1,-100,100);
  //y_offset
  motion[1] = map(random(1),0,1,-100,100);
}

void draw()
{
  float t = (float)frame/max_frames;
  
  background(200);
  
  stroke(0);
  strokeWeight(stroke_weight);
  noFill();
  
  for(int y=0;y<rows;y++)
  {
    for(int x=0;x<columns;x++)
    {
      push();
      
      //translate to box start location
      translate(
        start_x + x*(box_side_length+box_spacing),
        start_y + y*(box_side_length+box_spacing));
      
      //translate motion offset
      translate(
        map(t,0,1,0,motion[0]),
        map(t,0,1,0,motion[1]));
      
      rect(0,0,box_side_length,box_side_length);
      pop();
    }
  }
  
  frame++;
  if(frame==max_frames)frame=0;
}
