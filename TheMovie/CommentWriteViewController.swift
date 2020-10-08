//
//  CommentWriteViewController.swift
//  TheMovie
//
//  Created by 오디언 on 2020/10/08.
//  Copyright © 2020 김호종. All rights reserved.
//

import UIKit

class CommentWriteViewController: UITableViewController {
    var movieId: String!
    var movieTitle: String?
    @IBOutlet weak var ratingView: RatingView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = movieTitle
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
