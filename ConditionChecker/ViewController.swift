//
//  ViewController.swift
//  ConditionChecker
//
//  Created by Braden Gray on 10/28/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var nameTextField: UITextField!

    @IBOutlet private weak var idTextField: UITextField!
    
    @IBOutlet private weak var takeTestButton: UIButton!
    
    @IBOutlet var labels: [UILabel]! //Array holding label properties
    
    private var managedObjectContext : NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext //Holds context for CoreData
    
    //Mark : View Life Cycle
    
    //Setup views
    override internal func viewDidLoad() {
        for label in labels {
            label.textColor = ColorScheme.blueColor()
        }
        self.takeTestButton.backgroundColor = ColorScheme.blueColor()
    }
    
    // Mark UITextFieldDelegate Methods
    
    //If Id is entered make sure that it is unique and dismiss keyboard
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if textField == idTextField {
            _ = iDIsUnique()
        }
    }
    
    //If return pressed then dismiss keyboard
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Mark: TextField Helper Methods
    
    //Checks to make sure that the patient ID has not already been used for another patient
    private func iDIsUnique()->Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        if let persons = (try? managedObjectContext?.fetch(request)) as? Array<Person> {
            for person in persons {
                if person.unique! == idTextField.text {
                    alert(title: "This ID already exists please try another")
                    idTextField.text = ""
                    return false
                }
            }
        }
        return true
    }
    
    // Mark: Segue
    
    //Tells View whether to segue or not
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //If ID is not unique do not segue
        if !iDIsUnique() {
            return false
        }
        //If no text for name or ID do not segue and send alert
        if idTextField.text != "" && nameTextField.text != "" {
            return true
        } else {
            alert(title: "Please enter patient name and ID")
            return false
        }
    }
    
    //Prepares view controller for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let identifier = segue.identifier {
            switch identifier {
            case "Test":
                let vc = segue.destination as? TestViewController
                vc?.title = "\(constants.conditions.todds) Test"
                vc?.testInfo = [constants.info.patientNameKey : nameTextField.text, constants.info.patientIDKey : idTextField.text, constants.info.conditionKey : constants.conditions.todds]
                vc?.managedObjectContext = managedObjectContext
            default:
                break
            }
        }
    }
    
    //Mark: Alert Functions
    
    //Presents alert with a given title
    private func alert(title: String) {
        let alert = UIAlertController(title: "Alert!", message: title, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

