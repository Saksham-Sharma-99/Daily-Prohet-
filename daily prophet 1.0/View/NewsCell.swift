//
//  NewsCell.swift
//  daily prophet 1.0
//
//  Created by Saksham Sharma on 11/05/20.
//  Copyright © 2020 sharma. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var imageContent: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageContent.image = #imageLiteral(resourceName: "Daily Prophet Logo")
    }
    
}
