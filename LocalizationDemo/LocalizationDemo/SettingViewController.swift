//
//  SettingViewController.swift
//  LocalizationDemo
//
//  Created by Trinh Loc on 12/6/16.
//  Copyright © 2016 Trinh Loc. All rights reserved.
//

import UIKit
import DLRadioButton

class SettingViewController: UIViewController {

   
    @IBOutlet weak var laguage: DLRadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func checked(_ sender: DLRadioButton) {
        print( (laguage.selected()?.titleLabel?.text) as Any)

    }
    

}
