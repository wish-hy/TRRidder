//
//  BasicNavViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/3.
//

import UIKit

class BasicNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        self.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.txtColor()]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
