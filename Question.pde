class Question
{
 
  String questionText;
  String[] options;
  int correctAnswerIndex;
  
  Question(String questionText, String[] options, int correctAnswerIndex)
  {
    this.questionText = questionText;
    this.options = options;
    this.correctAnswerIndex = correctAnswerIndex;
  }
  
}
