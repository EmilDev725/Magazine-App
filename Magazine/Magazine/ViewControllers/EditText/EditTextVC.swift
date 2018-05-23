//
//  EditTextVC.swift
//  Magazine
//
//  Created by iOSpro on 22/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit

class EditTextVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var txt_content: UITextView!
    @IBOutlet weak var lbl_Preview: THLabel!
    
    var activatedText : THLabel?
    var img_magazine : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_content.text = activatedText?.text
//        txt_content.textColor = activatedText?.textColor
        txt_content.delegate = self
        self.hideKeyboardWhenTappedAround()
        txt_content.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedFontName != ""{
            let textSize = txt_content?.font?.pointSize
            txt_content?.font = UIFont(name: selectedFontName, size: textSize!)
            txt_content.textColor = activatedText?.textColor
            txt_content.font = activatedText?.font
            
            txt_content.layer.shadowOpacity = 0.4
            txt_content.layer.shadowOffset = CGSize(width: 3, height: 3)
            
//            lbl_Preview.text = activatedText?.text
//            lbl_Preview.font = activatedText?.font
//            lbl_Preview.textColor = activatedText?.textColor
//            lbl_Preview.backgroundColor = activatedText?.backgroundColor
//            lbl_Preview.shadowBlur = (activatedText?.shadowBlur)!
//            lbl_Preview.textAlignment = (activatedText?.textAlignment)!
//            lbl_Preview.shadowOffset = (activatedText?.shadowOffset)!
//            lbl_Preview.shadowColor = activatedText?.shadowColor
//            lbl_Preview.strokeSize = (activatedText?.strokeSize)!
//            lbl_Preview.strokeColor = activatedText?.strokeColor
//            lbl_Preview.strokePosition = (activatedText?.strokePosition)!
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.text = textView.text!
    }
    
    //MARK: - Buttons' Actions
    @IBAction func btn_Back_Clicked(_ sender: Any) {
        selectedTextContent = txt_content.text
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFont_Clicked(_ sender: Any) {
        selectedTextContent = txt_content.text
        if (activatedText?.isInTemplate)!{
            let alert : UIAlertController = UIAlertController.init(title: "Alert", message: "Text in template is not allowed to change its font.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let fontSelectVC = FontSelectVC(nibName: "FontSelectVC", bundle: nil)
            self.navigationController?.pushViewController(fontSelectVC, animated: true)
        }
        
    }    
    
    @IBAction func btnTextEffect_Clicked(_ sender: Any) {
        selectedTextContent = txt_content.text
        if (activatedText?.isInTemplate)!{
            let alert : UIAlertController = UIAlertController.init(title: "Alert", message: "Text in template is not allowed to add effects.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let textStylerVC = StyleViewController(nibName: "StyleViewController", bundle: nil)
            let styleText = StyleText()
            styleText.text = txt_content?.text
            styleText.fontName = txt_content?.font?.fontName
            styleText.size = Float((activatedText?.font?.pointSize)!)
            styleText.textColor = activatedText?.textColor.hexStringValue
            textStylerVC.style = styleText
            
            textStylerVC.userImage = img_magazine
            self.navigationController?.pushViewController(textStylerVC, animated: true)
        }
    }
    
    @IBAction func btnNext_Clicked(_ sender: Any) {
        
        selectedTextContent = txt_content.text        
         _ = self.navigationController?.popViewController(animated: true)
    }

    
}
