//
//  TRStaticCollectionViewCell3.swift
//  NewTrade_Rider
//
//  Created by xph on 2023/9/12.
//

import UIKit

class TRStaticCollectionViewCell3: UICollectionViewCell , UITableViewDelegate, UITableViewDataSource{
    var tmH = 0.0
    var tableView : UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView(){
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bgColor()
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
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        return cell
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
