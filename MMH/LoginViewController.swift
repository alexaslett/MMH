//
//  LoginViewController.swift
//  MMH
//
//  Created by Alex Aslett on 9/12/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var touchIDButton: UIButton!
    
    @IBAction func touchIDLoginAction(_ sender: UIButton) {
    }
    let touchME = TouchIDAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1.jpg")!)
        
        touchIDButton.isHidden = !touchME.canEvaluatePolicy()
        
    }
    @IBAction func moveToTabBar(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
//    func wantToUseTouchID(){
//        let alertController = UIAlertController(title: "Secure your App", message: "Do you want to use TouchID to secure your data?", preferredStyle: .alert)
//        
//        
//    }
    
    
   
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
