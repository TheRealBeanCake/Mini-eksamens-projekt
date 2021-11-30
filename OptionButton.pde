class OptionButton
{
  
  int radius;
  PVector position;
  boolean enabled;
  color EnabledColor = color(255,0,0);
  color DisabledColor = color(100, 100, 100);
  color HoverColor = color(180, 0, 0);

  boolean canClick = true;
  
  OptionButton(int radius, PVector position)
  {
    this.radius = radius;
    this.position = position;
    
  }
  
  
  void loop()
  {
    if(frameCount % 30 == 0)
    {
     canClick = true; 
    }
    
    color middleColor = DisabledColor;
    
    if(sqrt(pow(position.x-mouseX, 2)+pow(position.y-mouseY, 2)) < radius/2)
    {
     //Mouse hover
     
     if(!enabled)
     {
      middleColor = HoverColor;
     }
     
    }
    
    if(enabled)
    {
      middleColor = EnabledColor;
    }
    push();
    
    circle(position.x, position.y, radius);
    fill(middleColor);
   circle(position.x, position.y, radius * 0.85);
   
   pop();
  }
  
}
