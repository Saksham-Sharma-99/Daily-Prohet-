//
//  TopicCell.swift
//  daily prophet 1.0
//
//  Created by Saksham Sharma on 09/05/20.
//  Copyright © 2020 sharma. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var itsDescription: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
     
    
    @IBOutlet weak var cellView: UIView!
    
    @IBAction func topicKeyPressed(_ sender: UIButton) {
       
    }
    
    
}


