//
//  AvatarView.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 14/12/23.
//

import UIKit

class AvatarView: UIView {

    weak var settingsDelegate: AvatarSettingsDelegate?
    let sizes = ["xsmall", "small", "medium", "large", "xLarge", "xxLarge"]
    
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
        let kinds = ["icon", "image", "initials"]
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
    private lazy var sizeSelector: SelectSliderView = {
        let select = SelectSliderView()
        select.translatesAutoresizingMaskIntoConstraints = false
        select.selectDelegate = self
        NSLayoutConstraint.activate([
            select.heightAnchor.constraint(equalToConstant: 30)
        ])
        return select
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
        textField.placeholder = "Enter Name"
        textField.borderStyle = .roundedRect
        textField.text = "Some Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return textField
    }()
    
    private let disableLabel: UILabel = {
        let label = UILabel()
        label.text = "Disable: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Toggle button for disable state
    private let disableToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.addTarget(self, action: #selector(toggleValueChanged), for: .valueChanged)
        return toggle
    }()
    
    private let clickLabel: UILabel = {
        let label = UILabel()
        label.text = "Clickable: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Toggle button for disable state
    private let clickToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.addTarget(self, action: #selector(clickValueChanged), for: .valueChanged)
        return toggle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemMint
        sizeSelector.values = sizes
        sizeSelector.setText(sizes[0])
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

extension AvatarView{
    
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
        
        stackView.addArrangedSubview(createHorizontalStack(label: kindLabel, component: kindSelector))
        stackView.addArrangedSubview(createHorizontalStack(label: sizeLabel, component: sizeSelector))
        stackView.addArrangedSubview(createHorizontalStack(label: textLabel, component: titleTextField))
        stackView.addArrangedSubview(createHorizontalStack(label: disableLabel, component: disableToggle))
        stackView.addArrangedSubview(createHorizontalStack(label: clickLabel, component: clickToggle))
        
        addSubview(stackView)
    }
}

extension AvatarView{
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
}

extension AvatarView{
    @objc private func kindValueChange(){
        let selectedKind = kindSelector.titleForSegment(at: kindSelector.selectedSegmentIndex) ?? "icon"
        let avatarTitle = titleTextField.text ?? "Avatar"
        settingsDelegate?.didApplyKind(kind: selectedKind, label: avatarTitle)
    }
    @objc private func textFieldEditingChanged(){
        let avatarTitle = titleTextField.text ?? "Avatar"
        let selectedKind = kindSelector.titleForSegment(at: kindSelector.selectedSegmentIndex) ?? "initials"
        settingsDelegate?.didChangeText(title: avatarTitle, kind: selectedKind)
    }
    @objc private func toggleValueChanged(){
        let isDisabled = disableToggle.isOn
        settingsDelegate?.didToggle(isDisabled: isDisabled)
    }
    @objc private func clickValueChanged(){
        let isClickable = clickToggle.isOn
        settingsDelegate?.didClick(isClick: isClickable)
    }
}

extension AvatarView: SelectorDelegate{
    func changeValue(label: String) {
        settingsDelegate?.didApplySize(size: label)
    }
}
