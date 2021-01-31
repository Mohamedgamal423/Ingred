//
//  ViewController.swift
//  ingred
//
//  Created by moh on 12/31/19.
//  Copyright © 2020 moh. All rights reserved.
//

import UIKit

class SignloginVC: UIViewController {

    @IBOutlet weak var LogBtn: UIButton!
    @IBOutlet weak var Donthaveaccountlbl: UILabel!
    @IBOutlet weak var SignupBtn: UIButton!
    @IBOutlet weak var IngredLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LogBtn.makegradient(grcolors: [#colorLiteral(red: 1, green: 0.5490196078, blue: 0.168627451, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.3882352941, blue: 0.1333333333, alpha: 1).cgColor])
        LogBtn.defaultsetup()
        SignupBtn.defaultsetup()
        SignupBtn.makewhitebtn()
        IngredLbl.setcustomspace(space: 1.75)
        Donthaveaccountlbl.setcustomspace(space: 1)
        self.navigationItem.leftBarButtonItem = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.png"), style: .plain, target: nil, action: nil)
        navigationController?.makenavbarinvisible()
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }


}

