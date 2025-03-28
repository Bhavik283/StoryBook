//
//  BetaViewView.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 07/02/24.
//

import UIKit

class BetaViewView: UIView {

    weak var settingsDelegate: BetaSettingsDelegate?

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let kindLabel: UILabel = {
        let label = UILabel()
        label.text = "Kind: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Selector for button size
    private let kindSelector: UISegmentedControl = {
        let kinds = ["normal", "background"]
        let selector = UISegmentedControl(items: kinds)
        selector.selectedSegmentIndex = 0
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.addTarget(self, action: #selector(kindValueChange), for: .valueChanged)
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
        textField.text = "Value"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return textField
    }()
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "State: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Selector for button size
    private let stateSelector: UISegmentedControl = {
        let kinds = ["normal", "disabled"]
        let selector = UISegmentedControl(items: kinds)
        selector.selectedSegmentIndex = 0
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.addTarget(self, action: #selector(stateValueChange), for: .valueChanged)
        return selector
    }()
    
    private let orientLabel: UILabel = {
        let label = UILabel()
        label.text = "Orientation: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Selector for button size
    private let orientSelector: UISegmentedControl = {
        let kinds = ["horizontal", "vertical"]
        let selector = UISegmentedControl(items: kinds)
        selector.selectedSegmentIndex = 0
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.addTarget(self, action: #selector(orientValueChange), for: .valueChanged)
        return selector
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Orientation: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Selector for button size
    private let sizeSelector: UISegmentedControl = {
        let kinds = ["small", "medium", "large"]
        let selector = UISegmentedControl(items: kinds)
        selector.selectedSegmentIndex = 1
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.addTarget(self, action: #selector(sizeValueChange), for: .valueChanged)
        return selector
    }()
    
    private let iconLabel: UILabel = {
        let label = UILabel()
        label.text = "Show Icon: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Toggle button for disable state
    private let IconToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.addTarget(self, action: #selector(toggleValueChanged), for: .valueChanged)
        return toggle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemMint
        setupStackView()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension BetaViewView{
    
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
        let stateStack = createHorizontalStack(label: stateLabel, component: stateSelector)
        let kindStack = createHorizontalStack(label: kindLabel, component: kindSelector)
        let orientStack = createHorizontalStack(label: orientLabel, component: orientSelector)
        let sizeStack = createHorizontalStack(label: sizeLabel, component: sizeSelector)
        let textStack = createHorizontalStack(label: textLabel, component: titleTextField)
        let iconStack = createHorizontalStack(label: iconLabel, component: IconToggle)
        
        stackView.addArrangedSubview(stateStack)
        stackView.addArrangedSubview(kindStack)
        stackView.addArrangedSubview(orientStack)
        stackView.addArrangedSubview(sizeStack)
        stackView.addArrangedSubview(textStack)
        stackView.addArrangedSubview(iconStack)
        
        addSubview(stackView)
    }
}

extension BetaViewView{
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
}

extension BetaViewView{
    @objc private func kindValueChange(){
        let selectedKind = kindSelector.titleForSegment(at: kindSelector.selectedSegmentIndex) ?? "normal"
        settingsDelegate?.didApplyKind(kind: selectedKind)
    }
    @objc private func textFieldEditingChanged(){
        let buttonTitle = titleTextField.text ?? "Badge"
        settingsDelegate?.didChangeText(title: buttonTitle)
    }
    @objc private func stateValueChange(){
        let selectedState = stateSelector.titleForSegment(at: stateSelector.selectedSegmentIndex) ?? "normal"
        settingsDelegate?.didChangeState(state: selectedState)
    }
    @objc private func orientValueChange(){
        let selectedOrient = orientSelector.titleForSegment(at: orientSelector.selectedSegmentIndex) ?? "horizontal"
        settingsDelegate?.didChangeOrientation(orient: selectedOrient)
    }
    @objc private func sizeValueChange(){
        let selectedSize = sizeSelector.titleForSegment(at: sizeSelector.selectedSegmentIndex) ?? "medium"
        settingsDelegate?.didApplySize(size: selectedSize)
    }
    @objc private func toggleValueChanged(){
        let isIcon = IconToggle.isOn
        settingsDelegate?.didShowImage(image: isIcon)
    }
}
