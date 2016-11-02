//
//  TestPicker.swift
//  ConditionChecker
//
//  Created by Braden Gray on 11/2/16.
//  Copyright © 2016 Graycode. All rights reserved.
//

import Foundation

class TestPicker : NSObject {
    
    //This class keeps us from having to create more views in our story board It should return the subclass of test that you desire. I did not add this functionality to the app yet, but I did add this structure just in case more tests were added in the future.
    class func getTestSubclassForCondition (condition: String) ->Test? {
        switch condition {
        case constants.conditions.todds:
            return ToddsSyndromeTest()
        default:
            return nil
        }
    }
}
