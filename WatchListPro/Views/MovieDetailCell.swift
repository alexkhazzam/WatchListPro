//
//  movieCellTableViewCell.swift
//  WatchListPro
//
//  Created by Alexander Khazzam on 8/24/22.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
