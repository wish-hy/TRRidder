//
//  TRStaticCollectionViewCell1.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRStaticCollectionViewCell1: UICollectionViewCell , UITableViewDelegate, UITableViewDataSource{
    var tableView : UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        contentView.backgroundColor = .clear
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TRStatisticTotalTableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(TRStatisticFeeTableViewCell.self, forCellReuseIdentifier: "cell2")
        tableView.register(TRStatisticCommentTableViewCell.self, forCellReuseIdentifier: "cell3")
        tableView.register(TRStatisticTimeTableViewCell.self, forCellReuseIdentifier: "cell4")
        tableView.register(TRStatisticDeliveryCell.self, forCellReuseIdentifier: "cell5")

        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(self.contentView)
        }
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 97
        } else if indexPath.row == 1 {
            return 183 + 15
        } else if indexPath.row == 2 {
            return 110 + 15
        } else if indexPath.row == 3 {
           return 140 + 15
        } else if indexPath.row == 4 {
            return 226 + 15
        }
        
        return 0.01
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TRStatisticFeeTableViewCell
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
            return cell
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath)
            return cell
        
                         
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
