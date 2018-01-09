//
//  ViewController.swift
//  UIPolaroid
//
//  Created by Jacob Leveroni on 7/14/17.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var polaroidView: PolaroidView = {
        let builder = PolaroidBuilder {
            $0.username = "Jane Doe"
            $0.caption = "This is where a caption would go"
        }
        
        let view = PolaroidView()
        view.render(builder: builder)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(colorLiteralRed: 0, green: 88/255.0, blue: 122/255.0, alpha: 1)
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

