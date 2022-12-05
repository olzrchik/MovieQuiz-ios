//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Ольга Лазарчик on 4.12.22.
//

import Foundation

protocol QuestionFactoryProtocol {
    
    var delegate: QuestionFactoryDelegate? { get set }
    
    func requestNextQuestion()
}
