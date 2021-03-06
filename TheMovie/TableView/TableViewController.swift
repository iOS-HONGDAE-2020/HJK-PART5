//
//  TableViewController.swift
//  TheMovie
//
//  Created by 김호종 on 2020/10/05.
//  Copyright © 2020 김호종. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var naviBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if MovieData.shared.movieList.count < 1 {
            MovieData.shared.set {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        tableView.dataSource    = self
        tableView.delegate      = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.navigationItem.title = MovieData.shared.sortOpt.rawValue
        
        MovieData.shared.movieReloadHandler = { self.tableView.reloadData() }
        MovieData.shared.titleHandler = { title in self.navigationItem.title = title }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetailViewController else { return }
        guard let cell = sender as? TableViewCell else { return }
        
        let backItem = UIBarButtonItem()
        backItem.title = "영화목록"
        navigationItem.backBarButtonItem = backItem
        
        vc.id = cell.id
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieData.shared.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        let movie = MovieData.shared.movieList[indexPath.row]
        
        
        cell.id                     = movie.id
        cell.thumbnail.image        = UIImage.downloadImage(url: movie.thumbURL)
        cell.titleLabel.text        = movie.title
        cell.infoLabel.text         = "평점 : \(movie.userRate)  예매순위 : \(movie.reservationGrade)  예매율 : \(movie.reservationRate)"
        cell.openDateLabel.text     = "개봉일 : \(movie.date.toString())"
        cell.gradeImageView.image   = Util.setGrade(movie.grade)
        
        return cell
    }
    @IBAction func settingAction(_ sender: Any) {
        Util.settingAction(vc: self)
    }
}

extension UIImage {
    class func downloadImage(url: URL) -> UIImage? {
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        
        return nil
    }
}

extension Date {
    func toString() -> String {
        
        return formatter.string(from: self)
    }
}

class TableViewCell: UITableViewCell {
    var id: String!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
}
