//
//  SelectSliderView.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 15/12/23.
//

import UIKit

protocol SelectorDelegate: AnyObject{
    func changeValue(label: String)
}

class SelectSliderView: UIView {
    
    
    weak var selectDelegate: SelectorDelegate?
    public var values: [String]!
    private var index = 0
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftButton.addTarget(self, action: #selector(leftTap), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightTap), for: .touchUpInside)
        backgroundColor = .white
        addSubview(leftButton)
        addSubview(centerLabel)
        addSubview(rightButton)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 15
    }
    
    public func setText(_ text: String){
        centerLabel.text = text
    }
    
}

extension SelectSliderView{
    @objc private func leftTap(){
        if(index == 0){
            index = values.count-1
        }else{
            index -= 1
        }
        centerLabel.text = values[index]
        selectDelegate?.changeValue(label: values[index])
    }
    
    @objc private func rightTap(){
        if(index == values.count-1){
            index = 0
        }else{
            index += 1
        }
        centerLabel.text = values[index]
        selectDelegate?.changeValue(label: values[index])
    }
    
    private func applyConstraints(){
        let leftConstraints = [
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftButton.topAnchor.constraint(equalTo: topAnchor),
            leftButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            leftButton.heightAnchor.constraint(equalTo: heightAnchor)
        ]
        let rightConstraints = [
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightButton.topAnchor.constraint(equalTo: topAnchor),
            rightButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            rightButton.heightAnchor.constraint(equalTo: heightAnchor)
        ]
        let labelConstraints = [
            centerLabel.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor),
            centerLabel.topAnchor.constraint(equalTo: topAnchor),
            centerLabel.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor),
            centerLabel.heightAnchor.constraint(equalTo: heightAnchor)
        ]
        NSLayoutConstraint.activate(leftConstraints)
        NSLayoutConstraint.activate(rightConstraints)
        NSLayoutConstraint.activate(labelConstraints)
    }
}
