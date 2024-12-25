//
//  TRFileManage.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/7/29.
//

import Foundation

let PATH_FILE_RIDER_APPLY_PATH = "PATH_FILE_RIDER_APPLY_PATH"

//调用请携带目录和文件名（在document目录下）
class TRFileManage {
    static let share = TRFileManage()
    
    private let fileManager = FileManager.default
    private init() {
        
    }
    private func getRootDir()->String{
        return NSHomeDirectory() + "/Documents/"
    }
    
    
    func save_string_to_path(source : String, path : String,fileName : String){
        if fileManager.fileExists(atPath: getRootDir() + path) == false {
            try? fileManager.createDirectory(atPath: getRootDir() + path , withIntermediateDirectories: true)
        }
        
        try? source.write(toFile: getRootDir() + path + "/\(fileName)", atomically: true, encoding: .utf8)
    }
    func read_string_from_path(path : String)->String? {
        var ret : String?
        
        let pathURL = URL(fileURLWithPath: getRootDir() + path , isDirectory: false)

        ret = try? String.init(contentsOf: pathURL)
        return ret
    }
    
    func save_image_to_path(source : UIImage, path : String,fileName : String){
        if fileManager.fileExists(atPath: getRootDir() + path) == false {
            try? fileManager.createDirectory(atPath:getRootDir() + path , withIntermediateDirectories: true)
        }
        let data = source.sd_imageData()
        
        let pathURL = URL(fileURLWithPath: getRootDir() + path + "/\(fileName)" , isDirectory: false)

        try? data?.write(to: pathURL)
    }
    func read_image_from_path(path : String, fileName : String)->UIImage? {
        var ret : UIImage?
        ret =  UIImage(contentsOfFile: getRootDir() + path + "/\(fileName)")
        return ret
    }
    
    
    func delete_dir(dir : String) {
        let pathURL = URL(fileURLWithPath: getRootDir() + dir , isDirectory: true)

        try? fileManager.removeItem(at: pathURL)
    }
    
    func existFileOrDir(path : String)->Bool {
        return fileManager.fileExists(atPath: getRootDir() + path)
    }
    
}
	
