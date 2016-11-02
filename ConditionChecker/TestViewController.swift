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
    
    @IBOutlet weak var containerView: UIView! //Contianer view holds question or results views
    private var questionView : YesOrNoQuestionView? //Holds question view
    private var resultsView : TestResultsView? //Hold test results view
    private var testBrain : TestBrain? //Holds testBrain Object
    @IBOutlet private weak var nextButton: UIButton!
    private var readyToEnd = false //Lets function know that the test is ready to end
    
    var managedObjectContext : NSManagedObjectContext? //Required for CoreData
    
    var testInfo: Dictionary<String, Any?>? //Required for CoreData
  
    // Mark: ViewLifeCycle
    
    //Do all view controller setup
    override internal func viewDidLoad() {
        
        //Create views from nib and add to containter view
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
        
        //Set up Button and create test object
        self.nextButton.isEnabled = false
        self.nextButton.alpha = 0.7
        //var test : Test?
       // if testInfo?["condition"] as! String == "Todd's Syndrome"{
          //  test = ToddsSyndromeTest()
       // }
        
        //Create test Brain and set up question view
        self.testBrain = TestBrain(test: TestPicker.getTestSubclassForCondition(condition: testInfo?[constants.info.conditionKey] as! String)!)
        self.setUpQuestionView()
        self.questionView?.questionLabel.textColor = ColorScheme.navyColor()
        for button in (self.questionView?.answerButtons)! {
            button.backgroundColor = ColorScheme.blueColor()
        }
        self.nextButton.backgroundColor = ColorScheme.blueColor()
    }
    
    //Mark: Set Up
    
    //Sets up constraints for nibs
    private func setUpNewSubView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["view" : view]))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: UInt(0)), metrics: nil, views: ["view" : view]))
    }
    
    //Sets up question view to display new question
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
    
    //Called when next button is touched
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        
        //Set new answer
        self.testBrain?.userChoseAnswer(answer: currentAnswer!)
        
        if !readyToEnd {
            //Get new question
            let newQuestion = self.testBrain?.getQuestion()
            //If last question change next button title
            if (newQuestion?.isLastQuestion)! {
                readyToEnd = true
                self.nextButton.setTitle("Get Results", for: UIControlState.normal)
            }
            //Set up the question view and transition
            setUpQuestionView()
            UIView.transition(with: self.questionView!, duration: 1.0, options: UIViewAnimationOptions.transitionCurlUp, animations: nil, completion: nil)
            //Disable next button
            self.nextButton.isEnabled = false
            self.nextButton.alpha = 0.7
        } else {
            //Setup results view and present it
            let results = self.testBrain?.results
            self.resultsView?.resultsLabel.text = "The patient has a \(results!)% probability of having Todd's Syndrome"
            UIView .transition(from: self.questionView!, to: self.resultsView!, duration: 1.0, options: UIViewAnimationOptions.transitionCurlUp, completion: nil)
            testInfo?[constants.info.resultsKey] = results
            updateDataBase()
            nextButton.isEnabled = false
        }
    }
    
    //Mark DataBase
    
    //Stores test and patient info into CoreData
    private func updateDataBase() {
        _ = ConditionTest.conditionTestForInfo(info: testInfo!, inNSManagedObjectContext:managedObjectContext!)
        do {
            try managedObjectContext?.save()
        } catch let error {
            print("Core Data Error: \(error)")
        }
    }
    
    //Mark : QuestionViewDelegate
    
    //Holds value of current answer this allows users to change answers before next button is touched
    private var currentAnswer : String?
    
    //Returned when user answers on the question view
    func answer(answer: String) {
        self.nextButton.isEnabled = true
        self.nextButton.alpha = 1.0
        currentAnswer = answer
    }
}
