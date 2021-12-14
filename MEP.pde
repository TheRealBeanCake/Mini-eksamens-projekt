
void setup()
{
  String s = "Hej med dig haha";
 print(krypter(s));
 
}

String krypter(String input)
{
  char[] chars = new char[input.length()];
  
  for(int i = 0; i < input.length(); i++)
  {
    chars[i] = input.charAt(i);
  }
  
  int[] ints = new int[input.length()];
  
  for(int i = 0; i < input.length(); i++)
  {
   ints[i] = int(chars[i]) + 7;
    
  }
  
  char[] str = new char[input.length()];
  
  for(int i = 0; i < input.length(); i++)
  {
   str[i] = char(ints[i]);
 
  }
  
  return new String(str);
  
}



String dekrypter(String input)
{
  char[] chars = new char[input.length()];
  
  for(int i = 0; i < input.length(); i++)
  {
    chars[i] = input.charAt(i);
  }
  
  int[] ints = new int[input.length()];
  
  for(int i = 0; i < input.length(); i++)
  {
   ints[i] = int(chars[i]) - 7;
    
  }
  
  char[] str = new char[input.length()];
  
  for(int i = 0; i < input.length(); i++)
  {
   str[i] = char(ints[i]);
 
  }
  
  return new String(str);
  
}
