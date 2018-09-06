//
//  TaipeiMailTableViewCell.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/9/5.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit

class TaipeiMailTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleLabel : UILabel!
    
    @IBOutlet weak var keyLabel : UILabel!
    
    @IBOutlet weak var DescriptionLabel : UILabel!
    
    var viewModel : TaipeiMailCellViewModel? {
        didSet {
            TitleLabel.text = viewModel?.Title
            keyLabel.text = viewModel?.ID
            DescriptionLabel.text = viewModel?.Detail
        }
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
