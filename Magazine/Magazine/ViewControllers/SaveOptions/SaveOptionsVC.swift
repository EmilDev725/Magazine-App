//
//  SaveOptionsVC.swift
//  Magazine
//
//  Created by iOSpro on 22/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit
import GoogleMobileAds
import StoreKit

class SaveOptionsVC: UIViewController, GADBannerViewDelegate{
        
    @IBOutlet weak var btn_regularImg: UIButton!
    @IBOutlet weak var btn_dstyleImg: UIButton!
    @IBOutlet weak var view_Admob: UIView!
    
    
    let glRenderer : OSPRendererGL = OSPRendererGL.init()
    var imgName : String = "bg01"
    
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var timer : Timer?
    var time_total : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_regularImg.setBackgroundImage(currentProject?.screenshot, for: .normal)
        
        glRenderer.setCover(currentProject?.screenshot)
        let dImg = glRenderer.render(withBackground: UIImage(named:imgName))
        btn_dstyleImg.setBackgroundImage(dImg, for: .normal)
        
        if !userdefaults.bool(forKey: KEY_FULLVERSION){
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
            
            // Admob Interstitial
            interstitial = GADInterstitial(adUnitID: GAD_INTERSTITIAL_ID)
            let request = GADRequest()
            interstitial.load(request)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        time_total = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        time_total += 1
        imgName = time_total == 10 ? "bg" + String(time_total) : "bg0" + String(time_total)
        let dImg = glRenderer.render(withBackground: UIImage(named:imgName))
        btn_dstyleImg.setBackgroundImage(dImg, for: .normal)
        if time_total == 10{
            time_total = 0
        }
    }
    
    @IBAction func btn_Back_Clicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSave_Clicked(_ sender: Any) {
        
    }
    
    @IBAction func btnLoad_Clicked(_ sender: Any) {
        
    }
    
    @IBAction func btnRegular_Clicked(_ sender: Any) {
        
        UIImageWriteToSavedPhotosAlbum((currentProject?.screenshot)!, self, nil, nil)
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let regularSaveVC = RegularSaveVC(nibName: "RegularSaveVC_ipad", bundle: nil)
            self.navigationController?.pushViewController(regularSaveVC, animated: true)
            break
        default:
            let regularSaveVC = RegularSaveVC(nibName: "RegularSaveVC", bundle: nil)
            self.navigationController?.pushViewController(regularSaveVC, animated: true)
            break
        }
    }
    
    @IBAction func btn3Dstyle_Clicked(_ sender: Any) {
        if timer != nil && (timer?.isValid)!{
            timer?.invalidate()
        }
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let saveOptionsVC = DSaveOptionsVC(nibName: "DSaveOptionsVC_ipad", bundle: nil)
            self.navigationController?.pushViewController(saveOptionsVC, animated: true)
            break
        default:
            let saveOptionsVC = DSaveOptionsVC(nibName: "DSaveOptionsVC", bundle: nil)
            self.navigationController?.pushViewController(saveOptionsVC, animated: true)
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
}
