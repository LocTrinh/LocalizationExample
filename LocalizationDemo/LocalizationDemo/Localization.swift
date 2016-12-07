//
//  Localization.swift
//  LocalizationDemo
//
//  Created by Trinh Loc on 12/6/16.
//  Copyright © 2016 Trinh Loc. All rights reserved.
//

import Foundation

let kNotificationLanguageChanged        = "kNotificationLanguageChanged";

func Localization(string:String) -> String{
    return Localisator.sharedInstance.localizedStringForKey(key: string)
}

func SetLanguage(language:String) -> Bool {
    return Localisator.sharedInstance.setLanguage(language)
}


class Localisator {
    
    // MARK: - Private properties
    
    private let userDefaults                    = UserDefaults.standard
    private var availableLanguagesArray         = ["DeviceLanguage", "en", "vn"]
    private var dicoLocalisation:NSDictionary!
    
    
    private let kSaveLanguageDefaultKey         = "kSaveLanguageDefaultKey"
    
    // MARK: - Public properties
    
    var currentLanguage                         = "DeviceLanguage"
    
    // MARK: - Public computed properties
    
    var saveInUserDefaults:Bool {
        get {
            return (userDefaults.object(forKey: kSaveLanguageDefaultKey) != nil)
        }
        set {
            if newValue {
                userDefaults.set(currentLanguage, forKey: kSaveLanguageDefaultKey)
            } else {
                userDefaults.removeObject(forKey: kSaveLanguageDefaultKey)
            }
            userDefaults.synchronize()
        }
    }
    
    
    // MARK: - Singleton method
    
    class var sharedInstance :Localisator {
        struct Singleton {
            static let instance = Localisator()
        }
        return Singleton.instance
    }
    
    // MARK: - Init method
    init() {
        if let languageSaved = userDefaults.object(forKey: kSaveLanguageDefaultKey) as? String {
            if languageSaved != "DeviceLanguage" {
                let _ = loadDictionaryForLanguage(languageSaved)
            }
        }
    }
    
    // MARK: - Public custom getter
    
    func getArrayAvailableLanguages() -> [String] {
        return availableLanguagesArray
    }
    
    
    // MARK: - Private instance methods
    
    private func loadDictionaryForLanguage(_ newLanguage:String) -> Bool {
        
        //let arrayExt = newLanguage.components(separatedBy: "_")
        if let path = Bundle(for:object_getClass(self)).url(forResource: "Localizable", withExtension: "strings", subdirectory: nil, localization: newLanguage)?.path {
            if FileManager.default.fileExists(atPath: path) {
                currentLanguage = newLanguage
                dicoLocalisation = NSDictionary(contentsOfFile: path)
                return true
            }
        }
        return false
    }
    
    public func localizedStringForKey(key:String) -> String {
        
        if let dico = dicoLocalisation {
            if let localizedString = dico[key] as? String {
                return localizedString
            }  else {
                return key
            }
        } else {
            return NSLocalizedString(key, comment: key)
        }
    }
    
    public func setLanguage(_ newLanguage:String) -> Bool {
        
        if (newLanguage == currentLanguage) || !availableLanguagesArray.contains(newLanguage) {
            return false
        }
        
        if newLanguage == "DeviceLanguage" {
            currentLanguage = newLanguage
            dicoLocalisation = nil
            // Post notification
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationLanguageChanged), object: nil)
            return true
        } else if loadDictionaryForLanguage(newLanguage) {
            NotificationCenter.default.post(name:NSNotification.Name(rawValue: kNotificationLanguageChanged), object: nil)
            if saveInUserDefaults {
                userDefaults.set(currentLanguage, forKey: kSaveLanguageDefaultKey)
                userDefaults.synchronize()
            }
            return true
        }
        return false
    }
}
