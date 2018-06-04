//
//  MainMenuVC.swift
//  Magazine
//
//  Created by iOSpro on 11/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

class MainMenuVC: UIViewController, MFMailComposeViewControllerDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var productsRequest = SKProductsRequest()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchAvailableProducts()
    }

    func fetchAvailableProducts()  {
        
        // Put here your IAP Products ID's
        let productIdentifiers = NSSet(objects: IAP_FULLVERSION)
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }

    // MARK: - SKProductsRequestDelegate
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
//
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {

        UserDefaults.standard.set(true, forKey: KEY_FULLVERSION)
        let alert = UIAlertController(title: "Restore Purchase", message: "You've successfully restored your purchase!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in

        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    // MARK: - Button Actions
    
    @IBAction func btn_NewMagazine_Clicked(_ sender: Any) {
        
        currentProject = Project()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let selectTemplateVC = SelectTemplateVC(nibName: "SelectTemplateVC_ipad", bundle: nil)
            self.navigationController?.pushViewController(selectTemplateVC, animated: true)
            break
        default:
            let selectTemplateVC = SelectTemplateVC(nibName: "SelectTemplateVC", bundle: nil)
            self.navigationController?.pushViewController(selectTemplateVC, animated: true)
            break
        }
    }
    
    @IBAction func btn_LoadMagazine_Clicked(_ sender: Any) {
        
        let projectsVC = ProjectsVC(nibName: "ProjectsVC", bundle: nil)
        self.navigationController?.pushViewController(projectsVC, animated: true)
    }
    
    @IBAction func btnRestorePurchase_Clicked(_ sender: Any) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    @IBAction func btn_FullVersion_Clicked(_ sender: Any) {
        if userdefaults.bool(forKey: KEY_FULLVERSION){
            let alert = UIAlertController(title: "Purchase Full Version", message: "You already purchased Full Version!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else{
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
    }
    
    @IBAction func btn_ContactUs_Clicked(_ sender: Any) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }

    }
    
    @IBAction func btn_VisitFB_Clicked(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/molandwebsystem") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["haavardmoland@gmail.com"])
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
