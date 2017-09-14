//
//  TouchIDAuthentication.swift
//  MMH
//
//  Created by Alex Aslett on 9/12/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
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
    
}
