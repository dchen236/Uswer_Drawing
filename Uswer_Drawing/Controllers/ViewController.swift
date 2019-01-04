//
//  ViewController.swift
//  Uswer_Drawing
//
//  Created by Danni on 1/4/19.
//  Copyright © 2019 Danni Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
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
    
    let drawAbleView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var thicknessPicker:UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 2
        slider.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        slider.thumbTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        // TODO:  add target to handle sliding adjusting the borderwidth of drawing to corresponding value
    
        return slider
    }()
    
    fileprivate func configureDrableView() {
        view.addSubview(drawAbleView)

        [drawAbleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         drawAbleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         drawAbleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         drawAbleView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.65)].forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
    fileprivate func configureThicknessPicker() {
        
        let pickerStackView = UIStackView(arrangedSubviews: [thinLabel,thicknessPicker,thickLabel])
        pickerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerStackView)
        [pickerStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         pickerStackView.topAnchor.constraint(lessThanOrEqualTo: drawAbleView.bottomAnchor, constant: 15),
         pickerStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
         pickerStackView.heightAnchor.constraint(equalToConstant: 30)].forEach { (constraint) in
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDrableView()
        configureThicknessPicker()
        
    }


}

