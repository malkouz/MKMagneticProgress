//
// Copyright (c) 2017 malkouz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

open class ColorPickerViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    open var selectedColor:((_ color:UIColor)->())?
    open var autoDismissAfterSelection = true
    open var style: ColorPickerViewStyle = .circle{
        didSet{
            colorPickerView.style = style
        }
    }
    
    open var defaultPaletteColors = [#colorLiteral(red: 1, green: 0.5411764706, blue: 0.5019607843, alpha: 1), #colorLiteral(red: 1, green: 0.09019607843, blue: 0.2666666667, alpha: 1), #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1),
                                     #colorLiteral(red: 0.7254901961, green: 0.9647058824, blue: 0.7921568627, alpha: 1), #colorLiteral(red: 0, green: 0.9019607843, blue: 0.462745098, alpha: 1), #colorLiteral(red: 0, green: 0.7843137255, blue: 0.3254901961, alpha: 1),
                                     #colorLiteral(red: 0.9176470588, green: 0.5019607843, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.8352941176, green: 0, blue: 0.9764705882, alpha: 1), #colorLiteral(red: 0.6666666667, green: 0, blue: 1, alpha: 1),
                                     #colorLiteral(red: 1, green: 1, blue: 0.5529411765, alpha: 1), #colorLiteral(red: 1, green: 0.9176470588, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.8392156863, blue: 0, alpha: 1),
                                     #colorLiteral(red: 0.7019607843, green: 0.5333333333, blue: 1, alpha: 1), #colorLiteral(red: 0.3960784314, green: 0.1215686275, blue: 1, alpha: 1), #colorLiteral(red: 0.3843137255, green: 0, blue: 0.9176470588, alpha: 1),
                                     #colorLiteral(red: 1, green: 0.8196078431, blue: 0.5019607843, alpha: 1), #colorLiteral(red: 1, green: 0.568627451, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.4274509804, blue: 0, alpha: 1),
                                     #colorLiteral(red: 0.5490196078, green: 0.6196078431, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.6901960784, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.568627451, blue: 0.9176470588, alpha: 1),
                                     #colorLiteral(red: 1, green: 0.6196078431, blue: 0.5019607843, alpha: 1), #colorLiteral(red: 1, green: 0.2392156863, blue: 0, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.1725490196, blue: 0, alpha: 1),
                                     #colorLiteral(red: 0.5019607843, green: 0.8470588235, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.6901960784, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.568627451, blue: 0.9176470588, alpha: 1),
                                     #colorLiteral(red: 0.737254902, green: 0.6666666667, blue: 0.6431372549, alpha: 1), #colorLiteral(red: 0.4745098039, green: 0.3333333333, blue: 0.2823529412, alpha: 1), #colorLiteral(red: 0.3058823529, green: 0.2039215686, blue: 0.1803921569, alpha: 1),
                                     #colorLiteral(red: 0.5176470588, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.8980392157, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.7215686275, blue: 0.831372549, alpha: 1),
                                     #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1), #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1), #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)]
    
    open var pickerSize = CGSize(width: 250, height: 250){
        didSet{
            self.view.frame = CGRect(x: 0, y: 0, width: pickerSize.width, height: pickerSize.height)
            self.preferredContentSize = pickerSize
            
            
        }
    }
    
    open var allColors = [UIColor](){
        didSet{
            colorPickerView.colors = allColors
        }
    }
    
    open var scrollDirection: UICollectionView.ScrollDirection = .horizontal{
        didSet{
            colorPickerView.scrollDirection = scrollDirection
        }
    }

    
    
    
    let colorPickerView = ColorPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
   
    
    
    public init()
    {
        super.init(nibName: nil, bundle: nil)
        
        self.setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        allColors = defaultPaletteColors
        colorPickerView.layoutDelegate = self
        colorPickerView.delegate = self
        colorPickerView.style = style
        colorPickerView.selectionStyle = .check
        colorPickerView.isSelectedColorTappable = false
//        colorPickerView.preselectedIndex = colorPickerView.colors.indices.first
        colorPickerView.colors = allColors
        self.view = colorPickerView
        self.preferredContentSize = colorPickerView.frame.size
        self.modalPresentationStyle = .popover
        
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - UIPopoverPresentationControllerDelegate
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
}

// MARK: - ColorPickerViewDelegateFlowLayout
extension ColorPickerViewController: ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout{
    
    // MARK: - ColorPickerViewDelegate
    
    public func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        self.selectedColor?(colorPickerView.colors[indexPath.item])
        //self.selectedColorView.backgroundColor = colorPickerView.colors[indexPath.item]
        if autoDismissAfterSelection{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - ColorPickerViewDelegateFlowLayout
    public func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
    
    public func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    public func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    public func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

