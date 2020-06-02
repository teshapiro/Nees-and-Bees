//Nees and Bees
//6/2/20
//Elliot Shapiro

int rows,columns;
float stroke_weight,square_side_length,square_spacing;
float start_x,start_y;

void setup()
{
  size(700,700);
  frameRate(25);
  smooth(8);
  
  rows = 11;
  columns = 6;
  
  stroke_weight = 5;
  square_side_length = 40;
  square_spacing = 10;
  
  start_x = columns*(square_side_length+square_spacing)-square_spacing;
  start_x /= -2;
  start_x += width/2;
  start_y = 30;
}

void draw()
{
  background(200);
  
  stroke(0);
  strokeWeight(stroke_weight);
  noFill();
  
  for(int y=0;y<rows;y++)
  {
    for(int x=0;x<columns;x++)
    {
      push();
      translate(
        start_x + x*(square_side_length+square_spacing),
        start_y + y*(square_side_length+square_spacing));
      rect(0,0,square_side_length,square_side_length);
      pop();
    }
  }
}
