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

public enum ColorPickerViewStyle {
    case square
    case circle
}

public enum ColorPickerViewSelectStyle {
    case check
    case none
}

open class ColorPickerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Open properties
    
    /// Array of UIColor you want to show in the color picker
    open var colors = [UIColor]()  {
        didSet {
            if colors.isEmpty {
                fatalError("ERROR ColorPickerView - You must set at least 1 color!")
            }
            collectionView.reloadData()
        }
    }
    /// The object that acts as the layout delegate for the color picker
    open var layoutDelegate: ColorPickerViewDelegateFlowLayout?
    /// The object that acts as the delegate for the color picker
    open var delegate: ColorPickerViewDelegate?
    /// The index of the selected color in the color picker 
    open var indexOfSelectedColor: Int? {
        return indexSelectedColor
    }
    /// The index of the preselected color in the color picker
    open var preselectedIndex: Int? = nil {
        didSet {
            guard let index = preselectedIndex else { return }
            guard index >= 0, colors.indices.contains(index) else {
                print("ERROR ColorPickerView - preselectedItem out of colors range")
                return
            }
            indexSelectedColor = preselectedIndex
            
            collectionView.selectItem(at: IndexPath(item: indexSelectedColor!, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
    /// If true, the selected color can be deselected by a tap
    open var isSelectedColorTappable: Bool = true
    /// If true, the preselectedIndex is showed in the center of the color picker
    open var scrollToPreselectedIndex: Bool = false
    /// Style of the color picker cells
    open var style: ColorPickerViewStyle = .circle{
        didSet{
            collectionView.reloadData()
        }
    }
    /// Style applied when a color is selected
    open var selectionStyle: ColorPickerViewSelectStyle = .check
    
    open var scrollDirection: UICollectionView.ScrollDirection = .horizontal{
        didSet{
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = scrollDirection
            
            collectionView.collectionViewLayout = layout
            collectionView.reloadData()
            collectionView.contentOffset.x = 0
            collectionView.contentOffset.y = 0
        }
    }
    
    // MARK: - Private properties
    fileprivate var indexSelectedColor: Int?
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ColorPickerCell.self, forCellWithReuseIdentifier: ColorPickerCell.cellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - View management
    
    open override func layoutSubviews() {
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        
        // Check on scrollToPreselectedIndex
        if let preselectedIndex = preselectedIndex, !scrollToPreselectedIndex {
            // Scroll to the first color
            collectionView.scrollToItem(at: IndexPath(item: preselectedIndex, section: 0), at: .top, animated: false)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorPickerCell.cellIdentifier, for: indexPath) as! ColorPickerCell
        
        cell.backgroundColor = colors[indexPath.item]
        
        if style == .circle {
            cell.layer.cornerRadius = cell.bounds.width / 2
        }else{
            cell.layer.cornerRadius = 0
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let colorPickerCell = cell as! ColorPickerCell
        
        guard selectionStyle == .check else { return }
        
        guard indexPath.item == indexSelectedColor else {
            colorPickerCell.setSelected(selected: false)
            
            return
        }
        
        colorPickerCell.setSelected(selected: true)
    }
    
    // TODO: - This method need to be refactored in order to be more readable and expressive
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let colorPickerCell = collectionView.cellForItem(at: indexPath) as! ColorPickerCell
        
        if indexPath.item == indexSelectedColor, !isSelectedColorTappable {
            return
        }
        
        if selectionStyle == .check {
            
            if indexPath.item == indexSelectedColor {
                if isSelectedColorTappable {
                    indexSelectedColor = nil
                    colorPickerCell.setSelected(selected: false)
                }
                return
            }
            
            indexSelectedColor = indexPath.item
            
            colorPickerCell.setSelected(selected: true)
            
        }
        
        delegate?.colorPickerView(self, didSelectItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        // Check if the old color cell is showed. If true, it deselects it
        guard let oldColorCell = collectionView.cellForItem(at: indexPath) as? ColorPickerCell else {
            return
        }
        
        if selectionStyle == .check {
            
            oldColorCell.setSelected(selected: false)
            
        }
        
        delegate?.colorPickerView?(self, didDeselectItemAt: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layoutDelegate = layoutDelegate, let sizeForItemAt = layoutDelegate.colorPickerView?(self, sizeForItemAt: indexPath) {
            return sizeForItemAt
        }
        return CGSize(width: 48, height: 48)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let layoutDelegate = layoutDelegate, let minimumLineSpacingForSectionAt = layoutDelegate.colorPickerView?(self, minimumLineSpacingForSectionAt: section) {
            return minimumLineSpacingForSectionAt
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let layoutDelegate = layoutDelegate, let minimumInteritemSpacingForSectionAt = layoutDelegate.colorPickerView?(self, minimumInteritemSpacingForSectionAt: section) {
            return minimumInteritemSpacingForSectionAt
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let layoutDelegate = layoutDelegate, let insetForSectionAt = layoutDelegate.colorPickerView?(self, insetForSectionAt: section) {
            return insetForSectionAt
        }
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}
