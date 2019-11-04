//
//  MKTextField.swift
//  TODO
//
//  Created by Максим Хюттюля on 17/07/2019.
//  Copyright © 2019 Максим Хюттюля. All rights reserved.
//

import UIKit

@IBDesignable
class MKTextField : UITextField, UITextFieldDelegate {
    
    private let gradient : CAGradientLayer = CAGradientLayer();
    private let iconImageView : UIImageView = UIImageView();
    private let underLine : CALayer = CALayer();
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            if (cornerRadius < 0){
                cornerRadius = 0;
            }
            setupCorners()
        }
    }
    @IBInspectable var borderWidth : CGFloat = 0.0 {
        didSet{
            if (borderWidth < 0){
                borderWidth = 0.0;
            }
            setupCorners()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.black {
        didSet{
            setupCorners()
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
    
    @IBInspectable var iconLeft : UIImage? = nil {
        didSet{
            setupIcons();
        }
    }
    
    @IBInspectable var iconLeftSize : CGFloat = 10 {
        didSet{
            setupIcons();
        }
    }
    
    @IBInspectable var underlineEnable : Bool = false {
        didSet{
            setupUnderLine();
        }
    }
    
    @IBInspectable var underlineHeight : CGFloat = 0 {
        didSet{
            setupUnderLine();
        }
    }

    
    @IBInspectable var underlineLeftMargin : CGFloat = 0.0 {
        didSet{
            setupUnderLine();
        }
    }
    @IBInspectable var underlineRightMargin : CGFloat = 0.0 {
        didSet{
            setupUnderLine();
        }
    }
    @IBInspectable var underlineBottomMargin : CGFloat = 0.0 {
        didSet{
            setupUnderLine();
        }
    }
    
    @IBInspectable var underlineBasicColor : UIColor = UIColor.clear {
        didSet{
            setupUnderLine();
        }
    }
    
    @IBInspectable var underlineEditingColor : UIColor = UIColor.clear {
        didSet{
            setupUnderLine();
        }
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupTextField();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setupTextField();
    }
    
    private func setupTextField(){
        self.addTarget(self, action: #selector(self.textFieldDidBeginEditing(_:)), for: UIControl.Event.editingDidBegin);
        self.addTarget(self, action: #selector(self.textFieldDidEndEditing(_:)), for: UIControl.Event.editingDidEnd);
        setupBackgroundColor();
        setupCorners();
    }
    
    private func setupBackgroundColor(){
        gradient.removeFromSuperlayer();
        if enableGradient {
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
    
    private func setupCorners(){
        layer.borderWidth = borderWidth;
        layer.cornerRadius = cornerRadius;
        layer.borderColor = borderColor.cgColor;
        
        
        gradient.cornerRadius = self.cornerRadius;
    }
    
    private func setupIcons(){
        if (iconLeft != nil){
            let x = self.bounds.height/2 - iconLeftSize/2;
            let y = self.bounds.height/2 - iconLeftSize/2;
            
            let iconView = UIImageView(frame:
                CGRect(x: x, y: y, width: iconLeftSize, height: iconLeftSize))
            iconView.image = iconLeft
            let iconContainerView: UIView = UIView(frame:
                CGRect(x: x, y: y, width: iconLeftSize+10, height: iconLeftSize))
            iconContainerView.addSubview(iconView)
            leftView = iconContainerView
            leftViewMode = .always
        }
    }
    
    private func setupUnderLine(){
        underLine.removeFromSuperlayer();
        if (underlineEnable){
            underLine.frame = CGRect(x: underlineLeftMargin, y: self.bounds.height - underlineBottomMargin, width: self.bounds.width - underlineRightMargin - underlineLeftMargin, height: underlineHeight)
            underLine.backgroundColor = underlineBasicColor.cgColor;
            self.layer.addSublayer(underLine);
        }
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        underLine.backgroundColor = underlineEditingColor.cgColor;
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        underLine.backgroundColor = underlineBasicColor.cgColor;
    }

}
