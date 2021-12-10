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

int[] answerList;
int correctAnswers = 0;

Textboks slutBoks;

boolean inQuiz;

void settings()
{
  size(1500, 927);
  slutBoks = new Textboks(new PVector(525, 600), new PVector(450,100), "");
}

void setup()
{
  frameRate(30);
  
  inQuiz = true;
  
  questions.add(new Question("[Spørgsmål]", new String[] {"svar1","svar2","svar3"}, 1));
  questions.add(new Question("1+1=x2 [Question2]", new String[] {"121","322","324"}, 1));
  questions.add(new Question("Er kaj sej ????? [Question3]", new String[] {"ja","nope","ok","ok","ok","ok","ok"}, 1));
  
  
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
  int deltaX = (width - optionsBorder*2)/(n-1);
  
  for(int i = 0; i < currentQuestion.options.length; i++)
  {
    optionButtons.add(new OptionButton(optionButtonRadius, new PVector(optionsBorder + deltaX*i, optionsY + optionButtonRadius + 30)));
  }
  
}

void ShowQuestion()
{
  //Viser currentQuestion
  
  textSize(100);
    textAlign(CENTER);
  text(currentQuestion.questionText, questionPos.x, questionPos.y);
  
  int n = currentQuestion.options.length;
  int deltaX = (width - optionsBorder*2)/(n-1);
  
  for(int i = 0; i < n; i++)
   {
     textSize(60);
    textAlign(CENTER);
  text(currentQuestion.options[i], optionsBorder + deltaX*i, optionsY);
   }
  
}
