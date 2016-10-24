//
//  TipTextField.swift
//  ATTipTextFieldDemo
//
//  Created by Adam on 10/19/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

@IBDesignable @objc open class TipTextField: UITextField {
    
    /// The color of the TipTextField's bottom border. Defaults to white.
    @IBInspectable dynamic open var lineColor: UIColor? = .white {
        didSet {
            updateLine()
        }
    }
    
    /// The width of the TipTextField's bottom border. Defaults to 3px.
    @IBInspectable dynamic open var lineWidth: CGFloat = 3 {
        didSet {
            updateLine()
        }
    }
    
    /// The color of the tip's background. Defaults to white.
    @IBInspectable dynamic open var tipBackgroundColor: UIColor?  = .white {
        didSet {
            updateTipView()
        }
    }
    
    /// The text displayed for the tip.
    @IBInspectable dynamic open var tipText: String? = "" {
        didSet {
            updateTipView()
        }
    }
    
    /// The text color of the tip. Defaults to `UIColor.darkText()`.
    @IBInspectable dynamic open var tipTextColor: UIColor? = .darkText {
        didSet {
            updateTipView()
        }
    }
    
    /// The font of the tip. Defaults to `UIFont.systemFont(ofSize: 14)`.
    open var tipFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            updateTipView()
        }
    }
    
    /// The attributed string for the tip. If nonnil, the tipText property will have no effect.
    open var attributedTipText: NSAttributedString? {
        didSet {
            updateTipView()
        }
    }
    
    /// The corner radii for the bottom left and bottom right corner of the tip view. Defaults to (10.0, 10.0)
    open var tipViewCornerRadii: CGSize = CGSize(width: 20.0, height: 20.0) {
        didSet {
            tipViewMaskPath = UIBezierPath(roundedRect: tipView.bounds, byRoundingCorners: ([.bottomRight, .bottomLeft]), cornerRadii: tipViewCornerRadii)
            layoutIfNeeded()
        }
    }
    
    /// The visibility of the tip view.
    public var tipVisible: Bool  {
        get {
            return tipViewHeightConstraint.constant > 0
        }
    }
    
    private let tipView = UITextView()
    
    private let line = CAShapeLayer()
    
    private let maskLayer: CAShapeLayer = CAShapeLayer()
    
    private var tipViewMaskPath: UIBezierPath = UIBezierPath()
    
    private var tipViewHeightConstraint: NSLayoutConstraint!
    
    private let lineTopMargin: CGFloat = 5.0
    
    // Smelly but it works for now
    private var firstExpansion = true
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override open func draw(_ rect: CGRect) {
        drawLine()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // Set correct bounds for the mask on the first layout pass
        if firstExpansion == true {
            tipViewMaskPath = UIBezierPath(roundedRect: tipView.bounds, byRoundingCorners: ([.bottomRight, .bottomLeft]), cornerRadii: tipViewCornerRadii)
            maskLayer.frame = tipView.bounds
            maskLayer.path = tipViewMaskPath.cgPath
            tipView.layer.mask = maskLayer
        }
    }
    
    // MARK: - Public
    
    /**
     Set the visibility of the tip.
     
     For more control of the animation use `animatedTip(visible: Bool, ...)`
     
     - Parameters:
     - visible: A Boolean value indicating whether the tip should be visible or hidden
     - animated: A Boolean value indicating whether to animate the hiding or showing of the tip
     */
    open func setTip(visible: Bool, animated: Bool) {
        if animated == true {
            animateTip(visible: tipVisible)
        } else {
            let textViewSize = tipVisible == true ? tipView.sizeThatFits(CGSize(width: tipView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height : 0
            tipViewHeightConstraint.constant = textViewSize
            layoutIfNeeded()
        }
    }
    
    /**
     Animate the visibility of the tip.
     
     - Parameters:
     - visible: A boolean flag indicating whether to animate the tip visible or hidden.
     - duration: The duration of the animation. Defaults to 1
     - delay: The delay for the animation. Defaults to 0.
     - dampingRatio: The spring damping ratio of the animation. Defaults to 1.
     - velocity: The initial spring velocity of the animation. Defaults to 1.
     - options: The options for the animation. Defaults to none.
     
     */
    open func animateTip(visible: Bool, duration: TimeInterval = 0.5, delay: TimeInterval = 0, usingSpringWithDamping dampingRatio: CGFloat = 1, initialSpringVelocity velocity: CGFloat = 0, options:
        UIViewAnimationOptions = []) {
        
        updateTipView()
        let textViewSize = visible == true ? tipView.sizeThatFits(CGSize(width: tipView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height : 0
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity, options: options, animations: {
            self.tipViewHeightConstraint.constant = textViewSize
            self.layoutIfNeeded()
            self.firstExpansion = visible == true ? false : self.firstExpansion
        }) { _ in
        }
    }
    
    // MARK: - Interface Builder
    
    open override func prepareForInterfaceBuilder() {
        updateLine()
        updateTipView()
    }
    
    // MARK: - Private
    
    private func updateLine() {
        line.strokeColor = lineColor?.cgColor
        line.lineWidth = lineWidth
        layoutIfNeeded()
    }
    
    private func drawLine() {
        let lineRect = CGRect(origin: CGPoint(x: 0, y: frame.height+lineTopMargin), size: CGSize(width: frame.width, height: lineWidth))
        let linePath = UIBezierPath.init(rect: lineRect)
        line.path = linePath.cgPath
        line.strokeColor = lineColor?.cgColor
        line.lineWidth = lineWidth
        layer.masksToBounds = false
        layer.addSublayer(line)
    }
    
    private func updateTipView() {
        tipView.text = tipText
        
        if let attributedTipText = attributedTipText {
            tipView.text = ""
            tipView.attributedText = attributedTipText
        }
        
        tipView.textColor = tipTextColor
        tipView.font = tipFont
        tipView.backgroundColor = tipBackgroundColor
        layoutIfNeeded()
    }
    
    private func setup() {
        configureTipView()
    }
    
    private func configureTipView() {
        tipView.isEditable = false
        tipView.isScrollEnabled = false
        tipView.textAlignment = .center
        tipView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tipView)
        
        let leading = NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: tipView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: tipView, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: tipView, attribute: .top, multiplier: 1, constant: -(lineWidth + lineTopMargin))
        tipViewHeightConstraint = NSLayoutConstraint.init(item: tipView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        tipViewHeightConstraint.priority = UILayoutPriorityDefaultHigh
        
        addConstraints([leading, trailing, top])
        tipView.addConstraint(tipViewHeightConstraint)
    }
}
