//
//  SignupVC.swift
//  ingred
//
//  Created by moh on 1/3/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var SignupBtn: UIButton!
    @IBOutlet weak var SignLbl: UILabel!
    @IBOutlet weak var NiceLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignupBtn.makegradient(grcolors: [#colorLiteral(red: 1, green: 0.5490196078, blue: 0.168627451, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.3882352941, blue: 0.1333333333, alpha: 1).cgColor])
        SignupBtn.defaultsetup()
        NameField.defaultsetup()
        EmailField.defaultsetup()
        PasswordField.defaultsetup()
        SignLbl.setcustomspace(space: 1.75)
        NiceLbl.setcustomspace(space: 1)
        navigationController?.makenavbarinvisible()
        NameField.delegate = self
        EmailField.delegate = self
        PasswordField.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem()
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func signbtnclicked(_ sender: Any) {
        AuthService.instance.SigninUser(withemail: EmailField.text!, password: PasswordField.text!) { (succeded, signinerror) in
            if succeded {
                AuthService.instance.loginUser(email: self.EmailField.text!, password: self.PasswordField.text!) { (success, nil) in
                    if success {
                        print("Successsfully logined...")
                        let tabbarvc = self.storyboard?.instantiateViewController(identifier: "tab") as? UITabBarController
                        tabbarvc?.modalPresentationStyle = .fullScreen
                        self.present(tabbarvc!, animated: true, completion: nil)
                        //self.performSegue(withIdentifier: "me", sender: nil)
                        
                    }
                    
                }
                
                //self.performSegue(withIdentifier: "me", sender: nil)
                
            }
            else {
                print(String(describing: signinerror?.localizedDescription))
            }
        }
    }
    
    

}
extension SignupVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
    }
}
