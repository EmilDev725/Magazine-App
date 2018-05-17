//
//  ProjectsCVCell.swift
//  Magazine
//
//  Created by iOSpro on 12/2/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import UIKit

protocol ProjectsCVCellDelegate : class {
    func deleteActions(_ tag: Int, cell: UICollectionViewCell)
}

class ProjectsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var lb_projectName: UILabel!
    
    @IBOutlet weak var img_projectScreen: UIImageView!
    
    weak var projectsCVCellDelegate: ProjectsCVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnDelete_Clicked(_ sender: UIButton) {
        projectsCVCellDelegate?.deleteActions(sender.tag, cell: self)
    }
    

}
