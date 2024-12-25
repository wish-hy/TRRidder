//
//  TRTabBarViewController.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/3.
//

import UIKit

class TRTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let homeVC = TRHomeViewController()
        homeVC.tabBarItem.title = "首页"
//        homeVC.title = "首页"
        homeVC.tabBarItem.image = UIImage(named: "tab_home_nor")!.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.selectedImage = UIImage(named: "tab_home_sel")!.withRenderingMode(.alwaysOriginal)

        let homeNav = BasicNavViewController(rootViewController: homeVC)
        
        let mineVC = TRMineViewController()
        mineVC.tabBarItem.title = "我的"
        mineVC.title = "我的"
        mineVC.tabBarItem.selectedImage = UIImage(named: "tab_my_sel")?.withRenderingMode(.alwaysOriginal)

        mineVC.tabBarItem.image = UIImage(named: "tab_my_nor")?.withRenderingMode(.alwaysOriginal)
        self.tabBar.tintColor = UIColor.hexColor(hexValue: 0x13D066)
        let mineNAV = BasicNavViewController(rootViewController: mineVC)
        self.setViewControllers([homeNav, mineNAV], animated: false)
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
    }
    

   

}
