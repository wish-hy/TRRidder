//
//  TRChatImgCell.swift
//  NewTrade_Seller
//
//  Created by xph on 2024/4/1.
//

import UIKit
import RxSwift
class TRChatImgCell: TRChatBasicCell {
    
    var imgBlock : Void_Block?
    let bag = DisposeBag()
    override var msgModel : ChatMsgModel? {
        didSet {
            guard let msgModel  = msgModel  else { return }
            if "\(msgModel.sender)".elementsEqual(TRDataManage.shared.userModel.scUserId) {
                let img = UIImage(contentsOfFile: "\(msgModel.msgContent)")
                var data = try? Data.init(contentsOf: URL.init(fileURLWithPath: "\(msgModel.msgContent)"))
//                print("图片地址 \(msgModel.msgContent)")
//                if data == nil {
//                let u = msgModel.msgContent.components(separatedBy: "Documents")
//                
//                // 获取Documents目录的路径
//                    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
//                        //                    // 拼接出图片的完整路径
//                        let imagePath = documentsDirectory.appendingPathComponent(u.last ?? "") // 替换"yourImageName.png"为实际图片文件的名称
//                        print("新图片地址\(imagePath.absoluteString)")
//                        data = try? Data.init(contentsOf: imagePath)
//                    }
                
                if data != nil {
                    let img = UIImage(data: data!)
//                    NSData *imageData = [NSData dataWithContentsOfFile:@"path/to/your/image"];
//                    [imageView sd_setImageWithData:imageData placeholderImage:nil];

                    chatImgView.image = img
                    if img != nil {
                        let scale = img!.size.height / img!.size.width
                        self.chatImgView.snp.remakeConstraints { make in
                            make.height.equalTo(scale * 130)
                            make.width.equalTo(130)
                            make.left.right.equalTo(self.contentBgView).inset(0)
                            make.top.equalTo(self.contentBgView).inset(10)
                            make.bottom.equalTo(self.contentBgView).inset(0)
                        }
                    }
                }
                    
            } else {
                chatImgView.sd_setImage(with: URL.init(string: msgModel.msgContent), placeholderImage: Net_Default_Img) {[weak self] img, _, _, _ in
                    guard let self  = self  else { return }
                    guard let img = img else { return }
                    let scale = img.size.height / img.size.width
                    self.chatImgView.snp.remakeConstraints { make in
                        make.height.equalTo(scale * 130)
                        make.width.equalTo(130)
                        make.left.right.equalTo(self.contentBgView).inset(0)
                        make.top.equalTo(self.contentBgView).inset(10)
                        make.bottom.equalTo(self.contentBgView).inset(0)                    }
                }

            }

        }
        
    }
    var chatImgView : UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        configImgView()
    }
    
    private func configImgView(){
        chatImgView = TRFactory.imageViewWith(image: nil, mode: .scaleAspectFill, superView: contentBgView)
        chatImgView.clipsToBounds = true
        chatImgView.isUserInteractionEnabled = true
        let imgGes = UITapGestureRecognizer()
        imgGes.rx.event.debug("Tap").subscribe(onNext : {[weak self] _ in
            guard let self  = self  else { return }
            if self.imgBlock != nil {
                self.imgBlock!()
            }
            self.removeFromSuperview()
        }).disposed(by: bag)
        chatImgView.addGestureRecognizer(imgGes)
        contentBgView.isHidden = true
        contentView.addSubview(chatImgView)
        chatImgView.snp.makeConstraints { make in
            make.height.equalTo(88)
            make.width.equalTo(130)
            make.left.right.equalTo(contentBgView).inset(0)
            make.top.equalTo(self.contentBgView).inset(10)
            make.bottom.equalTo(self.contentBgView).inset(0)        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
