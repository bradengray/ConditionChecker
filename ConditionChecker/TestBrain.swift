//
//  TestGrader.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/28/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import Foundation

class TestBrain: NSObject {
    private var test : Test? //Holds test property
    private var accumulatedAnswers : Double = 0 //Counts questions have been answered
    private var correctAnswers : Double = 0 //Counts questions that have been answered correctly
    
    //Mark: Initialization
    
    //This is a designated Initializer
    init(test: Test) {
        super.init()
        self.test = test
    }
    
    private var currentQuestion: Test.question? //Holds value of the current question being asked
    
    //Public funciton that returns a tuple containing a quesiton and a Bool value that indicates if the question is the last question in the test or not. This should not return a new question unless the last question has been answered
    func getQuestion()->(question: Test.question?, isLastQuestion: Bool) {
        
        //Set current question to equal test questions sub the number of questions already asked
        currentQuestion = self.test!.questions[Int(accumulatedAnswers)]
        
        //Set bool value that tells if this is the last question in the test or not
        let lastQuestion = self.test!.questions.count == Int(accumulatedAnswers) + 1 ? true : false
        
        return (self.currentQuestion, lastQuestion)
    }
    
    //Public function for returning an answer for the current question
    func userChoseAnswer(answer : String) {
        
        //Iterate over possible answers
        for questionAnswer in (self.currentQuestion?.answers)! {
            
            //Find the answer whose text matches the chosen answer
            if questionAnswer.text! == answer {
                
                //If that question is correct the increase the count of correct answers
                if questionAnswer.isCorrect! {
                    correctAnswers = correctAnswers + 1
                }
            }
        }
        accumulatedAnswers = accumulatedAnswers + 1
    }
    
    //Public function that returns the test score. This should not return a score more than 0 unless the text has been completed
    var results : Double {
        //If all question have been answered return the percentage that were correct
        if Int(accumulatedAnswers) == test?.questions.count {
            return correctAnswers/accumulatedAnswers * 100
        } else {
            return 0.0
        }
    }
}
