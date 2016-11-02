//
//  QuestionView.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/29/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import UIKit

protocol QuestionViewDelegate {
    func answer(answer : String)
}

class QuestionView : UIView {
    var delegate : QuestionViewDelegate?
}
