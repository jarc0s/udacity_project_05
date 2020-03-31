//
//  AnimeHomeView.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

class AnimeHomeView: UIViewController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            print("Configure tableVIEw")
            tableView.delegate = self
            tableView.dataSource = self
            //tableView.register(MediaCell.self, forCellReuseIdentifier: "MediaCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 200
        }
    }
    
    var presenter: AnimeHomePresenterProtocol?
    
    
    var mediaData: [Media] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension AnimeHomeView: AnimeHomeViewProtocol {
    func showMediaType(_ media: [Media]) {
        mediaData = media
    }
}

//MARK: - UITABLEVIEDataSource

extension AnimeHomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as! MediaCell
        
        let media = mediaData[indexPath.row]
        cell.configure(media: media)
        
        return cell
    }
    
}

//MARK: - UITABLEVIEDelegate

extension AnimeHomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
