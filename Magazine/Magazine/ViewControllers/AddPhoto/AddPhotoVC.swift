//
//  AddPhotoVC.swift
//  Magazine
//
//  Created by iOSpro on 16/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Sharaku
import TOCropViewController

class AddPhotoVC: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var img_magazine: UIImageView!
    @IBOutlet weak var img_cover: UIImageView!
    
    @IBOutlet weak var view_container: UIView!
    
    @IBOutlet weak var view_Admob: UIView!
   
    var CIFilterNames = [String]()
    var img_temp : UIImage?
    let picker = UIImagePickerController()
    var photoChanged = false
    var imgName = ""
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            img_cover.image = UIImage(named:imgName)
            break
        default:
            img_cover.image = UIImage(named:imgName)
            break
        }
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(MoveImage))
        img_cover.addGestureRecognizer(gesture)
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateAction(sender:)))
        img_cover.addGestureRecognizer(rotateGesture)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(sender:)))
        img_cover.addGestureRecognizer(pinchGesture)
        
        CIFilterNames = CIFilter.filterNames(inCategory: nil)
        img_magazine.contentMode = .scaleAspectFit
        img_temp = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rect_Container = view_container.frame
        
        // Admob Banner
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let bannerFrame = CGRect(x: 0, y: 0, width: Main_Screen_Width, height: 90)
            bannerView = GADBannerView(frame: bannerFrame)
            break
        default:
            let bannerFrame = CGRect(x: 0, y: 0, width: Main_Screen_Width, height: 50)
            bannerView = GADBannerView(frame: bannerFrame)
            break
        }
        
        addBannerViewToView(bannerView)
        bannerView.adUnitID = GAD_BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (photoChanged){
            let cropViewController = TOCropViewController(image: img_temp!)
            cropViewController.toolbar.resetButton.isHidden = true
            cropViewController.toolbar.clampButton.isHidden = true
            cropViewController.toolbar.rotateButton.isHidden = true
            cropViewController.toolbar.rotateClockwiseButton?.isHidden = true
            cropViewController.aspectRatioLockEnabled = true
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                cropViewController.customAspectRatio = CGSize(width: Editor_Width_iPad, height: Editor_Height_iPad)
                break
            default:
                cropViewController.customAspectRatio = CGSize(width: Editor_Width_iPhone, height: Editor_Height_iPhone)
                break
            }
            cropViewController.delegate = self
            photoChanged = false
            self.present(cropViewController, animated: true, completion: nil)
        }
    }
    
    //MARK: - Buttons' Actions
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
                newProject.image = self.captureImage()
                newProject.screenshot = self.captureFullImage()
                
                if allProjects.count > 0 {
                    let duplicatedProject = allProjects.filter{$0.name == newProject.name}
                    if duplicatedProject.count > 0{
                        let alert = UIAlertController(title: "Alert", message: "Project name already exist. Do you want to overwrite it?", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
                            sqlManager.updateProjectOnSQLite(project: newProject)
                            allProjects.append(newProject)
                        }))
                        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        sqlManager.updateProjectOnSQLite(project: newProject)
                        allProjects.append(newProject)
                    }
                }
                else{
                    sqlManager.updateProjectOnSQLite(project: newProject)
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
        let projectsVC = ProjectsVC(nibName: "ProjectsVC", bundle: nil)
        self.navigationController?.pushViewController(projectsVC, animated: true)
    }
    
    @IBAction func btnLibrary_Clicked(_ sender: Any) {
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: false, completion: nil)
    }
    
    @IBAction func btnCamera_Clicked(_ sender: Any) {
        picker.sourceType = .camera
        picker.delegate = self
        self.present(picker, animated: false, completion: nil)
    }
    
    @IBAction func btnResize_Clicked(_ sender: Any) {
        
        img_cover.isUserInteractionEnabled = true
    }
    
    @IBAction func btnFilter_Clicked(_ sender: Any) {
        if img_magazine.image != nil{
//            tb_filters.isHidden = false
            let imageToBeFiltered = img_temp
            let vc = SHViewController(image: imageToBeFiltered!)
            vc.delegate = self
            self.present(vc, animated:true, completion: nil)
        }
    }
    
    @IBAction func btnNext_Clicked(_ sender: Any) {
        self.goToAddTextVC()
    }
    
    func goToAddTextVC() {
        currentProject?.titleEdited = false
        currentProject?.image = captureImage()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let addTextVC = AddTextVC(nibName: "AddTextVC_ipad", bundle: nil)
            addTextVC.isFirstTimeLoading = true
            self.navigationController?.pushViewController(addTextVC, animated: true)
            break
        default:
            let addTextVC = AddTextVC(nibName: "AddTextVC", bundle: nil)
            addTextVC.isFirstTimeLoading = true
            self.navigationController?.pushViewController(addTextVC, animated: true)
            break
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        view_Admob.addSubview(bannerView)
    }
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    // Image Processing
    
    @objc func MoveImage(gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: self.view)
        if let myView = gesture.view {
            img_magazine.center = CGPoint(x: myView.center.x + translation.x, y: myView.center.y + translation.y)
        }
        if gesture.view is UIImageView{
            img_temp = img_magazine.image
        }
//        gesture.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
    
    @objc func pinchAction(sender:UIPinchGestureRecognizer){
        if sender.state == .changed{
            img_magazine.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
            if sender.view is UIImageView{
                img_temp = img_magazine.image
            }
//            sender.scale = 1
        }
    }
    
    @objc func rotateAction(sender:UIRotationGestureRecognizer){
        img_magazine.transform = (sender.view?.transform)!.rotated(by: sender.rotation)
//        sender.rotation = 0
        if sender.view is UIImageView{
            img_temp = img_magazine.image
        }
    }
    
//    func saveComponentsToSQLite(project : Project){
//        var index = 0
//        for view in view_container.subviews{
//            if view is UIImageView{
//                if view != img_magazine{
//                    sqlManager.updateImagesOnSQLite(img: view as! UIImageView, id: index, str_project: project.name)
//                }
//            }
//            index += 1
//        }
//    }
    
    func captureImage() -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        img_cover.frame = frame
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:view_container.frame.width, height: view_container.frame.height), false, 0.0)
        view_container.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (rect_Container != nil){
            let frame = CGRect(x: 0, y: 0, width: (rect_Container?.width)!, height: (rect_Container?.height)!)
            img_cover.frame = frame
        }
        
        return image
    }
    
    func captureFullImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:view_container.frame.width, height: view_container.frame.height), false, 0.0)
        view_container.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
   
}

extension AddPhotoVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate{
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if (String(describing: info[UIImagePickerControllerMediaType]) == "Optional(public.movie)") {
            
        }else{
            
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            img_temp = image
            photoChanged = true
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        // 'image' is the newly cropped version of the original image
        img_magazine.image = image
        img_temp = image
        cropViewController.dismiss(animated: true, completion: nil)
    }

}

extension AddPhotoVC: SHViewControllerDelegate {
    func shViewControllerImageDidFilter(image: UIImage) {
        // Filtered image will be returned here.
        img_magazine.image = image
    }
    
    func shViewControllerDidCancel() {
        // This will be called when you cancel filtering the image.
    }
}
