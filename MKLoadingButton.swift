//
//  MKLoadingButton.swift
//  TODO
//
//  Created by Максим Хюттюля on 16/07/2019.
//  Copyright © 2019 Максим Хюттюля. All rights reserved.
//

import UIKit
@IBDesignable
class MKLoadingButton: UIButton {
    
    private let gradient : CAGradientLayer = CAGradientLayer();
    private let activityIndicator = UIActivityIndicatorView();
    
    private var activityIndicatorStyle : UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.whiteLarge;
    private var buttonText : String? = "";
    private var buttonImage : UIImage?;
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            if (cornerRadius < 0){
                cornerRadius = 0;
            }
            layer.cornerRadius = cornerRadius;
        }
    }
    @IBInspectable var borderWidth : CGFloat = 0.0 {
        didSet{
            if (borderWidth < 0){
                borderWidth = 0.0;
            }
            layer.borderWidth = borderWidth;
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.black {
        didSet{
            layer.borderColor = borderColor.cgColor;
        }
    }
    
    @IBInspectable var enableGradient : Bool = false {
        didSet {
            setupBackgroundColor();
        }
    }
    
    @IBInspectable var firstColor : UIColor = UIColor.white {
        didSet{
            setupBackgroundColor();
        }
    }
    @IBInspectable var secondColor : UIColor = UIColor.black {
        didSet{
            setupBackgroundColor();
        }
    }
    @IBInspectable var isVerticalGradient : Bool = false {
        didSet{
            setupBackgroundColor();
        }
    }
    
    @IBInspectable var indicatorColor : UIColor = UIColor.orange {
        didSet {
            setupActivityIndicator();
        }
    }
    
    @IBInspectable var largeSizeIndicator : Bool = false {
        didSet {
            if largeSizeIndicator {
                activityIndicatorStyle = UIActivityIndicatorView.Style.whiteLarge;
            }else{
                activityIndicatorStyle = UIActivityIndicatorView.Style.white;
            }
        }
    }
    
    @IBInspectable var isSpinning : Bool = false {
        didSet{
            if isSpinning {
                buttonImage = self.imageView?.image;
                buttonText = self.titleLabel?.text;
                self.setTitle("", for: State.normal);
                self.setImage(UIImage(), for: State.normal);
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false;
                self.addSubview(activityIndicator);
                let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0);
                let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
                self.addConstraint(xCenterConstraint);
                self.addConstraint(yCenterConstraint);
                activityIndicator.startAnimating()
            }
            else {
                self.setTitle(buttonText, for: .normal);
                self.setImage(buttonImage, for: State.normal);
                activityIndicator.stopAnimating();
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setupButton();
    }
    
    private func setupButton(){
        setupBackgroundColor();
        setupActivityIndicator();
        if let imageView = self.imageView {
            self.bringSubviewToFront(imageView);
        }
    }
    
    private func setupBackgroundColor(){
        gradient.removeFromSuperlayer();
        if enableGradient {
            gradient.cornerRadius = self.cornerRadius;
            gradient.frame = bounds;
            gradient.colors = [firstColor.cgColor, secondColor.cgColor];
            if (isVerticalGradient){
                gradient.startPoint = CGPoint(x: 0.5, y: 0)
                gradient.endPoint = CGPoint(x: 0.5, y: 1)
            }else{
                gradient.startPoint = CGPoint(x: 0, y: 0.5)
                gradient.endPoint = CGPoint(x: 1, y: 0.5)
            }
            self.layer.insertSublayer(gradient, at: 0);
        }
        
    }
    
    private func setupActivityIndicator(){
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.color = indicatorColor;
        activityIndicator.style = activityIndicatorStyle;
    }
}
