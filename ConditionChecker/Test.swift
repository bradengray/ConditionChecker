//
//  Test.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/28/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import Foundation

class Test: NSObject {
    var questions = Array<question>() //Array of struct questions
    
    //Answer struct holds answer text as sting and Bool telling if answer is the correct answer for a question or not
    struct answer {
        var text: String?
        var isCorrect: Bool?
    }
    
    //Question struct holds the text for the question as well as an array of possible answers
    struct question {
        var text: String
        var answers: Array<answer>
    }
}
