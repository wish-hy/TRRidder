//
//  TRWalletModel.swift
//  NewTrade_Rider
//
//  Created by xph on 2024/8/15.
//

import UIKit

class TRWalletModel: TRBaseModel {
    var avaAmount : String = ""
      var bankTotal : String = ""
      var depositAmount : String = ""
      var frozenAvaAmount : String = ""
      var frozenPunishAmount : String = ""
      var hasDepositRefunding : Bool = false
      var id : String = ""
      var memTipAmount : String = ""
      var punishAmount : String = ""
      var rechargeAmount : String = ""
      var riderId : String = ""
      var riderInviteAmount : String = ""
      var status : String = ""
      var storeTipAmount : String = ""
      var sysMid : String = ""
}
class TRWalletManage: TRBaseModel {
    var code : Int = -1
    var data : TRWalletModel = TRWalletModel()
}
