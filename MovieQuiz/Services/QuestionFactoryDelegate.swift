//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Ольга Лазарчик on 4.12.22.
//

import Foundation

protocol QuestionFactoryDelegate: class{
    
    
    func didRecieveNextQuestion (queistion: QuizQuestion?)
}
