//
//  BadgeView.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 14/12/23.
//

import UIKit

class BadgeView: UIView {

    weak var settingsDelegate: BadgeSettingsDelegate?
    let images = ["none", "play.circle", "house", "person", "magnifyingglass", "play.rectangle"]
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageLabel: UILabel = {
        let label = UILabel()
        label.text = "Image: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Selector for button size
    private lazy var imageSelector: SelectSliderView = {
        let select = SelectSliderView()
        select.translatesAutoresizingMaskIntoConstraints = false
        select.selectDelegate = self
        NSLayoutConstraint.activate([
            select.heightAnchor.constraint(equalToConstant: 30)
        ])
        return select
    }()
    
    private let kindLabel: UILabel = {
        let label = UILabel()
        label.text = "Kind: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Selector for button size
    private let kindSelector: UISegmentedControl = {
        let kinds = ["normal", "service"]
        let selector = UISegmentedControl(items: kinds)
        selector.selectedSegmentIndex = 0
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.addTarget(self, action: #selector(kindValueChange), for: .valueChanged)
        return selector
    }()

    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Size: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Selector for button size
    private let sizeSelector: UISegmentedControl = {
        let sizes = ["zero", "small", "medium", "large"]
        let selector = UISegmentedControl(items: sizes)
        selector.selectedSegmentIndex = 2
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.addTarget(self, action: #selector(sizeValueChange), for: .valueChanged)
        return selector
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Title: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Input text field for button title
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Badge Title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemMint
        setupStackView()
        imageSelector.values = images
        imageSelector.setText(images[0])
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension BadgeView{
    
    private func createHorizontalStack(label: UILabel, component: UIView) -> UIStackView {
        let horizontalStack = UIStackView(arrangedSubviews: [label, component])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        let widthConstraint1 = label.widthAnchor.constraint(equalTo: horizontalStack.widthAnchor, multiplier: 0.25)
        let widthConstraint2 = component.widthAnchor.constraint(equalTo: horizontalStack.widthAnchor, multiplier: 0.75)

        NSLayoutConstraint.activate([widthConstraint1, widthConstraint2])
        return horizontalStack
    }
    
    private func setupStackView() {
        let imageStack = createHorizontalStack(label: imageLabel, component: imageSelector)
        let kindStack = createHorizontalStack(label: kindLabel, component: kindSelector)
        let sizeStack = createHorizontalStack(label: sizeLabel, component: sizeSelector)
        let textStack = createHorizontalStack(label: textLabel, component: titleTextField)
        
        stackView.addArrangedSubview(imageStack)
        stackView.addArrangedSubview(kindStack)
        stackView.addArrangedSubview(sizeStack)
        stackView.addArrangedSubview(textStack)
        
        addSubview(stackView)
    }
}

extension BadgeView{
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
}

extension BadgeView{
    @objc private func kindValueChange(){
        let selectedKind = kindSelector.titleForSegment(at: kindSelector.selectedSegmentIndex) ?? "normal"
        settingsDelegate?.didApplyKind(kind: selectedKind)
    }
    @objc private func sizeValueChange(){
        let selectedSize = sizeSelector.titleForSegment(at: sizeSelector.selectedSegmentIndex) ?? "medium"
        settingsDelegate?.didApplySize(size: selectedSize)
    }
    @objc private func textFieldEditingChanged(){
        let buttonTitle = titleTextField.text ?? "Badge"
        settingsDelegate?.didChangeText(title: buttonTitle)
    }
}

extension BadgeView: SelectorDelegate{
    func changeValue(label: String) {
        var ans: String
        if(label == "none"){
            ans = ""
        }else{
            ans = label
        }
        settingsDelegate?.didApplyImage(image: ans)
    }
}
