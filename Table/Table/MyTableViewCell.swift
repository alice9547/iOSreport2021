//
//  MyTableViewCell.swift
//  Table
//
//  Created by 소프트웨어컴퓨터 on 2021/05/16.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
