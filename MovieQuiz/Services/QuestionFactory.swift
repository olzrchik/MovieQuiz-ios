//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Ольга Лазарчик on 2.12.22.
//

import Foundation

class QuestionFactory : QuestionFactoryProtocol{
    
    func requestNextQuestion() -> QuizQuestion? {                       // 1
        guard let index = (0..<questions.count).randomElement() else {  // 2
            return nil
        }
        return questions[safe: index]                           // 3
    }
    
    
    private  let questions:[QuizQuestion] = [QuizQuestion(image: "The Godfather", text:  "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
                                      QuizQuestion(image: "The Dark Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
                                      QuizQuestion(image: "Kill Bill", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
                                      QuizQuestion(image: "The Avengers", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
                                      QuizQuestion(image: "Deadpool", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
                                      QuizQuestion(image: "The Green Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
                                      QuizQuestion(image: "Old", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
                                      QuizQuestion(image: "The Ice Age Adventures of Buck Wild", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
                                      QuizQuestion(image: "Tesla", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
                                      QuizQuestion(image: "Vivarium", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false)
  ]
      
}
