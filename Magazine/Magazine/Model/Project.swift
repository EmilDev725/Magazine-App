//
//  Project.swift
//  Magazine
//
//  Created by iOSpro on 26/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import Foundation
import UIKit

class Project {
    var name : String = ""
    var image : UIImage?
    var screenshot : UIImage?
    
    var textViews = [THLabel]()
    var imageViews = [UIImageView]()
    
    var titleEdited = false
}

class Template{
//    var title = UITextField()
    var textViews = [THLabel]()
    var images = [UIImageView]()
}
