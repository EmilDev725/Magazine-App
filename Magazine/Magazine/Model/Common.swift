//
//  Common.swift
//  Magazine
//
//  Created by iOSpro on 26/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import Foundation
import UIKit

class Common {
    func createTextField() -> UITextField{
        let tf : UITextField = UITextField()
        tf.frame = CGRect(x: 0, y: 0, width: Main_Screen_Width - 200, height: 60)
        tf.text = "Time"
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.textColor = UIColor.red
        return tf
    }
    
    func createTextView() -> UITextView{
        let tf : UITextView = UITextView()
        tf.frame = CGRect(x: 0, y: 0, width: Main_Screen_Width - 200, height: 60)
        tf.text = "Time"
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.textColor = UIColor.red
        return tf
    }
    
    func collectThemeComponentsFromXib(index : Int) -> Template{
        let temp = Template()
//        let themeName = "Theme" + String(index)
        let themeName = UIDevice.current.userInterfaceIdiom == .pad ? "Theme" + String(index) + "_ipad" : "Theme" + String(index)
        
        let themeView = UINib(nibName: themeName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        for component in themeView.subviews[0].subviews{
            component.removeConstraints(component.constraints)
            if component is UIImageView{
                temp.images.append(component as! UIImageView)
            }
            else if component is THLabel{
                if index == 5 && (component as! THLabel).text!.lowercased() == "people"{
                    (component as! THLabel).strokeColor = UIColor(red: 123/255, green: 213/255, blue: 239/255, alpha: 1)
                    (component as! THLabel).strokeSize = 6
                }
                if index == 4 && (component as! THLabel).text!.lowercased() == "supersexy"{
                    (component as! THLabel).strokeColor = UIColor(red: 171/255, green: 112/255, blue: 115/255, alpha: 1)
                    (component as! THLabel).strokeSize = 1.5
                }
                temp.textViews.append(component as! THLabel)
            }
        }
        return temp
    }
    
    func findLocationOfComponent(frame : CGRect) -> CGRect{
        if IS_IPHONE_5{
            let position_x = frame.origin.x * 251 / 306
            let position_y = frame.origin.y * 415 / 514
            let width = frame.width * 251 / 306
            let height = frame.height * 415 / 514
            let rect : CGRect = CGRect(x: position_x, y: position_y, width: width, height: height)

            return rect
        }
        else if IS_IPHONE_6{
        }
        else if IS_IPHONE_6PLUS{
            let position_x = frame.origin.x * 345 / 306
            let position_y = frame.origin.y * 583 / 514
            let width = frame.width * 345 / 306
            let height = frame.height * 583 / 514
            let rect : CGRect = CGRect(x: position_x, y: position_y, width: width, height: height)
            
            return rect
        }
        else if IS_IPAD_1{

        }
        else if IS_IPAD_2{
            let position_x = frame.origin.x * 691 / 625
            let position_y = frame.origin.y * 857 / 769
            let width = frame.width * 691 / 625
            let height = frame.height * 857 / 769
            let rect : CGRect = CGRect(x: position_x, y: position_y, width: width, height: height)
            
            return rect
        }
        return frame
    }
}

extension UIViewController {
    // extension for keyboard dismiss by tapping screen
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
