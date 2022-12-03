//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Ольга Лазарчик on 3.12.22.
//

import Foundation

protocol QuestionFactoryProtocol {
    func requestNextQuestion() -> QuizQuestion?
}
