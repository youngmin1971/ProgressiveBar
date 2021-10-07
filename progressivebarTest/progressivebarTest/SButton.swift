//
//  SButton.swift
//
//  Created by youngmin on 26/12/2018.
//  Copyright © 2018 youngmin. All rights reserved.
//

import UIKit

@IBDesignable
public class SButton: UIButton {

    @IBInspectable var imagePadding:CGFloat = 0 {
        didSet {
            refreshInsets()
        }
    }

    @IBInspectable var isTextBottom:Bool = false {
        didSet {
            refreshInsets()
        }
    }

    @IBInspectable var defaultBackgroundColor:UIColor = UIColor.clear {
        didSet {
            setBackgroundImage(getColorImage(color:defaultBackgroundColor), for: .normal)
        }
    }

    @IBInspectable var heighlightedBackgroundColor:UIColor = UIColor.clear {
        didSet {
            setBackgroundImage(getColorImage(color:heighlightedBackgroundColor), for: .highlighted)
        }
    }

    @IBInspectable var selectedBackgroundColor:UIColor = UIColor.clear {
        didSet {
            setBackgroundImage(getColorImage(color:selectedBackgroundColor), for: .selected)
        }
    }

    @IBInspectable var disabledBackgroundColor:UIColor = UIColor.clear {
        didSet {
            setBackgroundImage(getColorImage(color:disabledBackgroundColor), for: .disabled)
        }
    }

    @IBInspectable var borderColor:UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    /// Should the corner be as circle
    public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    @IBInspectable
    /// Corner radius of view; also inspectable from Storyboard.
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = circleCorner ? min(bounds.size.height, bounds.size.width) / 2 : newValue
            //abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    private func getColorImage(color: UIColor) ->UIImage? {
        let rect = CGRect(origin: .zero, size:CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    private func refreshInsets() {
        if isTextBottom {
            if(self.imageView == nil || self.titleLabel == nil) {
                return
            }
            
            let imageViewSize = self.imageView?.frame.size
            let titleLabelSize = self.titleLabel?.frame.size
            
            let totalHeight = imageViewSize!.height + titleLabelSize!.height + imagePadding
            
            self.imageEdgeInsets.top = -(totalHeight - imageViewSize!.height)
            self.imageEdgeInsets.right = -titleLabelSize!.width
            
            self.titleEdgeInsets.left = -imageViewSize!.width
            self.titleEdgeInsets.bottom = -(totalHeight - titleLabelSize!.height)
        }
        else {
            self.titleEdgeInsets.left = imagePadding
        }
    }
}
