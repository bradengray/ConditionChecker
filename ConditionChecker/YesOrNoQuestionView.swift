//
//  YesOrNoQuestionView.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/28/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import UIKit

class YesOrNoQuestionView: QuestionView {
    @IBOutlet weak var questionLabel : UILabel! //Public variable for setting question text

    @IBOutlet var answerButtons: [UIButton]! //Public variable holding buttons
    
    //Called when a button is touched
    @IBAction private func answerButtonTouched(_ sender: UIButton) {
        //Change alpha and notify delegate which answer was chosen
        sender.alpha = 0.7
        self.delegate?.answer(answer: sender.currentTitle!)
        for button in answerButtons {
            if button != sender {
                button.alpha = 1.0
            }
        }
    }
}
