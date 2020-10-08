//
//  DetailViewController.swift
//  TheMovie
//
//  Created by 오디언 on 2020/10/08.
//  Copyright © 2020 김호종. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var id: String?
    var movie: MovieDetail?
    var commentList = [Comment]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate                  = self
        tableView.dataSource                = self
        
        if let id = id {
            APIManager.movieDetail(id: id, completion: { detail in
                self.movie = detail
                self.navigationItem.title = self.movie?.title
                
                APIManager.comments(movieId: detail.id, completion: { comments in
                    self.commentList = comments
                    self.tableView.reloadData()
                    
                })
            })
        }
    }
    @IBAction func commentWriteAction(_ sender: Any) {
        performSegue(withIdentifier: "commentWrite", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? CommentWriteViewController else { return }
        guard let movie = movie else { return }
        vc.movieId      = movie.id
        vc.movieTitle   = movie.title
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if movie != nil { return 4 }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 { return commentList.count }
        else            { return 1 }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor          = UIColor(rgb: 0xD2D2D2)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor          = UIColor.white
        if section == 3 {
            // 버튼 추가
            // 기존 버튼이 있다면 위치만 변경
            let size = view.frame.height
            
            var count = 0
            
            for buttonView in view.subviews {
                if buttonView.isKind(of: UIButton.self) {
                    count += 1
                    
                    buttonView.frame = CGRect(x: view.frame.width-size-10, y: 0, width: size, height: size)
                    
                    view.layoutIfNeeded()
                    view.setNeedsLayout()
                    
                    break
                }
            }
            
            if count < 1 {
                
                let button = UIButton(frame: CGRect(x: view.frame.width-size-10, y: 0, width: size, height: size))
                button.setTitle("", for: .normal)
                button.setImage(UIImage(named: "btn_compose"), for: .normal)
                
                button.addTarget(self, action: #selector(commentWriteAction(_:)), for: .touchUpInside)
                
                view.addSubview(button)
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if      section == 1 { return "줄거리" }
        else if section == 2 { return "감독/출연" }
        else if section == 3 { return "한줄평" }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movie else { return UITableViewCell() }
        if indexPath.section == 0 {
            // 영화 정보 셀
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoCell", for: indexPath) as! MovieInfoCell
            
            
            cell.thumbImageView.image       = UIImage.downloadImage(url: movie.imageURL)
            cell.titleLabel.text            = movie.title
            cell.gradeImageView.image       = Util.setGrade(movie.grade)
            cell.dateLabel.text             = "\(movie.date.toString()) 개봉"
            cell.typeLabel.text             = "\(movie.genre) \(movie.duration)분"
            cell.reservationLabel.text      = "\(movie.reservationGrade)위 \(movie.reservationRate)%"
            cell.rateScoreLabel.text        = "\(movie.userRating)"
            cell.customerCountLabel.text    = Util.numberComma(value: movie.audience)
            cell.ratingView.rate            = movie.userRating
            
            return cell
        }
        else if indexPath.section == 1 {
            // 줄거리 셀
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSynopsisCell", for: indexPath) as! MovieSynopsisCell
            
            cell.synopsisLabel.text = movie.synopsis
            
            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDirectorCell", for: indexPath) as! MovieDirectorCell
            
            cell.directorLabel.text = movie.director
            cell.actorLabel.text    = movie.actor
            
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            
            let comment = commentList[indexPath.row]
            
            cell.writerLabel.text   = comment.writer
            cell.ratingView.rate    = comment.rating
            cell.dateLabel.text     = comment.date.toString()
            cell.commentLabel.text  = comment.contents
            
            return cell
        }
        
        
        return UITableViewCell()
    }
}

class MovieInfoCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var reservationLabel: UILabel!
    @IBOutlet weak var rateScoreLabel: UILabel!
    @IBOutlet weak var customerCountLabel: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var thumbButton: UIButton!
    
    @IBAction func thumbnailTouchAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PosterViewController") as! PosterViewController
        vc.posterImage = thumbImageView.image
        
        UIApplication.topViewController()?.present(vc, animated: true)
    }
}

class MovieSynopsisCell: UITableViewCell {
    @IBOutlet weak var synopsisLabel: UILabel!
}

class MovieDirectorCell: UITableViewCell {
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
}

class CommentCell: UITableViewCell {
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
}
