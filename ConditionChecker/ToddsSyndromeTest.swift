//
//  ToddsSyndromeTest.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/28/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import Foundation

class ToddsSyndromeTest: Test {
    
    //Mark: Initialization
    override init() {
        super.init()
        //Create questions for this Subclass
        self.questions = [
            question(text: "What is the patient's sex?", answers: [answer(text: "Male", isCorrect: true), answer(text:"Female", isCorrect: false)]),
            question(text: "Is the patient more than 15 years old?", answers: [answer(text: "Yes", isCorrect: true), answer(text:"No", isCorrect: false)]),
            question(text: "Has the patient ever taken hallucinogens?", answers: [answer(text:"Yes", isCorrect: true), answer(text:"No", isCorrect: false)]),
            question(text: "Has the patient ever suffered from migraines?", answers: [answer(text:"Yes", isCorrect: true), answer(text:"No", isCorrect: false)])]
    }
}
