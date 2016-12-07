//
//  PropertyViewController.swift
//  LocalizationDemo
//
//  Created by Loc Trinh on 12/7/16.
//  Copyright © 2016 Trinh Loc. All rights reserved.
//

import UIKit

class PropertyViewController: UIViewController {


    @IBOutlet weak var setting: UIButton!
    @IBOutlet weak var detail: UIButton!
    
    //Locale.current.languageCode
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:#selector(PropertyViewController.receiveLanguageChangedNotification(notification:)), name: NSNotification.Name(rawValue: kNotificationLanguageChanged), object: nil)
        
       configureViewFromLocalisation()
        
    }
    func configureViewFromLocalisation() {
        self.navigationItem.title  = Localization(string: "Title")
        setting.setTitle(Localization(string: "Setting"), for: UIControlState.normal)
        detail.setTitle(Localization(string: "Detail"), for: UIControlState.normal)
    }
    
    // MARK: - Notification methods
    
    func receiveLanguageChangedNotification(notification:NSNotification) {
        configureViewFromLocalisation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
