//
//  QuestionView.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/29/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import UIKit

//Delegate for Question View
protocol QuestionViewDelegate {
    //Notifies delegate that a question has been answered
    func answer(answer : String)
}

class QuestionView : UIView {
    //Holds delegate object
    var delegate : QuestionViewDelegate?
}
