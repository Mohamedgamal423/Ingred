//
//  LoginVC.swift
//  ingred
//
//  Created by moh on 1/3/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var LogBtn: UIButton!
    @IBOutlet weak var LoginLbl: UILabel!
    @IBOutlet weak var GoodtoseeLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        EmailField.defaultsetup()
        PasswordField.defaultsetup()
        LogBtn.makegradient(grcolors: [#colorLiteral(red: 1, green: 0.5490196078, blue: 0.168627451, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.3882352941, blue: 0.1333333333, alpha: 1).cgColor])
        LogBtn.defaultsetup()
        LoginLbl.setcustomspace(space: 1.75)
        GoodtoseeLbl.setcustomspace(space: 1)
        EmailField.delegate = self
        PasswordField.delegate = self
        //navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem()
        navigationController?.makenavbarinvisible()
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func logclicked(_ sender: Any) {
        AuthService.instance.loginUser(email: EmailField.text!, password: PasswordField.text!) { (login, error) in
            if login {
                print("sucsessfully logined")
                let tabbarvc = self.storyboard?.instantiateViewController(identifier: "tab") as? UITabBarController
                tabbarvc?.modalPresentationStyle = .fullScreen
                self.present(tabbarvc!, animated: true, completion: nil)
                //self.performSegue(withIdentifier: "log", sender: nil)
                //self.navigationController?.popViewController(animated: true)
                //self.dismiss(animated: true, completion: nil)
            }
            else {
                print(String(describing: error?.localizedDescription))
            }
        }
    }
    
    
    

    

}
extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
        textField.text = nil
    }
}

