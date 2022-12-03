import UIKit

final class MovieQuizViewController: UIViewController {
    //MARK: - vars
    private let questionsAmount: Int = 10
    private let questionFactory: QuestionFactoryProtocol = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    
    
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0
    private var countOfSessions: Int = 0
    private var biggesNumberOfRightAnsers:Int = 0
    
    // MARK: - IB
    @IBOutlet private var noButtonOutlet: UIButton!
    @IBOutlet private var yesButtonOutlet: UIButton!
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        noButtonOutlet.isEnabled = false
        guard let currentQuestion = currentQuestion else {
            return
        }
        showAnswerResult(isCorrect: false == currentQuestion.correctAnswer )
    }
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        yesButtonOutlet.isEnabled = false
        guard let currentQuestion = currentQuestion else {
            return
        }
        showAnswerResult(isCorrect: true == currentQuestion.correctAnswer )
    }
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    
  
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstQuestion = questionFactory.requestNextQuestion() {
            currentQuestion = firstQuestion
            let viewModel = convert(model: firstQuestion)
            show(quiz: viewModel)
        }    }

 
    
    //MARK: - funcs
    private func showAnswerResult(isCorrect:Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            if self.imageView.layer.borderColor == UIColor.ypGreen.cgColor {
                self.correctAnswers += 1
            }
            self.showNextQuestionOrResults()
            self.noButtonOutlet.isEnabled = true
            self.yesButtonOutlet.isEnabled = true
        }
        
    }
    
    private  func show(quiz step: QuizStepViewModel) {
        counterLabel.text = step.questionNumber
        textLabel.text = step.question
        imageView.image = step.image
    }
    
    private  func show(quiz rezult: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: rezult.title,
            message: rezult.text,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: rezult.buttonText,
                                   style: .default) { [weak self] _ in
            guard let self = self else { return }
            print("clicked")
            self.currentQuestionIndex = 0
            if let firstQuestion = self.questionFactory.requestNextQuestion() {
                self.currentQuestion = firstQuestion
                let viewModel = self.convert(model: firstQuestion)
                
                self.show(quiz: viewModel)
            }
              
        }
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    private func showNextQuestionOrResults(){
        if currentQuestionIndex == questionsAmount - 1{
            countOfSessions += 1
            
            if correctAnswers > biggesNumberOfRightAnsers {
            biggesNumberOfRightAnsers = correctAnswers
            }
            let text = "Ваш результат: \(correctAnswers)/\(questionsAmount) \n Количество сыгранных квизов: \(countOfSessions) \n Рекорд: \(biggesNumberOfRightAnsers)/\(questionsAmount)"
            let newViewModel =  QuizResultsViewModel(title: "Этот раунд окончен!", text: text, buttonText: "Сыграть еще раз")
            show(quiz: newViewModel)
            correctAnswers = 0
            imageView.layer.borderWidth = 0
         
        } else {
            imageView.layer.borderWidth = 0
            if let nextQuestion = questionFactory.requestNextQuestion() {
                currentQuestion = nextQuestion
                let viewModel = convert(model: nextQuestion)
                
                show(quiz: viewModel)
            }
                    }
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel{
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1) / \(questionsAmount) "
        )
        
    }
}

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
