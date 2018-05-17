//
//  EnterTitleVC.swift
//  Magazine
//
//  Created by iOSpro on 11/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit
import ChromaColorPicker

class EnterTitleVC: UIViewController {
    
    @IBOutlet weak var img_magazine: UIImageView!
    @IBOutlet weak var view_container: UIView!
    
    var img_temp : UIImage?
    var titleView: UITextField?
    
    var neatColorPicker : ChromaColorPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if img_temp != nil{
            img_magazine.image = img_temp            
            currentProject?.image = img_temp            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let frame = common.findLocationOfComponent(frame: (currentProject?.template.title.frame)!)
//        let title : UITextField = UITextField()
//        title.text = currentProject?.template.title.text
//        title.textColor = currentProject?.template.title.textColor
//        title.font = currentProject?.template.title.font
//        title.textAlignment = (currentProject?.template.title.textAlignment)!
//        title.backgroundColor = currentProject?.template.title.backgroundColor
//        title.tag = 100
//        title.frame = frame
//        let gesture = UIPanGestureRecognizer(target: self, action: #selector(MoveAction))
//        title.addGestureRecognizer(gesture)
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(sender:)))
//        title.addGestureRecognizer(pinchGesture)
        
//        self.view.addSubview(title)
//        self.titleView = title
    }

    @IBAction func btn_Back_Clicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSave_Clicked(_ sender: Any) {
        
    }
    
    @IBAction func btnLoad_Clicked(_ sender: Any) {
        
    }
    
    @IBAction func btnTextColour_Clicked(_ sender: Any) {
        neatColorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        neatColorPicker?.delegate = self //ChromaColorPickerDelegate
        neatColorPicker?.padding = 5
        neatColorPicker?.stroke = 3
        neatColorPicker?.hexLabel.textColor = UIColor.white
        
        view.addSubview(neatColorPicker!)
    }
    
    @IBAction func btnNext_Clicked(_ sender: Any) {
//        for view in self.view.subviews{
//            if view.tag == 100 && view is UITextField{
//                currentProject?.template.title = view as! UITextField
//            }
//        }
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let editTextVC = EditTextVC(nibName: "EditTextVC_ipad", bundle: nil)
            self.navigationController?.pushViewController(editTextVC, animated: true)
            break
        default:
            let editTextVC = EditTextVC(nibName: "EditTextVC", bundle: nil)
            self.navigationController?.pushViewController(editTextVC, animated: true)
            break
        }
    }
    
    @objc func MoveAction(gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: self.view)
        if let myView = gesture.view {
            myView.center = CGPoint(x: myView.center.x + translation.x, y: myView.center.y + translation.y)
//            currentProject?.template.title.frame.offsetBy(dx: translation.x, dy: translation.y)
        }
        gesture.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
   
    @objc func pinchAction(sender:UIPinchGestureRecognizer){
        if sender.state == .changed{
            sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
}

extension EnterTitleVC : ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        
    }
    
    
}
