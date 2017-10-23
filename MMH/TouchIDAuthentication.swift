//
//  TouchIDAuthentication.swift
//  MMH
//
//  Created by Alex Aslett on 9/12/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDAuth {
    
    
    let context = LAContext()
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func authenticateUser(completion: @escaping() -> Void) {
        
        guard canEvaluatePolicy() else {
            return
        }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Logging in with Touch ID") { (success, evaluateError) in
            
            if success {
                DispatchQueue.main.async {
                    completion()
                }
            } else {
                //Deal with the LAError cases
            }
        }
    }
    
    func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
        }
        return message
    }
    
    
    
    
}
