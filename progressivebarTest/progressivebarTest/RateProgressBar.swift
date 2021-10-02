//
//  RateProgressBar.swift
//  SephoraSampleProject
//
//  Created by Youngmin Park on 4/14/20.
//  Copyright © 2020 Youngmin Park. All rights reserved.
//

import UIKit

@IBDesignable class RateProgressBar: UIView {
    
    private var grayImage: UIImage?
    private var image: UIImage?

    @IBInspectable public var numberOfImages: Int = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var rate0to1: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var grayImageName: String = "" {
        didSet {
            if let image = UIImage(named: grayImageName, in: Bundle(for: type(of: self)), compatibleWith: nil) {
                self.grayImage = image
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable public var imageName: String = "" {
        didSet {
            if let image = UIImage(named: imageName, in: Bundle(for: type(of: self)), compatibleWith: nil) {
                self.image = image
                setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        if let image = self.image, let grayImage = self.grayImage {
            
            let imageHeight = frame.height
            let imageWidth = image.size.width * (imageHeight / image.size.height)
            
            let horizontalSpace = (frame.width - (imageWidth * CGFloat(numberOfImages))) / CGFloat(numberOfImages - 1)
            
            for index in 0..<numberOfImages {
                let xOffset = (imageWidth * CGFloat(index)) + (horizontalSpace * CGFloat(index))
                let totalRate = rate0to1 * CGFloat(numberOfImages)
                let currentImageRate = totalRate - CGFloat(index)
                
                let rect = CGRect(x: xOffset, y: 0, width: imageWidth, height: imageHeight)
                
                if currentImageRate > 1 {
                    image.draw(in: rect)
                } else if currentImageRate <= 0 {
                    grayImage.draw(in: rect)
                } else { //if currentImageRate > 0 && currentImageRate < 1
                    grayImage.draw(in: rect)
                    
                    var cropImageRect = CGRect(origin: CGPoint(), size: image.size)
                    cropImageRect.size.width = image.size.width * currentImageRate
                    
                    if let cgImage = image.cgImage?.cropping(to: cropImageRect) {
                        let cropImage = UIImage(cgImage: cgImage)
                        
                        var cropRect = rect
                        cropRect.size.width = cropRect.size.width * currentImageRate
                        cropImage.draw(in: cropRect)
                    }
                }
            }
        }
    }
}
 
