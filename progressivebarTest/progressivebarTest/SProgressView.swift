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
    
    //MARK:- Initializing
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true  // must be clipToBounds for round edge with small number of rate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func awakeFromNib() {
        self.clipsToBounds = true
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
            
            if lineWidth > 0 {
                let lineRect = rect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
                let linePath = UIBezierPath(roundedRect: lineRect, cornerRadius: cornerRadius).cgPath
                context.addPath(linePath)
                context.setStrokeColor(progressOutlineColor.cgColor)
                context.closePath()
                context.strokePath()
            }
            let xOffset = rect.width - (rect.width * progress)
            let barRect = CGRect(x: -xOffset, y: rect.origin.y, width: rect.width, height: rect.height)
            let barPath = UIBezierPath(roundedRect: barRect, cornerRadius: cornerRadius).cgPath
            context.addPath(barPath)
            context.setFillColor(progressTintColor.cgColor)
            context.closePath()
            context.fillPath()
        }
    }
    
    func setProgress(_ progress: CGFloat, animated: Bool) {
        if animated {
            addSubview(animationBarView)
            animationBarView.backgroundColor = progressTintColor
            animationBarView.layer.cornerRadius = layer.cornerRadius
            animationBarView.isHidden = false
            animationBarView.frame = CGRect(x: -frame.width, y: 0, width: frame.width, height: frame.height)
                                        
            self.progress = 0
            
            UIView.animate(withDuration:0.3, delay:0, options: [.curveLinear], animations: {
                let xOffset = self.frame.width - (self.frame.width * progress)
                self.animationBarView.frame = CGRect(x: -xOffset, y: 0, width: self.frame.width, height: self.frame.height)
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
