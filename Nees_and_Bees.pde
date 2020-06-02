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
  
  motion = new float[3];
  //x offset
  motion[0] = map(random(1),0,1,-100,100);
  //y offset
  motion[1] = map(random(1),0,1,-100,100);
  //rotation offset
  motion[2] = map(random(1),0,1,-PI,PI);
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
      
      //add translation motion
      translate(
        map(t,0,1,0,motion[0]),
        map(t,0,1,0,motion[1]));
      
      //translate to box start location
      translate(
        start_x + x*(box_side_length+box_spacing),
        start_y + y*(box_side_length+box_spacing));
      
      //translate to 0,0
      translate(box_side_length/2,box_side_length/2);
      
      //add rotation motion
      rotate(map(t,0,1,0,motion[2]));
      
      rect(-box_side_length/2,-box_side_length/2,box_side_length,box_side_length);
      pop();
    }
  }
  
  frame++;
  if(frame==max_frames)frame=0;
}
