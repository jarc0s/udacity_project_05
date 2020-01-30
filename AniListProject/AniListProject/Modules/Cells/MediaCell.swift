//
//  MediaCell.swift
//  AniListProject
//
//  Created by Juan Arcos on 29/01/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

class MediaCell: UITableViewCell {
    
    static let Identifier = "MediaCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var startDate: UILabel!
    
    
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
    }
    
    func configure() {
        print(#function)
    }
    
}
