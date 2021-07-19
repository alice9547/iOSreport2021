//
//  MyTableViewCell.swift
//  MovieKES
//
//  Created by 소프트웨어컴퓨터 on 2021/05/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!      //스토리보드의 레이블과 연결
    @IBOutlet weak var openDt: UILabel!         //''
    @IBOutlet weak var audiAcc: UILabel!        //''
    @IBOutlet weak var rank: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
