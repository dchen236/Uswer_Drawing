//
//  ViewController.swift
//  Uswer_Drawing
//
//  Created by Danni on 1/4/19.
//  Copyright © 2019 Danni Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let colorPalette:UIStackView = {
       
        
        
        let blue = UIButton().createButtonWithColor(color: .blue)
        let red = UIButton().createButtonWithColor(color: .red)
        let yellow = UIButton().createButtonWithColor(color: .yellow)
        let black = UIButton().createButtonWithColor(color: .black)
        [blue,red,yellow,black].forEach({ (button) in
            button.addTarget(self,action: #selector(pickColor(sender:)), for: .touchUpInside)
        })
        
        let colorPallete = UIStackView(arrangedSubviews: [red,yellow,black,blue])
        colorPallete.distribution = .fillEqually
        colorPallete.spacing = 5
        colorPallete.translatesAutoresizingMaskIntoConstraints = false
        return colorPallete
    }()
    
    @objc fileprivate func pickColor(sender:UIButton){
        guard let buttonColor = sender.backgroundColor?.cgColor else{ return }
        drawingView.pickedColor = buttonColor
    }
    let thinLabel:UILabel = {
        let label = UILabel()
        label.text = "thin"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = .clear
        return label
    }()
    
    let thickLabel: UILabel = {
        let label = UILabel()
        label.text = "thick"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = .clear
        return label
    }()
    
    let setClearButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.addTarget(self,action: #selector(clearDrawingView), for: .touchUpInside)
        return button
    }()
    @objc fileprivate func clearDrawingView(){
        drawingView.curves = [curve]()
        drawingView.setNeedsDisplay()
    }
    
    let undrawButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("undraw", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.addTarget(self, action: #selector(undraw), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func undraw(){
        drawingView.curves.popLast()
        drawingView.setNeedsDisplay()
    }

    let drawingView:drawableView = {
        let view = drawableView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    @objc fileprivate func handleThickNess(slider:UISlider,event:UIEvent){
        print(slider.value)
        drawingView.pickedWidth = CGFloat(slider.value)
    }
    
    lazy var thicknessPicker:UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isContinuous = true
        slider.minimumValue = 5
        slider.maximumValue = 15
        slider.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        slider.thumbTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        // TODO:  add target to handle sliding adjusting the borderwidth of drawing to corresponding value
        slider.addTarget(self, action: #selector(handleThickNess), for: .touchUpInside)
        return slider
    }()
    
    fileprivate func configureDrableView() {
        view.addSubview(drawingView)
    
        [drawingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         drawingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         drawingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         drawingView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75)].forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
    fileprivate func configureThicknessPicker() {
        
        let pickerStackView = UIStackView(arrangedSubviews: [thinLabel,thicknessPicker,thickLabel])
        pickerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerStackView)
        [pickerStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         pickerStackView.topAnchor.constraint(lessThanOrEqualTo: drawingView.bottomAnchor, constant: 10),
         pickerStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
         pickerStackView.heightAnchor.constraint(equalToConstant: 20)].forEach { (constraint) in
            constraint.isActive = true
        }
        
        pickerStackView.alignment = .center
        pickerStackView.distribution = .fillProportionally
        pickerStackView.spacing = 5
        pickerStackView.arrangedSubviews[0].widthAnchor.constraint(equalTo: pickerStackView.widthAnchor, multiplier: 0.15).isActive = true
        pickerStackView.arrangedSubviews[1].widthAnchor.constraint(equalTo: pickerStackView.widthAnchor, multiplier: 0.6).isActive = true
        pickerStackView.arrangedSubviews[2].heightAnchor.constraint(equalTo: pickerStackView.widthAnchor, multiplier: 0.25).isActive = true
        pickerStackView.axis = .horizontal
        
        
    }
    
    fileprivate func configureColorPalette() {
        view.addSubview(colorPalette)
        
        colorPalette.topAnchor.constraint(equalTo: thicknessPicker.bottomAnchor, constant: 10).isActive = true
        colorPalette.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        colorPalette.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        colorPalette.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    fileprivate func configureFunctionalButton() {
        let functionalButtonStack = UIStackView(arrangedSubviews: [undrawButton,setClearButton])
        functionalButtonStack.translatesAutoresizingMaskIntoConstraints = false
        functionalButtonStack.distribution = .fillEqually
        functionalButtonStack.axis = .vertical
        functionalButtonStack.spacing = 5
        
        view.addSubview(functionalButtonStack)
        functionalButtonStack.topAnchor.constraint(equalTo: colorPalette.topAnchor,constant:30).isActive = true
        functionalButtonStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        functionalButtonStack.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        functionalButtonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:-10).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDrableView()
        configureThicknessPicker()
        configureColorPalette()
        configureFunctionalButton()
        
        
    }


}

struct curve {
    var color:CGColor = UIColor.black.cgColor //default color
    var points = [CGPoint]()
    var width:CGFloat = 5 //default width
}

class drawableView:UIView{
    var curves = [curve]()
    var pickedColor = UIColor.black.cgColor
    var pickedWidth:CGFloat = 5
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else{ return }
        context.setLineCap(CGLineCap.butt)
        for curve in curves{
            let color = curve.color
            let points = curve.points
            let width = curve.width
            for point in points{
                if point == points.first{
                    context.move(to: point)
                }
                else{
                    context.addLine(to: point)
                }
            }
            context.setLineWidth(CGFloat(width))
            context.setStrokeColor(color)
            context.strokePath()
        }
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var newCurve = curve()
        newCurve.color = pickedColor
        newCurve.width = pickedWidth
        curves.append(newCurve)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{ return }
        
        guard var last = curves.popLast() else { return }
        last.points.append(touch.location(in:self))
        curves.append(last)
        setNeedsDisplay()
    }
}

extension UIButton{
    func createButtonWithColor(color:UIColor)->UIButton{
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = color
        button.showsTouchWhenHighlighted = true
        return button
    }
    
    
}
