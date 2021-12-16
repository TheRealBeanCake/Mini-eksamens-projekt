ArrayList<Question> questions = new ArrayList<Question>();

Question currentQuestion;
int currentQuestionIdx = 0;

PVector questionPos = new PVector(750,927/2);
int optionsY = 700;
int optionsBorder = 150;
int totalTime;
PVector timeTextPos = new PVector(100, 100);
PVector questionTextPos = new PVector(1500 - 100, 100);
ArrayList<OptionButton> optionButtons = new ArrayList<OptionButton>();
int optionButtonRadius = 50;

PVector nextQuestionButtonSize = new PVector(150, 75);
PVector nextQuestionButton = new PVector(750, 130);

PVector doneButtonSize = new PVector(150, 75);
PVector doneButton = new PVector(1300, 200);

String timeText = "";

int[] answerList;
int correctAnswers = 0;

Textboks slutBoks;

boolean inQuiz;


//Question
String[] split_linei;
String run_quest;
int run_ans;
String run_opt;
String[] options; 
String file_read1 = "spørgsmål_del1.txt"; //file that contains questions+answers
String file_read2 = "spørgsmål_del2.txt"; //file that contains questions+answers
String[] file1;
String[] file2;
//

//Save_score
//eleven har ikke nogen måde at angive sit navn...
String[] write_this;
String file_write = "write.txt"; //file that writes name and scores


void settings()
{
  size(1500, 927);
  slutBoks = new Textboks(new PVector(525, 600), new PVector(450,100), "");
}

void setup()
{
  frameRate(30);
  
  inQuiz = true;
  
  //Questions
  file1 = loadStrings(file_read1); 
  for (int i = 0; i < file1.length; i++)
  {
    split_linei = split(file1[i], ';');
    
    //reads question
    run_quest = split_linei[1].substring(1, split_linei[1].length()-1);
    
    //reads answer
    run_ans = int(split_linei[3])-1;
    
    //reads options
    run_opt = split_linei[5];
    options = split(run_opt, '_');
    
    questions.add(new Question(run_quest, options, run_ans));
  }
  
  file2 = loadStrings(file_read2); 
  for (int i = 0; i < file2.length; i++)
  {
    split_linei = split(file2[i], ';');
    
    //reads question
    run_quest = split_linei[1].substring(1, split_linei[1].length()-1);
    
    //reads answer
    run_ans = int(split_linei[3])-1;
    
    //reads options
    run_opt = split_linei[5];
    options = split(run_opt, '_');
    
    questions.add(new Question(run_quest, options, run_ans));
  }
  //
  
  
  answerList = new int[questions.size()];
  
  SetQuestion(0);
  
}

void draw()
{
  clear();
  
  
  
  
  if(inQuiz == true)
  {
    ShowQuestion();
  
  
  if(frameCount % 30 == 0)
  {
    totalTime += 1;
  }
  
  textSize(60);
  textAlign(CENTER);
  int sec = totalTime % 60;
  int min = floor(((float)totalTime / 60));
  boolean secAddZero = false;
  if(sec < 10)
  {
    secAddZero = true;
  }
  boolean minAddZero = false;
  if(min < 10)
  {
    minAddZero = true;
  }
  
  if(secAddZero)
  {
    timeText = "" + min + ":0" + sec;
  }
  if(minAddZero)
  {
    timeText = "0" + min + ":" + sec;
  }
  if(minAddZero && secAddZero)
  {
    timeText = "0" + min + ":0" + sec;
  }
  if(!minAddZero && !secAddZero)
  {
   timeText = "" + min + ":" + sec;
  }
  
  
  text(timeText, timeTextPos.x, timeTextPos.y);  
  text((currentQuestionIdx + 1) + "/" + questions.size(), questionTextPos.x, questionTextPos.y);
  
  for(int i = 0; i < optionButtons.size(); i++)
  {
    optionButtons.get(i).loop();
  }
  
  color c = color(133,133,133);
  
  if(mouseX > nextQuestionButton.x - nextQuestionButtonSize.x && mouseX < nextQuestionButton.x + nextQuestionButtonSize.x && mouseY > nextQuestionButton.y - nextQuestionButtonSize.y && mouseY < nextQuestionButton.y + nextQuestionButtonSize.y)
  {
   //hover
   int ans = -1;

  for(int i = 0; i < optionButtons.size(); i++)
  {
   if(optionButtons.get(i).enabled)
   {
     ans = i;
     break;
   }
  }
      if(ans != -1)
      {
        c = color(200,200,200);
      }
   
  }
  
  push();
  fill(c);
  rectMode(RADIUS);
  rect(nextQuestionButton.x, nextQuestionButton.y, nextQuestionButtonSize.x, nextQuestionButtonSize.y, 10);
  fill(255,255,255);
  textAlign(CENTER);
  text("Next", nextQuestionButton.x, nextQuestionButton.y + 20);
  pop();
  }
  else
  {
    //end screen
    textAlign(CENTER);
  text("Score: " + correctAnswers + "/" + questions.size(), width/2, height/2);
  textSize(60);
  textAlign(CENTER);
  int sec = totalTime % 60;
  int min = floor(((float)totalTime / 60));
  boolean secAddZero = false;
  if(sec < 10)
  {
    secAddZero = true;
  }
  boolean minAddZero = false;
  if(min < 10)
  {
    minAddZero = true;
  }
  String timeText = "";
  
  if(secAddZero)
  {
    timeText = "" + min + ":0" + sec;
  }
  if(minAddZero)
  {
    timeText = "0" + min + ":" + sec;
  }
  if(minAddZero && secAddZero)
  {
    timeText = "0" + min + ":0" + sec;
  }
  if(!minAddZero && !secAddZero)
  {
   timeText = "" + min + ":" + sec;
  }
  
  
  text("time used: " + timeText, width/2, height/2-200);  
  
  text("Navn", 750, 575);
  slutBoks.Draw();
  
  color c = color(133,133,133);
  
  if(mouseX > doneButton.x - doneButtonSize.x && mouseX < doneButton.x + doneButtonSize.x && mouseY > doneButton.y - doneButtonSize.y && mouseY < doneButton.y + doneButtonSize.y)
  {
    c = color(200,200,200);
  }
  
  push();
  fill(c);
  rectMode(RADIUS);
  rect(doneButton.x, doneButton.y, doneButtonSize.x, doneButtonSize.y, 10);
  fill(255,255,255);
  textAlign(CENTER);
  text("Færdig", doneButton.x, doneButton.y + 20);
  pop();
  
  }
  
  
}

void StartGame()
{
  
}

void keyPressed()
{
 slutBoks.KeyPress(); 
}

  void mouseClicked()
  {
    slutBoks.Pressed();
    
    if(mouseX > nextQuestionButton.x - nextQuestionButtonSize.x && mouseX < nextQuestionButton.x + nextQuestionButtonSize.x && mouseY > nextQuestionButton.y - nextQuestionButtonSize.y && mouseY < nextQuestionButton.y + nextQuestionButtonSize.y)
    {
     int ans = -1;

  for(int i = 0; i < optionButtons.size(); i++)
  {
   if(optionButtons.get(i).enabled)
   {
     ans = i;
     break;
   }
  }
      if(ans != -1)
      {
        NextQuestion();
      }
      
    }
    
    for(int i = 0; i < optionButtons.size(); i++)
    {
      if(sqrt(pow(optionButtons.get(i).position.x-mouseX, 2)+pow(optionButtons.get(i).position.y-mouseY, 2)) < optionButtons.get(i).radius/2)
    {
     if(optionButtons.get(i).canClick == true)
     {
       optionButtons.get(i).enabled = !optionButtons.get(i).enabled; 
       optionButtons.get(i).canClick = false;
     }
      
 
   int idxC = i;
   
   for(int z = 0; z < optionButtons.size(); z++)
   {
    
    if(optionButtons.get(z).enabled == true && idxC != z)
    {
     optionButtons.get(z).enabled = false; 
    }
    
   }
 
    }
    
    }
    
    if(mouseX > doneButton.x - doneButtonSize.x && mouseX < doneButton.x + doneButtonSize.x && mouseY > doneButton.y - doneButtonSize.y && mouseY < doneButton.y + doneButtonSize.y)
    {
    //Færdig
    
    if(slutBoks.text.length() > 0)
    {
      //DONE
      
      
      
      //writes to file
      write_this = new String[]{krypter(slutBoks.text + "," + str(correctAnswers) + "," + str(questions.size()) + ',' + timeText)};
      saveStrings(file_write, write_this);
      //
      
      println(dekrypter(krypter(slutBoks.text + "," + str(correctAnswers) + "," + str(questions.size()) + ',' + timeText)));
      
      exit();
    }
    else
    {
    //INTET NAVN
    
    return;
    }
    
    }
  }

void NextQuestion()
{
  int ans = -1;

  for(int i = 0; i < optionButtons.size(); i++)
  {
   if(optionButtons.get(i).enabled)
   {
     ans = i;
     break;
   }
  }
  
  answerList[currentQuestionIdx] = ans;
 
  if(currentQuestionIdx + 1 >= questions.size())
  {
   //quiz done 
   println("done");
   int c = 0;
   for(int i = 0; i < questions.size(); i++)
   {
    if(questions.get(i).correctAnswerIndex == answerList[i])
    {
      c++;
    }
   }
   
   correctAnswers = c;
   
   inQuiz = false;
  }
  else
  {
   //next question 
   currentQuestionIdx++;
  SetQuestion(currentQuestionIdx);
  }
  
}

void SetQuestion(int idx)
{
  currentQuestion = questions.get(idx);
  
  optionButtons.clear();
  
  int n = currentQuestion.options.length;
  println(n);
  int deltaX = (width - optionsBorder*2)/(n-1);
  
  for(int i = 0; i < currentQuestion.options.length; i++)
  {
    optionButtons.add(new OptionButton(optionButtonRadius, new PVector(optionsBorder + deltaX*i, optionsY + optionButtonRadius + 30)));
  }
  
}

void ShowQuestion()
{
  //Viser currentQuestion
  
  textSize(28);
    textAlign(CENTER);
  String[] c_questsplit = split(currentQuestion.questionText,'.');
   
   //skubber linjen 40 pixels ned, for hver punktum (så alle sætninger ikke står på samme linje)
   for(int i = 0; i < c_questsplit.length; i++)
   {
     text(c_questsplit[i], questionPos.x, questionPos.y+i*40);
   }

  
  int n = currentQuestion.options.length;
  int deltaX = (width - optionsBorder*2)/(n-1);
  
  for(int i = 0; i < n; i++)
   {
     textSize(24);
    textAlign(CENTER);
  text(currentQuestion.options[i], optionsBorder + deltaX*i, optionsY);
   }
  
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
