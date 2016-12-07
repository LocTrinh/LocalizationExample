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
        let current = Localisator.sharedInstance.currentLanguage
        if (current == "vi") {
            laguage.otherButtons[0].isSelected = true
        } else {
            laguage.isSelected = true
        }
        
        self.navigationItem.title  = Localization(string: "Setting")
        languageDevice.text = Locale.current.languageCode
        lbIosDevice.text = Localization(string: "labelLangueDevie")
        lblLanguage.text =  Localization(string: "LangueDevie")//Localization(string: "Setting")
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
                    let _ = SetLanguage(language: "vi")
                default:
                    let _ = SetLanguage(language: "en")
                    
                }
            }
        }

    }
    

}
