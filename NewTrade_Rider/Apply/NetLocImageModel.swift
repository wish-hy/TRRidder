//
//  NetLocImageModel.swift
//  NewTrade_Seller
//
//  Created by xph on 2023/12/15.
//

import UIKit
import HandyJSON

class NetLocImageModel: HandyJSON {
    //网络图片链接 收到请求后赋值
    
    var netURL : String = "" {
        didSet {
            if !netURL.isEmpty {
                netUrlArr = netURL.components(separatedBy: ",")
                for _ in netUrlArr {
                    //追加默认图片
                    localImgArr.append(Net_Default_Img)
                }
            }
        }
    }
    //网络图片名字 收到请求后赋值
    var netName : String = "" {
        didSet {
            if !netName.isEmpty {
                netNameArr = netName.components(separatedBy: ",")
            }
        }
    }
    //三个数组 联动修改，本地图片可以使用空的图片替代，优先展示neUrlArr，如果为 "", 展示locaImg
    //本地图片
    var localImgArr : [UIImage] = []
    //网络图片数组
    var netUrlArr : [String] = []
    var netNameArr : [String] = []
    var max : Int = IMG_UP_MAX
    
    required init() {}
    //收到网络请求后，赋值netURL netName ，进而解析
    
    //获取需要提交的网络图片名字
    func getName()->String {
        return netNameArr.joined(separator: ",")
    }
    
    func addLocalImg(img :UIImage,netName : String) {
        if localImgArr.count >= IMG_UP_MAX {return}
        localImgArr.append(img)
        netNameArr.append(netName)
        netUrlArr.append("")
    }
    func addLocalImgArr(imgs : [UIImage], netNames : [String]) {

        for i in 0...imgs.count - 1 {
            if localImgArr.count >= max {
                return
            }
            localImgArr.append(imgs[i])
            netNameArr.append(netNames[i])
            netUrlArr.append("")
        }
    }
    func deleteImg(index : Int) {
        
        netUrlArr.remove(at: index)
        netNameArr.remove(at: index)
        localImgArr.remove(at: index)
    }
    
    
    func removeAll(){
        netUrlArr.removeAll()
        netNameArr.removeAll()
        localImgArr.removeAll()
        netURL = ""
        netName = ""
        
    }
    

    //交换位置
    func exchangeItem(from : Int, to : Int) {

        netUrlArr.swapAt(from, to)
        localImgArr.swapAt(from, to)
        netNameArr.swapAt(from, to)
    }
    
    //归档相关 ,filePath 不要带图片名字
    func saveImgToLocal(filePath : String){
        if netNameArr.isEmpty {
            return
        }
        //如果 net是 "", 则是本地图片 需要保存
        for i in 0...netNameArr.count - 1 {
            let tNetName = netNameArr[i]
            let tNetUrl = netUrlArr[i]
            let tLocImg = localImgArr[i]
            if tNetUrl.elementsEqual("") {
                TRFileManage.share.save_image_to_path(source: tLocImg, path: filePath, fileName: tNetName)
            }
        }
        
    }
    
    //此方法要先将 模型从文件读出 在去处理图片(filePath不要待图片名字)
    //不要随意调用
    
    //站位图，从本地生成的模型，localImgArr是空的，需要填充空白图片
    func spadImgToLocal(){
        if netUrlArr.isEmpty {return}
        for _ in netUrlArr {
            localImgArr.append(Net_Default_Img)
        }
    }
    
    func readImgFromLocal(filePath : String) {
        if netUrlArr.isEmpty {return}
        for i in 0...netUrlArr.count - 1 {
            let tNetUrl = netUrlArr[i]
            let tNetName = netNameArr[i]

            if tNetUrl.elementsEqual("") {
                localImgArr[i] = TRFileManage.share.read_image_from_path(path: filePath , fileName: tNetName) ?? Net_Default_Img
            }
        }
        
        
    }
}
