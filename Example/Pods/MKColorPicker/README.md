# MKColorPicker

[![CI Status](http://img.shields.io/travis/malkouz/MKColorPicker.svg?style=flat)](https://travis-ci.org/malkouz/MKColorPicker)
[![Version](https://img.shields.io/cocoapods/v/MKColorPicker.svg?style=flat)](http://cocoapods.org/pods/MKColorPicker)
[![License](https://img.shields.io/cocoapods/l/MKColorPicker.svg?style=flat)](http://cocoapods.org/pods/MKColorPicker)
[![Platform](https://img.shields.io/cocoapods/p/MKColorPicker.svg?style=flat)](http://cocoapods.org/pods/MKColorPicker)

##MKColorPicker
MKColorPicker is a fantastic color picker 🎨 written in Swift. Developers can use our color picker as is or they can customize it with all the available features

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

# Screenshot
![BubbleTransition](https://github.com/malkouz/MKColorPicker/blob/master/demo.gif)


## Requirements
iOS8+

## Installation

MKColorPicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MKColorPicker"
```

## How to use
```easy to use
import MKColorPicker

let MKColorPicker = MKColorPickerViewController()
MKColorPicker.selectedColor = { color in
    //Put your code that will be excuted when select a color
}

//To inialize the picker as popover controller
if let popoverController = MKColorPicker.popoverPresentationController{
    popoverController.delegate = MKColorPicker
    popoverController.permittedArrowDirections = .any
    popoverController.sourceView = sender
    popoverController.sourceRect = sender.bounds
}

self.present(MKColorPicker, animated: true, completion: nil)

```


## Customize your picker
```Customization
MKColorPicker.autoDismissAfterSelection = false //default: true

MKColorPicker.scrollDirection = .vertical //default: .horizontal

MKColorPicker.style = .square //default: .circle

MKColorPicker.pickerSize = CGSize(width: newWidth, height: newHeight) //default 250, 250


//Change default colors list "colorPalette.plist" contains array of hexa. colors, 
//you can simply change it to your colors or initialize your list from anywhere your want.
var colors = [UIColor]()
let path = Bundle.main.path(forResource: "colorPalette", ofType: "plist")
let pListArray = NSArray(contentsOfFile: path!)

if let colorPalettePlistFile = pListArray as? [String] {
    for col in colorPalettePlistFile{
        colors.append(UIColor(hex: col))
    }
}

MKColorPicker.allColors = colors

```



## Author

Moayad Al kouz, moayad_kouz9@hotmail.com

## License

MKColorPicker is available under the MIT license. See the LICENSE file for more info.
