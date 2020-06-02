//Nees and Bees
//6/2/20
//Elliot Shapiro

int frame,max_frames;

int rows,columns;
float stroke_weight,box_side_length,box_spacing;
float start_x,start_y;

float[][][] motion;

//length of cues
int cue1,cue2,cue3,cue4;

void setup()
{
  size(700,700);
  frameRate(25);
  smooth(8);
  
  cue1 = 50;
  cue2 = 20;
  cue3 = 50;
  cue4 = 20;
  
  frame = 0;
  max_frames = cue1+cue2+cue3+cue4;
  
  rows = 11;
  columns = 6;
  
  stroke_weight = 5;
  box_side_length = 40;
  box_spacing = 10;
  
  start_x = columns*(box_side_length+box_spacing)-box_spacing;
  start_x /= -2;
  start_x += width/2;
  start_y = 30;
  
  motion = new float[columns][rows][3];
  for(int y=0;y<rows;y++)
  {
    //set maximum transformations for this row
    float max_translation = map(y,0,rows-1,0,100);
    float max_rotation = map(y,0,rows-1,0,PI);
    
    for(int x=0;x<columns;x++)
    {
      //x offset
      motion[x][y][0] = map(random(1),0,1,-max_translation,max_translation);
      //y offset
      motion[x][y][1] = map(random(1),0,1,-max_translation,max_translation);
      //rotation offset
      motion[x][y][2] = map(random(1),0,1,-max_rotation,max_rotation);
    }
  }
}

void draw()
{
  float t = (float)frame/max_frames;
  
  //Cues
  //move to random position
  if(frame < cue1)
    {t = (float)frame/cue1;}
  //hold position
  else if(frame < cue1+cue2)
    {t = 1;}
  //move back to starting positions
  else if(frame < cue1+cue2+cue3)
    {t = 1-(float)(frame-cue1-cue2)/cue3;}
  //hold position
  else
    {t = 0;}
  
  background(200);
  drawBoxes(t);
  
  frame++;
  if(frame==max_frames)frame=0;
}

void drawBoxes(float t)
{
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
        map(t,0,1,0,motion[x][y][0]),
        map(t,0,1,0,motion[x][y][1]));
      
      //translate to box start location
      translate(
        start_x + x*(box_side_length+box_spacing),
        start_y + y*(box_side_length+box_spacing));
      
      //translate to 0,0
      translate(box_side_length/2,box_side_length/2);
      
      //add rotation motion
      rotate(map(t,0,1,0,motion[x][y][2]));
      
      rect(-box_side_length/2,-box_side_length/2,box_side_length,box_side_length);
      pop();
    }
  }
}
