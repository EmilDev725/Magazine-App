//
//  RegularSaveVC.swift
//  Magazine
//
//  Created by iOSpro on 22/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit
import MessageUI
import Social

class RegularSaveVC: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var img_magazine: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        img_magazine.image = currentProject?.screenshot
    }

    @IBAction func btn_Back_Clicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Home_Clicked(_ sender: Any) {
        
        currentProject = Project()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let mainMenuVC = MainMenuVC(nibName: "MainMenuVC_ipad", bundle: nil)
            self.navigationController?.pushViewController(mainMenuVC, animated: true)
            break
        default:
            let mainMenuVC = MainMenuVC(nibName: "MainMenuVC", bundle: nil)
            self.navigationController?.pushViewController(mainMenuVC, animated: true)
            break
        }
    }
    
    @IBAction func btnFB_Clicked(_ sender: Any) {
        let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        composeSheet?.add(img_magazine.image)
        present(composeSheet!, animated: true, completion: nil)
    }
    
    @IBAction func btnEmail_Clicked(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func btnTwitter_Clicked(_ sender: Any) {
        let composeSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        composeSheet?.add(img_magazine.image)
        present(composeSheet!, animated: true, completion: nil)
    }
    
    @IBAction func btnInstagram_Clicked(_ sender: Any) {
        InstagramManager.sharedManager.postImageToInstagramWithCaption(imageInstagram: img_magazine.image!, instagramCaption: "\(self.description)", view: self.view)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        let imgData = UIImageJPEGRepresentation(img_magazine.image!, 1.0)
        mailComposerVC.addAttachmentData(imgData!, mimeType: "image/jpeg", fileName: "magazine")
        mailComposerVC.setSubject("Magazine Maker")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
