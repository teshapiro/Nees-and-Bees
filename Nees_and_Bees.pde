//Nees and Bees
//6/3/20
//Elliot Shapiro

int frame,max_frames;

int rows,columns;
float stroke_weight,box_side_length,box_spacing;
float start_x,start_y;

//[group][column][row][value(0 = x offset, 1 = y offset, 2 = rotation offset)]
float[][][][] motion;

//length of cues in frames
int cue1_length,cue2_length,cue3_length,cue4_length;
//length of time in frames for a row of boxes
//  to make its transformation motion
int row_motion_length;

void setup()
{
  size(700,700);
  frameRate(25);
  smooth(8);
  
  cue1_length = 30;
  cue2_length = 30;
  cue3_length = 30;
  cue4_length = 30;
  row_motion_length = 10;
  
  frame = 0;
  max_frames = cue1_length+cue2_length+cue3_length+cue4_length;
  
  rows = 11;
  columns = 6;
  
  stroke_weight = 5;
  box_side_length = 40;
  box_spacing = 10;
  
  start_x = columns*(box_side_length+box_spacing)-box_spacing;
  start_x /= -2;
  start_x += width/2;
  start_y = 30;
  
  motion = new float[3][columns][rows][3];
  for(int group=0;group<3;group++)
  {
    for(int y=0;y<rows;y++)
    {
      //easing keeps the upper rows a bit more tidy
      float y_easing = pow(map(y,0,rows-1,0,1),2);
      //set maximum transformations for this row
      float max_translation = lerp(0,100,y_easing);
      float max_rotation = lerp(0,PI,y_easing);
      
      for(int x=0;x<columns;x++)
      {
        //x offset
        motion[group][x][y][0] = map(random(1),0,1,-max_translation,max_translation);
        //y offset
        motion[group][x][y][1] = map(random(1),0,1,0,max_translation);
        //rotation offset
        motion[group][x][y][2] = map(random(1),0,1,-max_rotation,max_rotation);
      }
    }
  }
}

void draw()
{
  background(255);
  
  //Cues
  //Cue 1: move to random position
  if(frame < cue1_length)
  {
    //internal cue frame counter
    int cue1_frame = frame;
    for(int y=0;y<rows;y++)
    {
      //what frame of cue1_frame this row starts moving
      int row_start_frame = (cue1_length-row_motion_length)/rows * y;
      
      float t;
      if(cue1_frame < row_start_frame)
        {t = 0;}
      else if(cue1_frame < row_start_frame+row_motion_length)
        {t = (float)(cue1_frame-row_start_frame)/row_motion_length;}
      else
        {t = 1;}
      
      drawBoxes(0,y,t);
      drawBoxes(1,y,t);
      drawBoxes(2,y,t);
    }
  }
  
  //Cue 2: hold position
  else if(frame < cue1_length+cue2_length)
  {
    for(int y=0;y<rows;y++)
    {
      drawBoxes(0,y,1);
      drawBoxes(1,y,1);
      drawBoxes(2,y,1);
    }
  }
  
  //Cue 3: move back to starting positions
  else if(frame < cue1_length+cue2_length+cue3_length)
  {
    //internal cue frame counter
    int cue3_frame = frame-cue1_length-cue2_length;
    for(int y=0;y<rows;y++)
    {
      //what frame of cue1_frame this row starts moving
      int row_start_frame = (cue3_length-row_motion_length)/rows * y;
      
      float t;
      if(cue3_frame < row_start_frame)
        {t = 1;}
      else if(cue3_frame < row_start_frame+row_motion_length)
        {t = 1 - (float)(cue3_frame-row_start_frame)/row_motion_length;}
      else
        {t = 0;}
      
      drawBoxes(0,y,t);
      drawBoxes(1,y,t);
      drawBoxes(2,y,t);
    }
  }
  
  //Cue 4: hold position
  else
  {
    for(int y=0;y<rows;y++)
    {
      drawBoxes(0,y,0);
      drawBoxes(1,y,0);
      drawBoxes(2,y,0);
    }
  }
  
  frame++;
  if(frame==max_frames)frame=0;
}

//draws a row of boxes
void drawBoxes(int group, int y, float t)
{
  stroke((2-group)*50);
  strokeWeight(stroke_weight);
  noFill();

  for(int x=0;x<columns;x++)
  {
    push();
    
    //add translation motion
    translate(
      map(t,0,1,0,motion[group][x][y][0]),
      map(t,0,1,0,motion[group][x][y][1]));
    
    //translate to box start location
    translate(
      start_x + x*(box_side_length+box_spacing),
      start_y + y*(box_side_length+box_spacing));
    
    //translate to 0,0
    translate(box_side_length/2,box_side_length/2);
    
    //add rotation motion
    rotate(map(t,0,1,0,motion[group][x][y][2]));
    
    rect(-box_side_length/2,-box_side_length/2,box_side_length,box_side_length);
    pop();
  }
}
