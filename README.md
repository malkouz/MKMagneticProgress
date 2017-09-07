# MKMagneticProgress

[![Version](https://img.shields.io/cocoapods/v/MKMagneticProgress.svg?style=flat)](http://cocoapods.org/pods/MKMagneticProgress)
[![License](https://img.shields.io/cocoapods/l/MKMagneticProgress.svg?style=flat)](http://cocoapods.org/pods/MKMagneticProgress)
[![Platform](https://img.shields.io/cocoapods/p/MKMagneticProgress.svg?style=flat)](http://cocoapods.org/pods/MKMagneticProgress)


<h1 align="center">MKMagneticProgress</h1>
<h3 align="center">A circular progress bar for iOS written in Swift</h3>

<p align="center">
<img src="https://github.com/malkouz/MKMagneticProgress/raw/master/demo.gif"/>  
</p>

## Features

* Interface builder designable
* Highly customizable and flexible
* Easy to use
* Written in Swift

## Installation 

### CocoaPods (Recommended)

1. Install [CocoaPods](https://cocoapods.org)
2. Add this repo to your `Podfile`

```ruby
target 'Example' do
# IMPORTANT: Make sure use_frameworks! is included at the top of the file
use_frameworks!
platform :ios, '8.0'
pod 'MKMagneticProgress'
end
```
3. Run `pod install`
4. Open up the `.xcworkspace` that CocoaPods created
5. Done!

### Manually

Simply download the `MKMagneticProgress.swift` file from [here](https://github.com/malkouz/MKMagneticProgress/blob/master/MKMagneticProgress/Classes/MKMagneticProgress.swift) into your project, make sure you point to your projects target

## Usage

### Interface Builder

Simply drag a `UIView` into your storyboard. Make sure to subclass `MKMagneticProgress` and that the module points `MKMagneticProgress`. 

Design your heart out

![ib-demo.gif](https://github.com/malkouz/MKMagneticProgress/raw/master/IB.gif)

### Usage

```swift
import MKMagneticProgress


@IBOutlet weak var magProgress:MKMagneticProgress!

override func viewDidLoad() {
    magProgress.setProgress(progress: 0.5, animated: true)
    magProgress.progressShapeColor = UIColor.blue
    magProgress.backgroundShapeColor = UIColor.yellow
    magProgress.titleColor = UIColor.red
    magProgress.percentColor = UIColor.black

    magProgress.lineWidth = 10
    magProgress.orientation = .top
    magProgress.lineCap = .round

    magProgress.title = "Title"
    magProgress.percentLabelFormat = "%.2f%%"

}
```

## Example project

Take a look at the example project over [here](Example/)

1. Download it
2. Open the `Example.xcworkspace` in Xcode
3. Enjoy!



## Author

Moayad Al kouz, moayad_kouz9@hotmail.com
</p>
Twitter : @malkouz

## License

MKMagneticProgress is available under the MIT license. See the LICENSE file for more info.

