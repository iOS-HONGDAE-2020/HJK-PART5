//
//  Util.swift
//  TheMovie
//
//  Created by 오디언 on 2020/10/08.
//  Copyright © 2020 김호종. All rights reserved.
//

import Foundation
import UIKit

class Util {
    class func settingAction(vc: UIViewController) {
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
        vc.present(optionMenu, animated: true, completion: nil)
    }
    
    class func setGrade(_ grade: Int) -> UIImage? {
        if grade == 12 {
            return UIImage(named: "ic_12")
        } else if grade == 15 {
            return UIImage(named: "ic_15")
        } else if grade == 19 {
            return UIImage(named: "ic_19")
        } else {
            return UIImage(named: "ic_allages")
        }
    }
    
    class func numberComma(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value)) ?? "0" 
            
            return result
        }

}


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
