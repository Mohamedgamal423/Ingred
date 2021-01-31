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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.makenavbarinvisible()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit.png"), style: .plain, target: self, action: #selector(logoutUser))
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
    }
    @objc func logoutUser() {
        do {
            try Auth.auth().signOut()
            presentingViewController?.dismiss(animated: true, completion: nil)
            
            
        }
        catch {
            debugPrint(error.localizedDescription)
        }
        
        
    }
    
    



}
