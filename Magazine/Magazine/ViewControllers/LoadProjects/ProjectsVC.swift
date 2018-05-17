//
//  ProjectsVC.swift
//  Magazine
//
//  Created by iOSpro on 12/2/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit

class ProjectsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var cv_projects: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cv_projects.dataSource = self
        cv_projects.delegate = self
        cv_projects.register(UINib(nibName: "ProjectsCVCell", bundle: nil), forCellWithReuseIdentifier: "ProjectsCVCell")
    }

    @IBAction func btnCancel_Clicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allProjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ProjectsCVCell?
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            cell = cv_projects.dequeueReusableCell(withReuseIdentifier: "ProjectsCVCell", for: indexPath) as? ProjectsCVCell
            break
        default:
            cell = cv_projects.dequeueReusableCell(withReuseIdentifier: "ProjectsCVCell", for: indexPath) as? ProjectsCVCell
            break
        }
        if indexPath.row < allProjects.count{
            cell?.lb_projectName.text = allProjects[indexPath.row].name
            cell?.img_projectScreen.image = allProjects[indexPath.row].screenshot
            cell?.tag = indexPath.row
            cell?.projectsCVCellDelegate = self
        }
        
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
        
        if indexPath.row < allProjects.count{
            currentProject = allProjects[indexPath.row]
            currentProject?.textViews = sqlManager.getAllTextsInProject(projectName: (currentProject?.name)!)
            currentProject?.imageViews = sqlManager.getAllImagesInProject(projectName: (currentProject?.name)!)
            
            currentProject?.titleEdited = true
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                let addTextVC = AddTextVC(nibName: "AddTextVC_ipad", bundle: nil)
                self.navigationController?.pushViewController(addTextVC, animated: true)
                break
            default:
                let addTextVC = AddTextVC(nibName: "AddTextVC", bundle: nil)
                self.navigationController?.pushViewController(addTextVC, animated: true)
                break
            }
        }
    }
}

extension ProjectsVC : ProjectsCVCellDelegate{
    func deleteActions(_ tag: Int, cell: UICollectionViewCell) {
        if cell.tag < allProjects.count{
            
            let alert = UIAlertController(title: "Alert", message: "Do you really want to delete this project?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
                sqlManager.deleteProjectFromDB(project: allProjects[cell.tag])
                allProjects.remove(at: cell.tag)
                self.cv_projects.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
}
