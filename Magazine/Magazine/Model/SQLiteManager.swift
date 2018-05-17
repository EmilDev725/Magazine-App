//
//  SQLiteManager.swift
//  ANON Confession
//
//  Created by iOSpro on 29/1/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class SQLiteManager{
    
    // MARK: - create tables
    // create all tables
    func createTablesOnSQLite(){
        createProjectsTable()
        createTextsTable()
        createImagesTable()
    }
    
    func createProjectsTable(){
        //user Table
        let Projects = Table("Projects")
        let name = Expression<String>("name")
        let image = Expression<String>("image")
        let screenshot = Expression<String>("screenshot")
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            
            let db = try Connection(path + "/db.sqlite3")
            
            do {
                try db.run(Projects.create{ f in
                    f.column(name)
                    f.column(image)
                    f.column(screenshot)
                })
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func createTextsTable(){
        //AllSecrets Table
        let Texts = Table("Texts")
        let id = Expression<Int64>("id")
        let text = Expression<String>("text")
        let x = Expression<Int64>("x")
        let y = Expression<Int64>("y")
        let width = Expression<Int64>("width")
        let height = Expression<Int64>("height")
        let fontname = Expression<String>("fontname")
        let fontsize = Expression<Int64>("fontsize")
        let color = Expression<String>("color")
        
        let backcolor = Expression<String>("backcolor")
        let shadowblur = Expression<Int64>("shadowblur")
        let shadowoffsetx = Expression<Int64>("shadowoffsetx")
        let shadowoffsety = Expression<Int64>("shadowoffsety")
        let shadowcolor = Expression<String>("shadowcolor")
        let strokesize = Expression<Int64>("strokesize")
        let strokecolor = Expression<String>("strokecolor")
        
        let isintemplate = Expression<Int64>("isintemplate")
        
        let project = Expression<String>("project")
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            
            let db = try Connection(path + "/db.sqlite3")
            
            do {
                try db.run(Texts.create{ f in
                    f.column(id, unique: false)
                    f.column(text)
                    f.column(x)
                    f.column(y)
                    f.column(width)
                    f.column(height)
                    f.column(fontname)
                    f.column(fontsize)
                    f.column(color)
                    
                    f.column(backcolor)
                    f.column(shadowblur)
                    f.column(shadowoffsetx)
                    f.column(shadowoffsety)
                    f.column(shadowcolor)
                    f.column(strokesize)
                    f.column(strokecolor)
                    
                    f.column(isintemplate)
                    
                    f.column(project)
                })
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func createImagesTable(){
        //AllSecrets Table
        let Images = Table("Images")
        let id = Expression<Int64>("id")
        let content = Expression<String>("content")
        let x = Expression<Int64>("x")
        let y = Expression<Int64>("y")
        let width = Expression<Int64>("width")
        let height = Expression<Int64>("height")
        let project = Expression<String>("project")
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            
            let db = try Connection(path + "/db.sqlite3")
            
            do {
                try db.run(Images.create{ f in
                    f.column(id, unique: false)
                    f.column(content)
                    f.column(x)
                    f.column(y)
                    f.column(width)
                    f.column(height)
                    f.column(project)
                })
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }

    //MARK: - Update SQLite Value
    func updateProjectOnSQLite(project: Project){
        // update secret on All secrets table
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            
            let db = try Connection(path + "/db.sqlite3")
            let Projects = Table("Projects")
            let name = Expression<String>("name")
            let image = Expression<String>("image")
            let screenshot = Expression<String>("screenshot")
            
            let imageData:Data = UIImagePNGRepresentation(project.image!)!
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            
            let screenshotImageData:Data = UIImagePNGRepresentation(project.screenshot!)!
            let strScreenshotBase64 = screenshotImageData.base64EncodedString(options: .lineLength64Characters)
            
            let alice = Projects.filter(name == project.name)
            
            do {
                if (try db.scalar(alice.count) == 0){
                    do {
                        let insert = Projects.insert(name <- project.name,
                                                     image <- strBase64,
                                                     screenshot <- strScreenshotBase64)
                        _ = try db.run(insert)
                    }catch{
                        print(error.localizedDescription)
                    }
                }else{
                    do {
                        try db.run(alice.update(name <- project.name,
                                                image <- strBase64,
                                                screenshot <- strScreenshotBase64))
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    /*
     activatedText?.textColor = appDelegate.editedStyleText.textColor
     activatedText?.backgroundColor = appDelegate.editedStyleText.backgroundColor
     activatedText?.shadowBlur = appDelegate.editedStyleText.shadowBlur
     activatedText?.shadowOffset = appDelegate.editedStyleText.shadowOffset
     activatedText?.shadowColor = appDelegate.editedStyleText.shadowColor
     activatedText?.innerShadowBlur = appDelegate.editedStyleText.innerShadowBlur
     activatedText?.innerShadowOffset = appDelegate.editedStyleText.innerShadowOffset
     activatedText?.innerShadowColor = appDelegate.editedStyleText.innerShadowColor
     activatedText?.strokeSize = appDelegate.editedStyleText.strokeSize
     activatedText?.strokeColor = appDelegate.editedStyleText.strokeColor
     activatedText?.strokePosition = appDelegate.editedStyleText.strokePosition
     activatedText?.gradientStartColor = appDelegate.editedStyleText.gradientStartColor
     activatedText?.gradientEndColor = appDelegate.editedStyleText.gradientEndColor
     activatedText?.gradientColors = appDelegate.editedStyleText.gradientColors
     activatedText?.gradientStartPoint = appDelegate.editedStyleText.gradientStartPoint
     activatedText?.gradientEndPoint = appDelegate.editedStyleText.gradientEndPoint
     activatedText?.fadeTruncatingMode = appDelegate.editedStyleText.fadeTruncatingMode
     */
    
    func updateTextsWithTextViewOnSQLite(txt: THLabel, id: Int, str_project: String){
        
        // update secret on All secrets table
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            
            let db = try Connection(path + "/db.sqlite3")
            let Texts = Table("Texts")
            let index = Expression<Int64>("id")
            let text = Expression<String>("text")
            let x = Expression<Int64>("x")
            let y = Expression<Int64>("y")
            let width = Expression<Int64>("width")
            let height = Expression<Int64>("height")
            let fontname = Expression<String>("fontname")
            let fontsize = Expression<Int64>("fontsize")
            let color = Expression<String>("color")
            
            let backcolor = Expression<String>("backcolor")
            let shadowblur = Expression<Int64>("shadowblur")
            let shadowoffsetx = Expression<Int64>("shadowoffsetx")
            let shadowoffsety = Expression<Int64>("shadowoffsety")
            let shadowcolor = Expression<String>("shadowcolor")
            let strokesize = Expression<Int64>("strokesize")
            let strokecolor = Expression<String>("strokecolor")
            
            let isintemplate = Expression<Int64>("isintemplate")
            
            let project = Expression<String>("project")
            
            let str_color = txt.textColor.hexStringValue
            let str_color_shadow = txt.shadowColor == nil ? "00000000" : txt.shadowColor?.hexStringValue
            let isintem = txt.isInTemplate ? 1 : 0
            
            let alice = Texts.filter(index == Int64(id) && project == str_project)
            
            do {
                if (try db.scalar(alice.count) == 0){
                    do {
                        let insert = Texts.insert(index <- Int64(id),
                                                  text <- txt.text!,
                                                  x <- Int64(txt.frame.origin.x),
                                                  y <- Int64(txt.frame.origin.y),
                                                  width <- Int64(txt.frame.width),
                                                  height <- Int64(txt.frame.height),
                                                  fontname <- (txt.font?.fontName)!,
                                                  fontsize <- Int64((txt.font?.pointSize)!),
                                                  color <- str_color!,
                                                  backcolor <- (txt.backgroundColor?.hexStringValue)!,
                                                  shadowblur <- Int64(txt.shadowBlur),
                                                  shadowoffsetx <- Int64(txt.shadowOffset.width),
                                                  shadowoffsety <- Int64(txt.shadowOffset.height),
                                                  shadowcolor <- str_color_shadow!,
                                                  strokecolor <- txt.strokeColor.hexStringValue,
                                                  strokesize <- Int64(txt.strokeSize),
                                                  
                                                  isintemplate <- Int64(isintem),
                                                  project <- str_project)
                        _ = try db.run(insert)
                    }catch{
                        print(error.localizedDescription)
                    }
                }else{
                    do {
                        try db.run(alice.update(index <- Int64(id),
                                                text <- txt.text!,
                                                x <- Int64(txt.frame.origin.x),
                                                y <- Int64(txt.frame.origin.y),
                                                width <- Int64(txt.frame.width),
                                                height <- Int64(txt.frame.height),
                                                fontname <- (txt.font?.fontName)!,
                                                fontsize <- Int64((txt.font?.pointSize)!),
                                                color <- str_color!,
                                                project <- str_project))
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
  
    func updateImagesOnSQLite(img: UIImageView, id: Int, str_project: String){
        // update secret on All secrets table
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            
            let db = try Connection(path + "/db.sqlite3")
            let Images = Table("Images")
            let index = Expression<Int64>("id")
            let content = Expression<String>("content")
            let x = Expression<Int64>("x")
            let y = Expression<Int64>("y")
            let width = Expression<Int64>("width")
            let height = Expression<Int64>("height")
            let project = Expression<String>("project")
            
            let imageData:Data = UIImagePNGRepresentation(img.image!)!
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            
            let alice = Images.filter(index == Int64(id) && project == str_project)
            
            do {
                if (try db.scalar(alice.count) == 0){
                    do {
                        let insert = Images.insert(index <- Int64(id),
                                                   content <- strBase64,
                                                   x <- Int64(img.frame.origin.x),
                                                   y <- Int64(img.frame.origin.y),
                                                   width <- Int64(img.frame.width),
                                                   height <- Int64(img.frame.height),
                                                   project <- str_project)
                        _ = try db.run(insert)
                    }catch{
                        print(error.localizedDescription)
                    }
                }else{
                    do {
                        try db.run(alice.update(index <- Int64(id),
                                                content <- strBase64,
                                                x <- Int64(img.frame.origin.x),
                                                y <- Int64(img.frame.origin.y),
                                                width <- Int64(img.frame.width),
                                                height <- Int64(img.frame.height),
                                                project <- str_project))
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Get From SQLite
    // get user profile info from SQLite
    func getAllProjectsFromSQLite(){
        allProjects = [Project]()
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            
            let db = try Connection(path + "/db.sqlite3")
            let Projects = Table("Projects")
            let name = Expression<String>("name")
            let image = Expression<String>("image")
            let screenshot = Expression<String>("screenshot")
            
            do {
                for info_row in try db.prepare(Projects){
                    let project = Project()
                    project.name = info_row[name]
                    
                    let str_imgData = info_row[image]
                    let dataDecoded:Data = Data(base64Encoded: str_imgData, options: .ignoreUnknownCharacters)!
                    project.image = UIImage(data: dataDecoded)!
                    
                    let str_screenshotimgData = info_row[screenshot]
                    let screenshotdataDecoded:Data = Data(base64Encoded: str_screenshotimgData, options: .ignoreUnknownCharacters)!
                    project.screenshot = UIImage(data: screenshotdataDecoded)!
                    
                    allProjects.append(project)
                }
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // get single updated real secret from SQLite without refreshing all feeds from SQLite
    func getAllTextsInProject(projectName : String) -> [THLabel]{
        var textViews = [THLabel]()
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            
            let db = try Connection(path + "/db.sqlite3")
            
            let Texts = Table("Texts")
//            let id = Expression<Int64>("id")
            let text = Expression<String>("text")
            let x = Expression<Int64>("x")
            let y = Expression<Int64>("y")
            let width = Expression<Int64>("width")
            let height = Expression<Int64>("height")
            let fontname = Expression<String>("fontname")
            let fontsize = Expression<Int64>("fontsize")
            let color = Expression<String>("color")
            
//            let backcolor = Expression<String>("backcolor")
//            let shadowblur = Expression<Int64>("shadowblur")
            let shadowoffsetx = Expression<Int64>("shadowoffsetx")
            let shadowoffsety = Expression<Int64>("shadowoffsety")
            let shadowcolor = Expression<String>("shadowcolor")
            let strokesize = Expression<Int64>("strokesize")
            let strokecolor = Expression<String>("strokecolor")
            
            let isintemplate = Expression<Int64>("isintemplate")
            
            let txt_project = Expression<String>("project")
            
            do {
                for txt_row in try db.prepare(Texts){
                    let txt : THLabel = THLabel.init()
                    let point_x = Int(txt_row[x])
                    let point_y = Int(txt_row[y])
                    let txt_width = Int(txt_row[width])
                    let txt_height = Int(txt_row[height])
                    txt.frame = CGRect(x: point_x, y: point_y, width: txt_width, height: txt_height)
                    txt.text = txt_row[text]
                    let txt_fontname = txt_row[fontname]
                    let txt_fontsize = txt_row[fontsize]
                    txt.font = UIFont(name: txt_fontname, size: CGFloat(txt_fontsize))
                    let str_color = txt_row[color]
                    txt.textColor = UIColor(hexString: str_color)                    
//                    txt.backgroundColor = UIColor(hexString: txt_row[backcolor])
                    txt.backgroundColor = UIColor.clear
                    txt.shadowBlur = 1
//                    txt.shadowBlur = CGFloat(txt_row[shadowblur])
                    let shadow_x = Int(txt_row[shadowoffsetx])
                    let shadow_y = Int(txt_row[shadowoffsety])
                    txt.shadowOffset = CGSize(width: shadow_x, height: shadow_y)
                    let hexstring = txt_row[shadowcolor]
                    txt.shadowColor = hexstring == "00000000" ? UIColor.black : UIColor(hexString: hexstring)
                    txt.strokeSize = CGFloat(txt_row[strokesize])
                    txt.strokeColor = UIColor(hexString: txt_row[strokecolor])
                    
                    let isintemp = Int(txt_row[isintemplate])
                    txt.isInTemplate = isintemp == 1
                    
                    let name = txt_row[txt_project]
                    if projectName == name{
                        textViews.append(txt)
                    }
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
        return textViews
    }
    
    func getAllImagesInProject(projectName : String) -> [UIImageView] {
        
        var imageViews = [UIImageView]()
        
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            
            let db = try Connection(path + "/db.sqlite3")
            
            let Images = Table("Images")
//            let id = Expression<Int64>("id")
            let content = Expression<String>("content")
            let x = Expression<Int64>("x")
            let y = Expression<Int64>("y")
            let width = Expression<Int64>("width")
            let height = Expression<Int64>("height")
            let txt_project = Expression<String>("project")
            
            do {
                for img_row in try db.prepare(Images){
                    let imgView : UIImageView = UIImageView()
                    let point_x = Int(img_row[x])
                    let point_y = Int(img_row[y])
                    let txt_width = Int(img_row[width])
                    let txt_height = Int(img_row[height])
                    imgView.frame = CGRect(x: point_x, y: point_y, width: txt_width, height: txt_height)
                    let str_imgData = img_row[content]
                    let dataDecoded:Data = Data(base64Encoded: str_imgData, options: .ignoreUnknownCharacters)!
                    imgView.image = UIImage(data: dataDecoded)!
                    let name = img_row[txt_project]
                    if projectName == name{
                        imageViews.append(imgView)
                    }
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        return imageViews
    }
    
    // MARK: - Delete SQLite Table
    // delete liked secret reference from SQLite database
    func deleteProjectFromDB(project: Project){
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!

            let db = try Connection(path + "/db.sqlite3")

            let Projects = Table("Projects")
            let name = Expression<String>("name")

            let alice = Projects.filter(name == project.name)

            do {
                if (try db.scalar(alice.count) == 0){
                    print("row not found")
                }else{
                    do {
                        if (try db.run(alice.delete()) > 0){
                            print("deleted")
                        }else{
                            print("row not found")
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
            
            let Texts = Table("Texts")
            let txt_project = Expression<String>("project")
            
            let txt_alice = Texts.filter(txt_project == project.name)
            
            do {
                if (try db.scalar(txt_alice.count) == 0){
                    print("row not found")
                }else{
                    do {
                        if (try db.run(txt_alice.delete()) > 0){
                            print("deleted")
                        }else{
                            print("row not found")
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
            
            let Images = Table("Images")
//            let name = Expression<String>("name")
            
            let img_alice = Images.filter(txt_project == project.name)
            
            do {
                if (try db.scalar(img_alice.count) == 0){
                    print("row not found")
                }else{
                    do {
                        if (try db.run(img_alice.delete()) > 0){
                            print("deleted")
                        }else{
                            print("row not found")
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}
