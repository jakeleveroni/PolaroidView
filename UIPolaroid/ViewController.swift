//
//  ViewController.swift
//  UIPolaroid
//
//  Created by Jacob Leveroni on 7/14/17.
//  Copyright © 2017 Jacob Leveroni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var polaroidView: PolaroidView = {
        let builder = PolaroidBuilder {
            $0.username = "Bob"
            $0.caption = "Here's my caption"
        }
        
        let view = PolaroidView()
        view.render(builder: builder)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(colorLiteralRed: 0, green: 88/255.0, blue: 122/255.0, alpha: 1)
        /**
        let polaroid = UIPolaroidView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.5).integral)
        polaroid.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        
        let configDict : [String:AnyObject?] = [
            "MainImage":UIImage(imageLiteralResourceName: "content.jpg"),
            "UserImage":UIImage(imageLiteralResourceName: "Solaire.png"),
            "ButtonOne-Unselected":UIImage(imageLiteralResourceName: "LikeUnselected.png"),
            "ButtonOne-Selected":UIImage(imageLiteralResourceName: "LikeSelected.png"),
            "ButtonTwo-Unselected":UIImage(imageLiteralResourceName: "Comments-50.png"),
            "ButtonTwo-Selected":nil,
            "UserName":"User Name" as AnyObject,
            "Caption":"This is where an image caption can be shown, so that users can #hashtag all they want" as AnyObject
        ]
        
        polaroid.InitFromConfig(config: configDict)
         view.addSubview(polaroid)
         **/
        
        layoutView()
        
    }
    
    func layoutView() {
        
        view.addSubview(polaroidView)
        
        NSLayoutConstraint.activate([
            polaroidView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            polaroidView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            view.trailingAnchor.constraint(equalTo: polaroidView.trailingAnchor, constant: 50)
        ])
    }
}

