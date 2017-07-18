//
//  PolaroidView.swift
//  UIPolaroid
//
//  Created by Ryan Stack on 7/18/17.
//  Copyright © 2017 Jacob Leveroni. All rights reserved.
//

import UIKit
import QuartzCore

// setting your default values

public class PolaroidBuilder {
    var mainImage: UIImage? = UIImage(named: "content")
    var userImage: UIImage? = UIImage(named: "Solaire")
    var buttonOneSelectedImage: UIImage? = UIImage(named: "LikeSelected")
    var buttonOneUnselectedImage: UIImage? = UIImage(named: "LikeUnselected")
    var buttonTwoSelectedImage: UIImage?
    var buttonTwoUnselectedImage: UIImage? = UIImage(named: "Comments-50")
    var username: String?
    var caption: String?
    var backgroundColor: UIColor = .white
    
    typealias PolaroidBuilderClosure = (PolaroidBuilder) -> Void
    
    init(buildClosure: PolaroidBuilderClosure) {
        buildClosure(self)
    }
}

public protocol PolaroidViewDelegate: class {
    func polaroidView(_ view: PolaroidView, didPressButtonOne button: UIButton)
    func polaroidView(_ view: PolaroidView, didPressButtonTwo button: UIButton)
}

public class PolaroidView: UIView {

    public lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var buttonOne: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.didPressButtonOne), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.setContentHuggingPriority(UILayoutPriorityDefaultLow + 1, for: .horizontal)
        return button
    }()
    
    public lazy var buttonTwo: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.didPressButtonTwo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.setContentHuggingPriority(UILayoutPriorityDefaultLow + 1, for: .horizontal)
        return button
    }()
    
    public lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Noteworthy-Bold", size: 16)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // this makes the label stretch as far as it can based on its layout
        label.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriorityDefaultLow - 1, for: .horizontal)
        return label
    }()
    
    public lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Noteworthy-Light", size: 12)
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8.0
        return stackView
    }()
    
    fileprivate lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8.0
        return stackView
    }()
    
    
    // always instantiate delegates as weak or else you will have a retain cycle
    // Object A strongly points to Object B and vice versa. They'll never deallocate
    // properly.
    
    weak var delegate: PolaroidViewDelegate?
    
    // instead of magic numbers, declare them as a variable
    
    fileprivate let margin: CGFloat = 12
    fileprivate let defaultUserImageWidth: CGFloat = 30
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutViews()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layoutIfNeeded()
        userImageView.layer.cornerRadius = userImageView.bounds.width/2
    }
    
    // This is essentiall the same as using a view model-esque
    // sort of class. It takes in an object that describes the view.
    
    public func render(builder: PolaroidBuilder) {
        mainImageView.image = builder.mainImage
        userImageView.image = builder.userImage
        buttonOne.setImage(builder.buttonOneSelectedImage, for: .selected)
        buttonOne.setImage(builder.buttonOneUnselectedImage, for: .normal)
        buttonTwo.setImage(builder.buttonTwoSelectedImage, for: .selected)
        buttonTwo.setImage(builder.buttonTwoUnselectedImage, for: .normal)
        userNameLabel.text = builder.username
        captionLabel.text = builder.caption
        backgroundColor = builder.backgroundColor
    }
}

fileprivate extension PolaroidView {
    
    func layoutViews() {
        addSubview(verticalStackView)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        

        verticalStackView.addArrangedSubview(mainImageView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(captionLabel)
        
        horizontalStackView.addArrangedSubview(userImageView)
        horizontalStackView.addArrangedSubview(userNameLabel)
        horizontalStackView.addArrangedSubview(buttonOne)
        horizontalStackView.addArrangedSubview(buttonTwo)
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            // Switching around because they would be pushed past the view otherwise
            bottomAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: margin),
            trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: margin),
            // 1:1 ratio
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: defaultUserImageWidth),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor)
        ])
        
    }
    
    // you have to add @objc so the objc runtime can see the fileprivate method
    
    @objc func didPressButtonOne(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.polaroidView(self, didPressButtonOne: sender)
    }
    
    @objc func didPressButtonTwo(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.polaroidView(self, didPressButtonTwo: sender)
    }
}
