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

   
    @IBOutlet weak var languageDevice: UILabel!
    @IBOutlet weak var lbIosDevice: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var laguage: DLRadioButton!
    let arrayLanguages = Localisator.sharedInstance.getArrayAvailableLanguages()
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:#selector(SettingViewController.receiveLanguageChangedNotification(notification:)), name: NSNotification.Name(rawValue: kNotificationLanguageChanged), object: nil)
        
    
        
        configureViewFromLocalisation()
    }

    func configureViewFromLocalisation() {
        self.navigationItem.title  = Localization(string: "Setting")
        languageDevice.text = Localization(string: "LangueDevie")
        lbIosDevice.text = Localization(string: "labelLangueDevie")
        lblLanguage.text = Locale.current.languageCode //Localization(string: "Setting")
    }
    
    // MARK: - Notification methods
    
    func receiveLanguageChangedNotification(notification:NSNotification) {
        configureViewFromLocalisation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checked(_ sender: DLRadioButton) {

        if let laguageSelected =  laguage.selected() {
            if let value = laguageSelected.titleLabel?.text {
                switch value {
                case "English":
                    let _ = SetLanguage(language: "en")
                case "Vietnam":
                    let _ = SetLanguage(language: "vn")
                default:
                    let _ = SetLanguage(language: "en")
                    
                }
            }
        }

    }
    

}
