//
//  SProgressView.swift
//  progressivebarTest
//
//  Created by Youngmin Park on 9/29/21.
//

import UIKit

@IBDesignable class SProgressView: UIView {
    @IBInspectable public var progress: CGFloat = -1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var progressTintColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var trackTintColor: UIColor = .clear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var progressOutlineColor: UIColor = .gray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var lineWidth: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
                
    public override func prepareForInterfaceBuilder() {
        if progress < 0 {
            progress = 0.5 // Showing bar color with Strory board and XIB
        }
    }
    
    private let animationBarView = UIView()
    
    override public func draw(_ rect: CGRect)
    {
        if let context = UIGraphicsGetCurrentContext()
        {
            context.setLineWidth(lineWidth);
            
            let cornerRadius = rect.height / 2
            layer.cornerRadius = cornerRadius
            
            let backgroundPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
            context.addPath(backgroundPath)
            context.setFillColor(trackTintColor.cgColor)
            context.closePath()
            context.fillPath()
            
            let barRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.width * progress, height: rect.height)
            let barPath = UIBezierPath(roundedRect: barRect, cornerRadius: cornerRadius).cgPath
            context.addPath(barPath)
            context.setFillColor(progressTintColor.cgColor)
            context.closePath()
            context.fillPath()
            
            if lineWidth > 0 {
                let lineRect = rect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
                let linePath = UIBezierPath(roundedRect: lineRect, cornerRadius: cornerRadius).cgPath
                context.addPath(linePath)
                context.setStrokeColor(progressOutlineColor.cgColor)
                context.closePath()
                context.strokePath()
            }
        }
    }
    
    func setProgress(_ progress: CGFloat, animated: Bool) {
        if animated {
            addSubview(animationBarView)
            animationBarView.backgroundColor = progressTintColor
            animationBarView.layer.cornerRadius = (layer.cornerRadius - lineWidth)
            animationBarView.isHidden = false
            animationBarView.frame = CGRect(x: lineWidth, y: lineWidth, width: 0, height: frame.height - (lineWidth * 2))
                                        
            self.progress = 0
            
            UIView.animate(withDuration:0.3, delay:0, options: [.curveLinear], animations: {
                
                self.animationBarView.frame = CGRect(x: self.lineWidth, y: self.lineWidth,
                                                     width: (self.frame.width * progress) - (self.lineWidth * 2),
                                                     height: self.frame.height - (self.lineWidth * 2))
            }, completion: { finishied in
                self.animationBarView.isHidden = true
                self.progress = progress
            })
        }
        else {
            self.progress = progress
        }
        
        setNeedsDisplay()
    }
}
