//
//  FontSelectVC.swift
//  Magazine
//
//  Created by iOSpro on 10/2/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit

class FontSelectVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tb_fonts: UITableView!
    @IBOutlet weak var lb_fontsize: UITextField!
    
    let sections = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var fonts = [String]()
    var groupFonts = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for familyName in UIFont.familyNames{
            for name in UIFont.fontNames(forFamilyName: familyName){
                self.fonts.append(name)
            }
        }
        for section in self.sections{
            let arr = self.fonts.filter{$0.starts(with: section)}
            print(arr.count)
            groupFonts.append(arr)
        }
        print(groupFonts.count)
        
        tb_fonts.dataSource = self
        tb_fonts.delegate = self
        tb_fonts.register(UINib(nibName: "FontsTBCell", bundle: nil), forCellReuseIdentifier: "FontsTBCell")
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        lb_fontsize.text = String(selectedFontSize);
    }
    
    @IBAction func btnCancel_Clicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDone_Clicked(_ sender: Any) {
        selectedFontSize = Int(lb_fontsize.text!)!
        var viewControllers = navigationController?.viewControllers
        for i in 0 ..< (viewControllers?.count)! {
            let obj = viewControllers?[i]
            if (obj is AddTextVC) {
                if let aObj = obj as? AddTextVC {
                    navigationController?.popToViewController(aObj, animated: true)
                }
                return
            }
        }
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right:
                selectedFontName = ""
                _ = self.navigationController?.popViewController(animated: true)
                break
            default:
                break
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupFonts[section].count
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "FontsTBCell") as! FontsTBCell
        if indexPath.section < self.groupFonts.count{
            let fontsInGroup = self.groupFonts[indexPath.section]
            if indexPath.row < fontsInGroup.count{
                let fontName = fontsInGroup[indexPath.row]
                
                cell.lb_fontname.text = fontName
                cell.lb_fontname.font = UIFont(name: fontName, size: 20)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section < self.groupFonts.count{
            let fontsInGroup = self.groupFonts[indexPath.section]
            if indexPath.row < fontsInGroup.count{
                selectedFontName = fontsInGroup[indexPath.row]
            }
        }
    }
}
