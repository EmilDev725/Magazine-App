//
//  3DSaveOptionsVC.swift
//  Magazine
//
//  Created by iOSpro on 1/3/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit
import GoogleMobileAds
import StoreKit

class DSaveOptionsVC: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    let glRenderer : OSPRendererGL = OSPRendererGL.init()
    var imgName : String = "bg01"
    
    var productsRequest = SKProductsRequest()
    var interstitial: GADInterstitial!

    @IBOutlet weak var img_preview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAvailableProducts()

        glRenderer.setCover(currentProject?.screenshot)
        img_preview.image = glRenderer.render(withBackground: UIImage(named:imgName))
//        let img = glRenderer.render(withBackgroundColor: UIColor.clear)
//        UIImageWriteToSavedPhotosAlbum(img!, self, nil, nil)
        
        interstitial = GADInterstitial(adUnitID: GAD_INTERSTITIAL_ID)
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func fetchAvailableProducts()  {
        
        // Put here your IAP Products ID's
        let productIdentifiers = NSSet(objects: IAP_FULLVERSION)
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                    
                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    UserDefaults.standard.set(true, forKey: KEY_FULLVERSION)
                    let alert = UIAlertController(title: "Purchase Full Version", message: "You've successfully peuchased Full Version!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                        
                    }))
                    break
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    let alert = UIAlertController(title: "Purchase Full Version", message: "Purchase Full Version failed! Please try again later.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                        
                    }))
                    break
                case .restored:
                    UserDefaults.standard.set(true, forKey: KEY_FULLVERSION)
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    let alert = UIAlertController(title: "Restore Purchase", message: "You've successfully restored your purchase!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    break
                    
                default: break
                }
                
            }
            
        }
    }
    
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {
        if (response.products.count > 0) {
            
        }
    }
    
    func purchaseFullVersion(){
        if self.canMakePurchases() {
            let payment = SKMutablePayment()
            payment.productIdentifier = IAP_FULLVERSION
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            // IAP Purchases dsabled on the Device
        } else {
            let alert = UIAlertController(title: "Purchase Full Version", message: "Purchases are not enabled in your device yet!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    

    @IBAction func btnBack_Clicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHome_Clicked(_ sender: Any) {
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
    
    @IBAction func btnBackground_Selected(_ sender: UIButton) {
        imgName = sender.tag == 10 ? "bg10" : "bg0" + String(sender.tag)
        img_preview.image = glRenderer.render(withBackground: UIImage(named:imgName))
    }
    
    @IBAction func btnFinish_Clicked(_ sender: Any) {
        
        if userdefaults.bool(forKey: KEY_FULLVERSION){
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
            let img = glRenderer.render(withBackground: UIImage(named:imgName))
            UIImageWriteToSavedPhotosAlbum(img!, self, nil, nil)
            
            let dSaved = DSaved(nibName: "DSaved", bundle: nil)
            dSaved.img_cover = img
            self.navigationController?.pushViewController(dSaved, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Upgrade to Full Version", message: "Enable 3D style saving", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                
            }))
            alert.addAction(UIAlertAction(title: "Upgrade", style: UIAlertActionStyle.default, handler: {action in
                self.purchaseFullVersion()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
