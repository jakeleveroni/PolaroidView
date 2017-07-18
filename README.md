# Project Name

A Custom UIView that tries to mimic the look and feel of a polaroid picture

## Installation

There is no easy way to install at the moment, im working on turning this 
project into a Cocoapod but for now just clone the repo and add the UIPolaroidView.swift 
and the ExtensionMethods.swift files to your project

## Usage

A custom UIView that looks like a polaroid picture, very easy to integrate.
Just create the polaroid UIView in and add it to the subview of a viewcontroller.
The images, button images, and text can all be set using either the helper functions
that the UIPolaroidView defines (setters), or through a Dictionary of [String:AnyObject?] 
as shown in the example below:

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(colorLiteralRed: 0, green: 88/255.0, blue: 122/255.0, alpha: 1)
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
    }
```
Example Output:

![Could not fetch example image](https://github.com/jakeleveroni/UIPolaroidView/blob/master/PolaroidExample.png)

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History
version 0.1.0 - Initial release 

## Credits

So far... ALL THE CREDIT GOES TO ME [jakeleveroni](https://github.com/jakeleveroni) but I really
hope some more people would like to get involved and flush out some more features!

## Future Features
* Automatic resizing/scaling of images for the main image view
* More customizeable i.e. Fonts, Colors, Buttons etc.
* More flexible layout for better resizing across different device sizes
* Turn project into a Cocoapod for easy project integration
* Other community feedback... if there is any

## License

This is an open source project liscences under the [Apache License Version 2.0](https://opensource.org/licenses/Apache-2.0)
