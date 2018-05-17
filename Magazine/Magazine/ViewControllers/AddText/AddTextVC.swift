//
//  AddTextVC.swift
//  Magazine
//
//  Created by iOSpro on 22/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit
import GoogleMobileAds
import ChromaColorPicker

class AddTextVC: UIViewController, GADBannerViewDelegate{

    @IBOutlet weak var img_magazine: UIImageView!
    
    @IBOutlet weak var view_container: UIView!
   
    var titleView: UITextField?
    var isTitleInEditing : Bool = false
    
    var activatedText : THLabel?
    var btn_addText : UIButton = UIButton()
    
    var neatColorPicker : ChromaColorPicker?
    
    var colorViewRect : CGRect?
    var isAddTextShowing : Bool = false
    var isFirstTimeLoading : Bool = true
    var txt_position : CGPoint?
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if currentProject?.image != nil{
            img_magazine.image = currentProject?.image
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapMainView))
        view_container.addGestureRecognizer(tapGesture)
        
        btn_addText.addTarget(self, action: #selector(btnAddText_Clicked), for: .touchUpInside)
        
        isFirstTimeLoading = true
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let bannerFrame = CGRect(x: 0, y: Main_Screen_Height - 90, width: Main_Screen_Width, height: 90)
            bannerView = GADBannerView(frame: bannerFrame)
            break
        default:
            let bannerFrame = CGRect(x: 0, y: Main_Screen_Height - 50, width: Main_Screen_Width, height: 50)
            bannerView = GADBannerView(frame: bannerFrame)
            break
        }
        
        addBannerViewToView(bannerView)
        bannerView.adUnitID = GAD_BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if rect_Container == nil{
            rect_Container = view_container.frame
        }
        
        if !(currentProject?.titleEdited)!{
            addImagesInTemplate()
            addTextsInTemplate()
            currentProject?.titleEdited = true
        }
        else if isFirstTimeLoading{
            addImagesInProject()
            addTextsInProject()
            isFirstTimeLoading = false
        }
        
        if activatedText != nil{
            if selectedTextContent == ""{
                activatedText?.removeFromSuperview()
            }
            else{
                if selectedFontName != ""{
                    activatedText?.font = UIFont(name: selectedFontName, size: CGFloat(selectedFontSize))
                    selectedFontName = ""
                }
                if appDelegate.editedStyleText.text != nil && appDelegate.editedStyleText.text != ""{
                    applyTextEffect()
                    activatedText?.textAlignment = .center
                }
                
                activatedText?.text = selectedTextContent
                selectedTextContent = ""
                let content = activatedText?.text
                if activatedText?.numberOfLines != 0{
                    for index in 10 ..< 190{
                        let fontAttributes = [NSAttributedStringKey.font: UIFont(name: (activatedText?.font.fontName)!, size: CGFloat(index))]
                        let tempSize = content?.size(withAttributes: fontAttributes)
                        if Int((tempSize?.width)!) >= Int((activatedText?.frame.size.width)! - 20) || Int((tempSize?.height)!) >= Int((activatedText?.frame.size.height)! - 10){
                            activatedText?.font = UIFont(name: (activatedText?.font.fontName)!, size: CGFloat(index))
                            break
                        }
                    }
                }
                else{
                    activatedText?.sizeToFit()
                }
                let gesture = UIPanGestureRecognizer(target: self, action: #selector(MoveAction))
                activatedText?.addGestureRecognizer(gesture)
            }
        }
    }
    
    func applyTextEffect(){
        activatedText?.textColor = appDelegate.editedStyleText.textColor
        activatedText?.backgroundColor = appDelegate.editedStyleText.backgroundColor
        activatedText?.shadowBlur = appDelegate.editedStyleText.shadowBlur
        activatedText?.textAlignment = appDelegate.editedStyleText.textAlignment
        activatedText?.shadowOffset = appDelegate.editedStyleText.shadowOffset
        activatedText?.shadowColor = appDelegate.editedStyleText.shadowColor
        activatedText?.strokeSize = appDelegate.editedStyleText.strokeSize
        activatedText?.strokeColor = appDelegate.editedStyleText.strokeColor
        activatedText?.strokePosition = appDelegate.editedStyleText.strokePosition
        
        appDelegate.editedStyleText = THLabel()
    }
    
    func addTextsInTemplate(){
        for txt in selectedTemplate.textViews{
            let frame = txt.frame
            let resizedFrame = common.findLocationOfComponent(frame: frame)
            let title : THLabel = THLabel.init(frame: resizedFrame)
            title.text = txt.text
            title.textColor = txt.textColor
            title.font = txt.font
            if IS_IPHONE_5{
                title.font = UIFont(name:txt.font.fontName, size:txt.font.pointSize * 0.78)
            }
            else if IS_IPHONE_6PLUS{
                title.font = UIFont(name:txt.font.fontName, size:txt.font.pointSize * 1.08)
            }
            else if IS_IPAD_2{
                title.font = txt.font
            }

            title.backgroundColor = txt.backgroundColor
            title.shadowBlur = 1
            title.shadowOffset = txt.shadowOffset
//            title.shadowColor = txt.shadowColor
            title.shadowColor = UIColor.black
            title.strokeSize = txt.strokeSize
            title.strokeColor = txt.strokeColor
            title.strokePosition = txt.strokePosition
            title.strokeSize = txt.strokeSize
            
            title.numberOfLines = txt.numberOfLines
            title.textAlignment = txt.textAlignment
            title.isInTemplate = false
            
            let content = title.text
            
            if title.numberOfLines != 0{
                for index in 10 ..< 190{
                    let fontAttributes = [NSAttributedStringKey.font: UIFont(name: title.font.fontName, size: CGFloat(index))]
                    let tempSize = content?.size(withAttributes: fontAttributes)
                    if Int((tempSize?.width)!) >= Int(title.frame.size.width - 20) || Int((tempSize?.height)!) >= Int(title.frame.size.height - 10){
                        title.font = UIFont(name: title.font.fontName, size: CGFloat(index))
                        break
                    }
                }
            }
            else{
                title.sizeToFit()
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editText))
            title.addGestureRecognizer(tapGesture)
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(MoveAction))
            title.addGestureRecognizer(gesture)
            
            title.isUserInteractionEnabled = true
            
            view_container.addSubview(title)
        }
    }
    
    func addImagesInTemplate(){
        for img in selectedTemplate.images{
            let frame = img.frame
            let resizedFrame = common.findLocationOfComponent(frame: frame)
            let image : UIImageView = UIImageView()
            image.image = img.image
            image.frame = resizedFrame
            image.isUserInteractionEnabled = isImageMoveEnabled(imageview: image)
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(MoveAction))
            image.addGestureRecognizer(gesture)
            view_container.addSubview(image)
            if isImageMoveEnabled(imageview: image){
                image.bringSubview(toFront: img_magazine)
            }
        }
    }
    
    func addTextsInProject(){
        if ((currentProject?.textViews.count)! > 0){
            for txt in (currentProject?.textViews)!{
                let title : THLabel = THLabel()
                title.text = txt.text
                title.textColor = txt.textColor
                title.font = txt.font
                title.textAlignment = .center
                
                title.backgroundColor = txt.backgroundColor
                title.shadowBlur = txt.shadowBlur
                title.shadowOffset = txt.shadowOffset
                title.shadowColor = txt.shadowColor
                title.strokeSize = txt.strokeSize
                title.strokeColor = txt.strokeColor
                title.strokePosition = txt.strokePosition
                title.isInTemplate = txt.isInTemplate
                
                title.frame = txt.frame
                title.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editText))
                title.addGestureRecognizer(tapGesture)
                let gesture = UIPanGestureRecognizer(target: self, action: #selector(MoveAction))
                title.addGestureRecognizer(gesture)
                
                view_container.addSubview(title)
            }
        }
        else{
            if selectedTemplate.textViews.count > 0 {
                addImagesInTemplate()
                addTextsInTemplate()
            }
        }
    }
    
    func addImagesInProject(){
        for img in (currentProject?.imageViews)!{
            let image : UIImageView = UIImageView()
            image.image = img.image
            image.frame = img.frame
            image.isUserInteractionEnabled = isImageMoveEnabled(imageview: image)
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(MoveAction))
            image.addGestureRecognizer(gesture)
            view_container.addSubview(image)
            if isImageMoveEnabled(imageview: image){
                image.bringSubview(toFront: img_magazine)
            }
        }
    }
    
    func isImageMoveEnabled(imageview : UIImageView) -> Bool{
        if imageview.frame.size.width >= view_container.frame.size.width - 10 && imageview.frame.size.height >= view_container.frame.size.height - 10{
            return false
        }
        return true
    }
    
    @IBAction func btn_Back_Clicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSave_Clicked(_ sender: Any) {
        let alert = UIAlertController(title: "Project Name", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Project Name."
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let name = textField?.text
            if name != nil{
                let newProject = Project()
                newProject.name = name!
                newProject.image = currentProject?.image
                newProject.screenshot = self.captureImage()
                
                if allProjects.count > 0 {
                    let duplicatedProject = allProjects.filter{$0.name == newProject.name}
                    if duplicatedProject.count > 0{
                        let alert = UIAlertController(title: "Alert", message: "Project name already exist. Do you want to overwrite it?", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
                            sqlManager.updateProjectOnSQLite(project: newProject)
                            self.saveComponentsToSQLite(project: newProject)
                            allProjects.append(newProject)
                        }))
                        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        sqlManager.updateProjectOnSQLite(project: newProject)
                        self.saveComponentsToSQLite(project: newProject)
                        allProjects.append(newProject)
                    }
                }
                else{
                    sqlManager.updateProjectOnSQLite(project: newProject)
                    self.saveComponentsToSQLite(project: newProject)
                    allProjects.append(newProject)
                }
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Project name cannot be empty.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnLoad_Clicked(_ sender: Any) {
        isFirstTimeLoading = false
        let projectsVC = ProjectsVC(nibName: "ProjectsVC", bundle: nil)
        self.navigationController?.pushViewController(projectsVC, animated: true)
    }
    
    @IBAction func btnNext_Clicked(_ sender: Any) {
        currentProject?.screenshot = captureImage()
        self.activatedText = nil
        isFirstTimeLoading = false
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let saveOptionsVC = SaveOptionsVC(nibName: "SaveOptionsVC_ipad", bundle: nil)
            self.navigationController?.pushViewController(saveOptionsVC, animated: true)
            break
        default:
            let saveOptionsVC = SaveOptionsVC(nibName: "SaveOptionsVC", bundle: nil)
            self.navigationController?.pushViewController(saveOptionsVC, animated: true)
            break
        }
    }
    
    func saveComponentsToSQLite(project : Project){
        var index = 0
        for view in view_container.subviews{
            if view is THLabel{
                sqlManager.updateTextsWithTextViewOnSQLite(txt: view as! THLabel, id: index, str_project: project.name)
            }
            else if view is UIImageView{
                if view != img_magazine{
                    sqlManager.updateImagesOnSQLite(img: view as! UIImageView, id: index, str_project: project.name)
                }
            }
            index += 1
        }
    }
    
    func captureImage() -> UIImage? {
        if btn_addText.superview != nil{
            btn_addText.removeFromSuperview()
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width:view_container.frame.width, height: view_container.frame.height), false, 0.0)
        view_container.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    @objc func MoveAction(gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: self.view)
        if let myView = gesture.view {
            myView.center = CGPoint(x: myView.center.x + translation.x, y: myView.center.y + translation.y)
        }
        gesture.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
    
    @objc func pinchAction(sender:UIPinchGestureRecognizer){
        if sender.state == .changed{
            sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
    
    // MARK: - add text action
    
    @objc func editText(sender: UITapGestureRecognizer){
        self.activatedText = sender.view as? THLabel
        selectedFontName = (activatedText?.font.fontName)!
        selectedFontSize = Int((activatedText?.font.pointSize)!)
                
        let editTextVC = EditTextVC(nibName: "EditTextVC", bundle: nil)
        editTextVC.activatedText = sender.view as? THLabel
        editTextVC.img_magazine = img_magazine.image
        
        isFirstTimeLoading = false
        self.navigationController?.pushViewController(editTextVC, animated: true)
    }
    
    @objc func tapMainView(sender: UITapGestureRecognizer){
        
        let point : CGPoint = sender.location(in: view_container)
        
        if isAddTextShowing{
            btn_addText.removeFromSuperview()
            isAddTextShowing = false
        }
        else{
            isAddTextShowing = true
            txt_position = CGPoint(x: point.x, y: point.y)
            btn_addText.frame = CGRect(x: point.x, y: point.y, width: 57, height: 30)
            btn_addText.setBackgroundImage(UIImage(named:"btn_addtext"), for: .normal)
            view_container.addSubview(btn_addText)
            self.dismissKeyboard()
        }
        
        if (neatColorPicker?.superview != nil){
            neatColorPicker?.removeFromSuperview()
        }
    }
    
    @objc func btnAddText_Clicked(){
        btn_addText.removeFromSuperview()
        let textview : THLabel = THLabel.init()
        textview.frame = CGRect(x: (txt_position?.x)!, y: (txt_position?.y)!, width: 100, height: 50)
        textview.backgroundColor = UIColor.clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editText))
        textview.addGestureRecognizer(tapGesture)
        textview.isUserInteractionEnabled = true
        textview.isInTemplate = false
        textview.numberOfLines = 0
        view_container.addSubview(textview)
        
        editText(sender: tapGesture)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }

}

extension AddTextVC : ChromaColorPickerDelegate{
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        if titleView != nil && isTitleInEditing{
            titleView?.textColor = color
        }
        else if activatedText != nil{
            activatedText?.textColor = color
        }
        neatColorPicker?.removeFromSuperview()
    }
}
