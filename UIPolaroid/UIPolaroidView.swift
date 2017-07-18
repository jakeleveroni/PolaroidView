//
//  UIPolaroidView.swift
//  UIPolaroid
//
//  Created by Jacob Leveroni on 7/14/17.
//  Copyright © 2017 Jacob Leveroni. All rights reserved.
//

import UIKit
import Foundation

public class UIPolaroidView : UIView {
    
    public var ImageFrame : UIImageView? = nil
    public var UserImageView : UIImageView? = nil
    
    private var Button_one : UIButton? = nil
    private var Button_two : UIButton? = nil
    private var UserNameView : UITextView? = nil
    private var CaptionTextView : UITextView? = nil
    private var CaptionView : UIView? = nil
    private var BaseInitComplete : Bool = false
    private let bgColor :UIColor = UIColor.white//UIColor(colorLiteralRed: 245.0/255.0, green: 245.0/255.0, blue: 220.0/255.0, alpha: 1)
    public override init(frame: CGRect) {
        super.init(frame: frame.integral)
        customInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customInit() {
        let sWidth = self.frame.width
        let sHeight = self.frame.height
        
        // init main view
        self.backgroundColor = bgColor
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 5.0
        
        // init imageview
        self.ImageFrame = UIImageView(frame: CGRect(x: Double(sWidth * 0.05),
                                                    y: Double(sHeight * 0.05),
                                                    width: Double(sWidth * 0.9),
                                                    height: Double(sHeight * 0.65)).integral)
        
        self.ImageFrame?.layer.borderColor = UIColor.black.cgColor
        self.ImageFrame?.layer.borderWidth = 0.5
        
        // init caption view area
        self.CaptionView = UIView(frame: CGRect(x: Double(sWidth * 0.05),
                                                y: Double((self.ImageFrame?.frame.maxY)! + (self.ImageFrame?.frame.height)! * 0.02),
                                                width: Double(sWidth * 0.9),
                                                height: Double(sHeight * 0.25)).integral)

        // init the user image view
        let captionWidth = self.CaptionView?.frame.width
        
        self.UserImageView = UIImageView(frame: CGRect(x: Double((self.CaptionView?.bounds.minX)! + ((self.CaptionView?.bounds.width)! * 0.02)),
                                                       y: Double((self.CaptionView?.bounds.minY)! + ((self.CaptionView?.bounds.height)! * 0.035)),
                                                       width: Double(captionWidth! * 0.1),
                                                       height: Double(captionWidth! * 0.1)).integral)
        
        self.UserImageView?.layer.cornerRadius = (self.UserImageView?.frame.size.height)! / 2
        self.UserImageView?.layer.borderWidth = 0.5
        self.UserImageView?.layer.borderColor = UIColor.black.cgColor
        self.UserImageView?.layer.masksToBounds = true
        self.UserImageView?.layer.allowsEdgeAntialiasing = true
        
        
        // init UserName view
        self.UserNameView = UITextView(frame: CGRect(x: Double((self.UserImageView?.frame.maxX)! + ((self.UserImageView?.frame.width)! * 0.2)),
                                                     y: Double((self.CaptionView?.bounds.minY)! + ((self.CaptionView?.bounds.height)! * 0.035)),
                                                     width: Double((self.CaptionView?.bounds.width)! * 0.5),
                                                     height: Double((self.UserImageView?.bounds.height)!)).integral)
        
        self.UserNameView?.backgroundColor = bgColor
        self.UserNameView?.font = UIFont(name: "Noteworthy-Bold", size: 16)
        self.UserNameView?.centerVertically()

        // init the buttons
        self.Button_one = UIButton(frame: CGRect(x: Double((self.UserNameView?.frame.maxX)! + ((self.UserNameView?.frame.width)! * 0.2)),
                                                 y: Double((self.UserNameView?.frame.minY)!),
                                                 width: Double(captionWidth! * 0.1),
                                                 height: Double(captionWidth! * 0.1)).integral)
            
        self.Button_two = UIButton(frame: CGRect(x: Double((self.Button_one?.frame.maxX)! + ((self.Button_one?.frame.width)! * 0.2)),
                                                 y: Double((self.Button_one?.frame.minY)!),
                                                 width: Double(captionWidth! * 0.1),
                                                 height: Double(captionWidth! * 0.1)).integral)
        
        // init the caption
        self.CaptionTextView = UITextView(frame: CGRect(x: Double((self.CaptionView?.bounds.minX)! + ((self.CaptionView?.bounds.width)! * 0.02)),
                                                        y: Double((self.UserImageView?.bounds.maxY)! + ((self.UserImageView?.frame.height)! * 0.3)),
                                                        width: Double((self.CaptionView?.bounds.width)! * 0.96),
                                                        height: Double((self.CaptionView?.bounds.height)! * 0.65)).integral)
        
        self.CaptionTextView?.backgroundColor = bgColor
        self.CaptionTextView?.font = UIFont(name: "Noteworthy-Light", size: 12)
        self.CaptionTextView?.textContainer.maximumNumberOfLines = 2
        self.CaptionTextView?.textContainer.lineBreakMode = .byTruncatingTail
        
        // add the subviews
        self.CaptionView?.addSubview(UserImageView!)
        self.CaptionView?.addSubview(UserNameView!)
        self.CaptionView?.addSubview(Button_one!)
        self.CaptionView?.addSubview(Button_two!)
        self.CaptionView?.addSubview(CaptionTextView!)
        self.addSubview(ImageFrame!)
        self.addSubview(CaptionView!)
        
        self.BaseInitComplete = true
    }
    
    public func SetUserNameText(userName: String!) -> Bool {
        if self.BaseInitComplete {
            self.UserNameView?.text = userName
            return true
        }

        return false
    }
    
    public func SetCaptionText(caption: String!) -> Bool {
        if self.BaseInitComplete {
            self.CaptionTextView?.text = caption
            return true
        }
        
        return false
    }
    
    public func SetButtonImages(buttonOneImage: UIImage, buttonTwoImage: UIImage) -> Bool{
        if self.BaseInitComplete {
            self.Button_one?.setImage(buttonOneImage, for: .normal)
            self.Button_two?.setImage(buttonTwoImage, for: .normal)
            return true
        }
        
        return false
    }
    
    public func SetSelectedAndUnselectedButtonImages(nonSelectButtonOne: UIImage!, nonSelectButtonTwo: UIImage!, selectButtonOne: UIImage?, selectButtonTwo: UIImage?) -> Bool {
        
        if self.BaseInitComplete {
            self.Button_one?.setImage(nonSelectButtonOne, for: .normal)
            self.Button_two?.setImage(nonSelectButtonTwo, for: .normal)
            
            if selectButtonOne != nil {
                self.Button_one?.setImage(selectButtonOne!, for: .selected)
            }
            
            if selectButtonTwo != nil {
                self.Button_two?.setImage(selectButtonTwo!, for: .selected)
            }
                        
            return true
        }
        
        return false
    }
    
    public func InitFromConfig(config: [String:AnyObject?]) {
        
        if let mainImage = config["MainImage"] {
            ImageFrame?.image = mainImage as? UIImage
        }
        
        if let userImage = config["UserImage"] {
            UserImageView?.image = userImage as? UIImage
        }
        
        if let btnOneUnsel = config["ButtonOne-Unselected"] {
            Button_one?.setImage(btnOneUnsel as? UIImage, for: .normal)
        }
        
        if let btnOneSel = config["ButtonOne-Selected"] {
            Button_one?.setImage(btnOneSel as? UIImage, for: .selected)
        }
        
        if let btnTwoUnsel = config["ButtonTwo-Unselected"] {
            Button_two?.setImage(btnTwoUnsel as? UIImage, for: .normal)
        }
        
        if let btnTwoSel = config["ButtonTwo-Selected"] {
            Button_two?.setImage(btnTwoSel as? UIImage, for: .selected)
        }
        
        if let userName = config["UserName"] {
            UserNameView?.text = userName as? String
        }
        
        if let caption = config["Caption"] {
            CaptionTextView?.text = caption as? String
        }
    }
}
