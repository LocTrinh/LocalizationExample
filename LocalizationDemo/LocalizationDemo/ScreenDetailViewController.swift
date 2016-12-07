//
//  ScreenDetailViewController.swift
//  LocalizationDemo
//
//  Created by Loc Trinh on 12/7/16.
//  Copyright © 2016 Trinh Loc. All rights reserved.
//

import UIKit

class ScreenDetailViewController: UIViewController {

    @IBOutlet weak var valueDesciption: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:#selector(ScreenDetailViewController.receiveLanguageChangedNotification(notification:)), name: NSNotification.Name(rawValue: kNotificationLanguageChanged), object: nil)
        configureViewFromLocalisation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureViewFromLocalisation() {
        self.navigationItem.title  = Localization(string: "TitleDetail")
        valueDesciption.text = Localization(string: "description")
    }
    
    // MARK: - Notification methods
    
    func receiveLanguageChangedNotification(notification:NSNotification) {
        configureViewFromLocalisation()
    }

}
