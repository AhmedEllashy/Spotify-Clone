//
//  exenstions.swift
//  Spotify Clone
//
//  Created by Ahmad Ellashy on 23/03/2024.
//

import UIKit


extension UIView {
    func addBorderRadius(){
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 20
    }
     var width : CGFloat {
        return frame.size.width
    }
     var height : CGFloat {
        return frame.size.height
    }
     var left : CGFloat {
        return frame.origin.x
    }
     var right : CGFloat {
        return left + width
    }
     var top : CGFloat {
        return frame.origin.y
    }
     var bottom : CGFloat {
        return top + height
    }

}

extension DateFormatter {
    static let dateFormmater : DateFormatter = {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "YYYY-MM-DD"
        return dateFormmater
    }()
    static let displayDateFormatter : DateFormatter = {
        let dateFormmater = DateFormatter()
        dateFormmater.dateStyle = .medium
        return dateFormmater
    }()
}
extension String {
    static func formateDate(for str : String) -> String{
        guard let date = DateFormatter.dateFormmater.date(from: str) else{
            return str
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}
