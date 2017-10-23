let defaults = UserDefaults.standard//
//  LoginViewController.swift
//  MMH
//
//  Created by Alex Aslett on 9/12/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import LocalAuthentication


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var touchIDButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.specialGray
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let useTouchID = UserDefaults.standard.bool(forKey: "useTouchID")
        if launchedBefore {
            if useTouchID {
                authWithTouchID()
            } else {
                self.navtoAuthVC()
            }
            
        } else {
            presentSecureAppOption()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    
    func presentSecureAppOption() {
        let alertController = UIAlertController(title: "Secure your App", message: "Do you want to use TouchID to secure your data?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "useTouchID")
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { (_) in
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "useTouchID")
            
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func touchIDButtonTapped(_ sender: Any) {
        authWithTouchID()
    }
    
    
    
    func showAlertViewAfterEvaluatingPolicyWithMessage(message: String) {
        showAlertWithTitle(title: "Error", message: message)
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
    
    func navtoAuthVC(){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBarController
        }
    }
    
    
    func showAlertViewForNoBiometrics() {
        showAlertWithTitle(title: "Error", message: "This device does not have a Touch ID sensor.")
    }
    
    func showAlertWithTitle(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func authWithTouchID() {
        let authContext = LAContext()
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Touch ID, Navigating to success VC, handling errors
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Only Humans Allowed.", reply: { (success, error) in
                
                if success {
                    // Naviaget to success VC
                    self.navtoAuthVC()
                } else {
                    // Changed this from the video
                    if let error = error as NSError? {
                        let message = self.errorMessageForLAErrorCode(errorCode: error.code)
                        self.showAlertViewAfterEvaluatingPolicyWithMessage(message: message)
                    }
                }
                
            })
        } else {
            showAlertViewForNoBiometrics()
            return
        }
    }
    
}
