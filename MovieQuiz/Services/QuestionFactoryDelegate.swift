//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Ольга Лазарчик on 3.12.22.
//

import Foundation

protocol QuestionFactoryDelegate: class {                   // 1
    func didRecieveNextQuestion(question: QuizQuestion?)   // 2
} 
