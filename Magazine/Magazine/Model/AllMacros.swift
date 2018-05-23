//
//  AllMacros.swift
//  Magazine
//
//  Created by iOSpro on 26/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = (UIApplication.shared.delegate! as! AppDelegate)
let userdefaults = UserDefaults.standard

let KEY_FULLVERSION = "com.haavard.mk.fullversion"
let IAP_FULLVERSION = "mm_maker_fullversion"

let GAD_APPID = "ca-app-pub-2932155161891037~4866258035"
let GAD_BANNER_ID = "ca-app-pub-2932155161891037/8862532732"
let GAD_INTERSTITIAL_ID = "ca-app-pub-2932155161891037/1147694248"

let templates = [Template]()
var selectedTemplate = Template()
let common = Common()

var currentProject : Project?
let sqlManager : SQLiteManager = SQLiteManager()

var allProjects = [Project]()

var rect_Container : CGRect?

var selectedFontName : String = ""

var selectedSavingStyle = 0

var selectedTextContent : String = ""
var selectedFontSize = 0

let IS_IPAD = (UI_USER_INTERFACE_IDIOM() == .pad)
let IS_IPHONE = (UI_USER_INTERFACE_IDIOM() == .phone)

let Main_Screen_Height = UIScreen.main.bounds.size.height
let Main_Screen_Width = UIScreen.main.bounds.size.width
let SCREEN_MAX_LENGTH = (max(Main_Screen_Width, Main_Screen_Height))
let SCREEN_MIN_LENGTH = (min(Main_Screen_Width, Main_Screen_Height))
let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6PLUS = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
//let IS_IPHONE_10 = (IS_IPHONE && SCREEN_MAX_LENGTH > 736.0)
let IS_IPAD_1 = (IS_IPAD && SCREEN_MAX_LENGTH == 1024.0)
let IS_IPAD_2 = (IS_IPAD && SCREEN_MAX_LENGTH == 1366.0)

let Editor_Width_iPhone = Main_Screen_Width - 69
let Editor_Height_iPhone = Main_Screen_Height - 153

let Editor_Width_iPad = Main_Screen_Width - 143
let Editor_Height_iPad = Main_Screen_Height - 255

// Alerts
let kNoticeUnSavedText = "Are you sure you want to go back? All unsaved progress will be lost"

