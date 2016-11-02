//
//  TestGrader.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/28/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import Foundation

class TestBrain: NSObject {
    private var test : Test?
    private var accumulatedAnswers : Double = 0
    private var correctAnswers : Double = 0
    
    init(test: Test) {
        super.init()
        self.test = test
    }
    
    private var currentQuestion: Test.question?
    
    func getQuestion()->(question: Test.question?, isLastQuestion: Bool) {
        currentQuestion = self.test!.questions[Int(accumulatedAnswers)]
        let lastQuestion = self.test!.questions.count == Int(accumulatedAnswers) + 1 ? true : false
        return (self.currentQuestion, lastQuestion)
    }
    
    func userChoseAnswer(answer : String) {
        for questionAnswer in (self.currentQuestion?.answers)! {
            if questionAnswer.text! == answer {
                if questionAnswer.isCorrect! {
                    correctAnswers = correctAnswers + 1
                }
            }
        }
        accumulatedAnswers = accumulatedAnswers + 1
    }
    
    var results : Double {
        if Int(accumulatedAnswers) == test?.questions.count {
            return correctAnswers/accumulatedAnswers * 100
        } else {
            return 0.0
        }
    }
}
