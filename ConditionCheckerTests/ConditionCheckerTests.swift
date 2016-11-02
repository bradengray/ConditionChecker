//
//  ConditionCheckerTests.swift
//  ConditionCheckerTests
//
//  Created by Braden Gray on 10/28/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import XCTest
@testable import ConditionChecker

class ConditionCheckerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatBrainGetsQuestions() {
        //Initialize test and testBrain
        let test = ToddsSyndromeTest()
        let testBrain = TestBrain.init(test: test)
        
        //Iterate through test question and make sure the test brain is returning the correct questions and that they are not the last question until the actual last question
        var accumulatedAnswers = 0
        while accumulatedAnswers < test.questions.count - 1 {
            let question = testBrain.getQuestion()
            XCTAssertEqual(question.question?.text, test.questions[accumulatedAnswers].text)
            XCTAssertFalse(question.isLastQuestion)
            testBrain.userChoseAnswer(answer: (question.question?.answers[0].text!)!)
            accumulatedAnswers = accumulatedAnswers + 1
        }
    
        let question = testBrain.getQuestion()
        XCTAssertEqual(question.question?.text, test.questions[3].text)
        XCTAssertTrue(question.isLastQuestion)
    }
    
    func testThatBrainGetsResultsOnlyWhenTestIsComplete() {
        //Initialize test and testBrain
        let test = ToddsSyndromeTest()
        let testBrain = TestBrain.init(test: test)

        //Give the correct answers for each question and check to make sure that the brain does not give a result until all the questions are answered
        var accumulatedAnswers = 0
        while accumulatedAnswers < test.questions.count {
            let question = testBrain.getQuestion()
            XCTAssertEqual(testBrain.results, 0)
            for answer in (question.question?.answers)! {
                if answer.isCorrect! {
                    testBrain.userChoseAnswer(answer: answer.text!)
                }
            }
            if accumulatedAnswers == test.questions.count - 1 {
                XCTAssertEqual(testBrain.results, 100)
            } else {
                XCTAssertEqual(testBrain.results, 0)
            }
            accumulatedAnswers = accumulatedAnswers + 1
        }
    }
    
    func testThatBrainGetsCorrectResults() {
        //Initialize test and testBrain
        let test = ToddsSyndromeTest()
        let testBrain = TestBrain.init(test: test)
        
        //Give the correct answers for half of the questions and check to make sure that the brain does not give a result until all the questions are answered
        var accumulatedAnswers = 0
        while accumulatedAnswers < test.questions.count {
            let question = testBrain.getQuestion()
            if accumulatedAnswers%2 == 0 {
                for answer in (question.question?.answers)! {
                    if answer.isCorrect! {
                        testBrain.userChoseAnswer(answer: answer.text!)
                    }
                }
            } else {
                for answer in (question.question?.answers)! {
                    if !answer.isCorrect! {
                        testBrain.userChoseAnswer(answer: answer.text!)
                    }
                }
            }
            accumulatedAnswers = accumulatedAnswers + 1
        }
        XCTAssertEqual(testBrain.results, 50)
    }
}
