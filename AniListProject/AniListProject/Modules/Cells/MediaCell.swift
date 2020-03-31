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
    
//    @IBOutlet weak var title: UILabel!
//    @IBOutlet weak var season: UILabel!
//    @IBOutlet weak var startDate: UILabel!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var startDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
     
    func configure(media: Media) {
        
        if let titleModel = media.title {
            let romanjiTitle = titleModel.romanji ?? ""
            let nativeTitle = titleModel.native ?? ""
            let englishTitle = titleModel.english ?? ""
            
            title.text = !romanjiTitle.isEmpty ? romanjiTitle : ( !englishTitle.isEmpty ? englishTitle : ( !nativeTitle.isEmpty ? nativeTitle : "N/A") )
            
        }
        
        season.text = media.season ?? "N/A"
        startDate.text = media.startDate ?? "Com ing soon!!"
        
    }
}
