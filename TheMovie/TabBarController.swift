//
//  ViewController.swift
//  TheMovie
//
//  Created by 김호종 on 2020/09/22.
//  Copyright © 2020 김호종. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MovieData.shared.titleHandler = { title in
            self.navigationItem.title = title
        }
    }
    
    @IBAction func settingAction(_ sender: Any) {
        //action sheet title 지정
        
        let optionMenu = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        //옵션 초기화
        let rateAction = UIAlertAction(title: "예매율", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            MovieData.shared.sortOpt = .rate
        })
        let curationAction = UIAlertAction(title: "큐레이션", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            MovieData.shared.sortOpt = .curation
        })
        let dateAction = UIAlertAction(title: "개봉일", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            MovieData.shared.sortOpt = .date
            
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        //action sheet에 옵션 추가.
        optionMenu.addAction(rateAction)
        optionMenu.addAction(curationAction)
        optionMenu.addAction(dateAction)
        optionMenu.addAction(cancelAction)
        //show
        self.present(optionMenu, animated: true, completion: nil)
    }
}
