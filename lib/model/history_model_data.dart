class QuizModel {
  final int totalQuestions = 5;
  final int rightAnswers = 2;
  final int wrongAnswers = 3;

  final List<String> questions = [
    'Lassi paratha and mixed vegetables are staple food of which states?',
    'Another question goes here.',
    'And one more question for variety.',
    'Yet another interesting question.',
    'Last question for the quiz.'
  ];

  final List<List<String>> options = [
    ['A: Gujarat', 'B: Maharashtra', 'C: Rajasthan', 'D: Punjab'],
    ['A: Option A', 'B: Option B', 'C: Option C', 'D: Option D'],
    ['A: abc', 'B: def', 'C: jkl', 'D: xyz'],
    ['A: Apple', 'B: Banana', 'C: Mango', 'D: Orange'],
    ['A: january', 'B: February', 'C: march', 'D: april'],
  ];
}
