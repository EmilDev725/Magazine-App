//
//  SelectTemplateVC.swift
//  Magazine
//
//  Created by iOSpro on 11/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SelectTemplateVC: UIViewController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!

    @IBOutlet weak var templatesCollection: UICollectionView!
    
    @IBOutlet weak var view_Admob: UIView!
    @IBOutlet weak var bannerHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        templatesCollection.delegate = self
        templatesCollection.dataSource = self
        
        templatesCollection.register(UINib(nibName: "SelectTemplateCVCell", bundle: nil), forCellWithReuseIdentifier: "SelectTemplateCVCell")
        templatesCollection.register(UINib(nibName: "SelectTemplateIPhoneCVCell", bundle: nil), forCellWithReuseIdentifier: "SelectTemplateIPhoneCVCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Admob Banner
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            let bannerFrame = CGRect(x: 0, y: 0, width: Main_Screen_Width, height: 90)
            bannerView = GADBannerView(frame: bannerFrame)
            bannerHeightConstraint.constant = 90
            break
        default:
            let bannerFrame = CGRect(x: 0, y: 0, width: Main_Screen_Width, height: 50)
            bannerView = GADBannerView(frame: bannerFrame)
            bannerHeightConstraint.constant = 50
            break
        }
        
        addBannerViewToView(bannerView)
        bannerView.adUnitID = GAD_BANNER_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }

    // MARK: - Button Actions
    
    @IBAction func btn_Back_Clicked(_ sender: Any) {
         _ = self.navigationController?.popViewController(animated: true)
    }
    
}

extension SelectTemplateVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SelectTemplateCVCell?
        var imgName = "theme" + String(indexPath.row + 1)
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            cell = templatesCollection.dequeueReusableCell(withReuseIdentifier: "SelectTemplateCVCell", for: indexPath) as? SelectTemplateCVCell
            imgName += "_ipad"
            break
        default:
            cell = templatesCollection.dequeueReusableCell(withReuseIdentifier: "SelectTemplateIPhoneCVCell", for: indexPath) as? SelectTemplateCVCell
            imgName += "_iphone"
            break
        }
        cell?.img_template.image = UIImage(named: imgName)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = UIScreen.main.bounds.width / 3 - 16
        let cellheight = UIDevice.current.userInterfaceIdiom == .pad ? cellwidth * 341 / 256 : cellwidth * 222 / 125
        return CGSize(width: cellwidth, height: cellheight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // choose templete
        selectedTemplate = common.collectThemeComponentsFromXib(index: indexPath.row + 1)
        var imgName = "theme" + String(indexPath.row + 1)
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            imgName += "_ipad"
            let addPhotoVC = AddPhotoVC(nibName: "AddPhotoVC_ipad", bundle: nil)
            addPhotoVC.imgName = imgName
            self.navigationController?.pushViewController(addPhotoVC, animated: true)
            break
        default:
            imgName += "_iphone"
            let addPhotoVC = AddPhotoVC(nibName: "AddPhotoVC", bundle: nil)
            addPhotoVC.imgName = imgName
            self.navigationController?.pushViewController(addPhotoVC, animated: true)
            break
        }        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UICollectionView {
            
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


