//
//  ProfileVC.swift
//  ingred
//
//  Created by moh on 1/8/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit
import Firebase
class ProfileVC: UIViewController {

    @IBOutlet weak var currentUseremaillbl: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var logout: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.makenavbarinvisible()
        getemail()
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
    }
    
    @IBAction func logoutUser() {
        do {
            try Auth.auth().signOut()
            //dismiss(animated: true, completion: nil)
        }
        catch {
            debugPrint(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func getemail() {
        if let email = Auth.auth().currentUser?.email {
            currentUseremaillbl.text = email
        }
    }
    
}




