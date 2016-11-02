//
//  TestViewController.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/28/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import UIKit
import CoreData

class TestViewController: UIViewController, QuestionViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    private var questionView : YesOrNoQuestionView?
    private var resultsView : TestResultsView?
    private var testBrain : TestBrain?
    @IBOutlet weak var nextButton: UIButton!
    private var readyToEnd = false
    
    var managedObjectContext : NSManagedObjectContext? 
    
    var testInfo: Dictionary<String, Any?>?
  
    // Mark: ViewLifeCycle
    
    override internal func viewDidLoad() {
        if let resultsView = Bundle.main.loadNibNamed("ResultsView", owner: self, options: nil)?.first as? TestResultsView {
            self.containerView.addSubview(resultsView)
            self.setUpNewSubView(view: resultsView)
            self.resultsView = resultsView
        }
        
        if let questionView = Bundle.main.loadNibNamed("YesOrNoView", owner: self, options: nil)?.first as? YesOrNoQuestionView {
            self.containerView.addSubview(questionView)
            self.setUpNewSubView(view: questionView)
            questionView.delegate = self
            self.questionView = questionView
        }

        self.nextButton.isEnabled = false
        self.nextButton.alpha = 0.7
        var test : Test?
        if testInfo?["condition"] as! String == "Todd's Syndrome"{
            test = ToddsSyndromeTest()
        }
        self.testBrain = TestBrain(test: test!)
        self.setUpQuestionView()
        self.questionView?.questionLabel.textColor = ColorScheme.navyColor()
        for button in (self.questionView?.answerButtons)! {
            button.backgroundColor = ColorScheme.blueColor()
        }
        self.nextButton.backgroundColor = ColorScheme.blueColor()
    }
    
    //Mark: Set Up
    
    private func setUpNewSubView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["view" : view]))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["view" : view]))
    }
    
    private func setUpQuestionView() {
        let newQuestion = self.testBrain?.getQuestion()
        self.questionView?.questionLabel.text = newQuestion?.question?.text
        let buttons = self.questionView?.answerButtons!
        for button in (buttons)! {
            let answers = newQuestion?.question?.answers
            button.setTitle(answers?[(buttons?.index(of: button))!].text!, for: UIControlState.normal)
            button.alpha = 1.0
        }
    }
    
    //Mark: Button
    
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        self.testBrain?.userChoseAnswer(answer: currentAnswer!)
        if !readyToEnd {
            let newQuestion = self.testBrain?.getQuestion()
            if (newQuestion?.isLastQuestion)! {
                readyToEnd = true
                self.nextButton.setTitle("Get Results", for: UIControlState.normal)
            }
            setUpQuestionView()
            UIView.transition(with: self.questionView!, duration: 1.0, options: UIViewAnimationOptions.transitionCurlUp, animations: nil, completion: nil)
            self.nextButton.isEnabled = false
            self.nextButton.alpha = 0.7
        } else {
            let results = self.testBrain?.results
            self.resultsView?.resultsLabel.text = "The patient has a \(results!)% probability of having Todd's Syndrome"
            UIView .transition(from: self.questionView!, to: self.resultsView!, duration: 1.0, options: UIViewAnimationOptions.transitionCurlUp, completion: nil)
            testInfo?[constants.resultsKey] = results
            updateDataBase()
            nextButton.isEnabled = false
        }
    }
    
    //Mark DataBase
    
    private func updateDataBase() {
        _ = ConditionTest.conditionTestForInfo(info: testInfo!, inNSManagedObjectContext:managedObjectContext!)
        do {
            try managedObjectContext?.save()
        } catch let error {
            print("Core Data Error: \(error)")
        }
    }
    
    //Mark : QuestionViewDelegate
    
    private var currentAnswer : String?
    
    func answer(answer: String) {
        self.nextButton.isEnabled = true
        self.nextButton.alpha = 1.0
        currentAnswer = answer
    }
}
