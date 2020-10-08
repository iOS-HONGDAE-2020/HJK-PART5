//
//  CollectionViewController.swift
//  TheMovie
//
//  Created by 김호종 on 2020/10/05.
//  Copyright © 2020 김호종. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if MovieData.shared.movieList.count < 1 {
            MovieData.shared.set {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = MovieData.shared.sortOpt.rawValue
        MovieData.shared.movieReloadHandler = { self.collectionView.reloadData() }
        MovieData.shared.titleHandler = { title in self.navigationItem.title = title }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetailViewController else { return }
        guard let cell = sender as? CollectionViewCell else { return }
        
        let backItem = UIBarButtonItem()
        backItem.title = "영화목록"
        navigationItem.backBarButtonItem = backItem
        
        vc.id = cell.id
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieData.shared.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let movie = MovieData.shared.movieList[indexPath.item]
        
        cell.id                     = movie.id
        cell.thumbnail.image        = UIImage.downloadImage(url: movie.thumbURL)
        cell.titleLabel.text        = movie.title
        cell.infoLabel.text         = "\(movie.reservationGrade)위 (\(movie.userRate)) / \(movie.reservationRate)%"
        cell.openDateLabel.text     = "\(movie.date.toString())"
        cell.gradeImageView.image   = Util.setGrade(movie.grade)
        
        return cell
    }
    @IBAction func settingAction(_ sender: Any) {
        Util.settingAction(vc: self)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:widthPerItem * 351/184)
    }
}

class CollectionViewCell: UICollectionViewCell {
    var id: String!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
}
