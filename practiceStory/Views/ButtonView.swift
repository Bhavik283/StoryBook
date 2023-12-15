//
//  ButtonView.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 13/12/23.
//



import UIKit


class ButtonView: UIView {

    weak var settingsDelegate: ButtonSettingsDelegate?
    
    let images = ["play.circle", "none", "house", "person", "magnifyingglass", "play.rectangle"]
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageLabel: UILabel = {
        let label = UILabel()
        label.text = "Image: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        let kinds = ["primary", "secondary", "tertiary"]
        let selector = UISegmentedControl(items: kinds)
        selector.selectedSegmentIndex = 0
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.addTarget(self, action: #selector(kindValueChange), for: .valueChanged)
        return selector
    }()
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "State: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Selector for button size
    private let stateSelector: UISegmentedControl = {
        let states = ["normal", "destructive", "positive"]
        let selector = UISegmentedControl(items: states)
        selector.selectedSegmentIndex = 0
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.addTarget(self, action: #selector(stateValueChange), for: .valueChanged)
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

    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Title: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        // Input text field for button title
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Button Title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return textField
    }()
    
    private let radiusLabel: UILabel = {
        let label = UILabel()
        label.text = "Radius: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let cornerRadiusSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.value = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemMint
        imageSelector.values = images
        imageSelector.setText(images[0])
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

extension ButtonView{
    
    
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
        let stateStack = createHorizontalStack(label: stateLabel, component: stateSelector)
        let sizeStack = createHorizontalStack(label: sizeLabel, component: sizeSelector)
        let disableStack = createHorizontalStack(label: disableLabel, component: disableToggle)
        let textStack = createHorizontalStack(label: textLabel, component: titleTextField)
        let radiusStack = createHorizontalStack(label: radiusLabel, component: cornerRadiusSlider)
        
        stackView.addArrangedSubview(kindStack)
        stackView.addArrangedSubview(stateStack)
        stackView.addArrangedSubview(sizeStack)
        stackView.addArrangedSubview(imageStack)
        stackView.addArrangedSubview(textStack)
        stackView.addArrangedSubview(disableStack)
        stackView.addArrangedSubview(radiusStack)
        
        addSubview(stackView)
    }
}

extension ButtonView{
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
}

extension ButtonView{

    @objc private func kindValueChange(){
        let selectedKind = kindSelector.titleForSegment(at: kindSelector.selectedSegmentIndex) ?? "primary"
        settingsDelegate?.didApplyKind(kind: selectedKind)
    }
    @objc private func stateValueChange(){
        let selectedState = stateSelector.titleForSegment(at: stateSelector.selectedSegmentIndex) ?? "normal"
        settingsDelegate?.didApplyState(state: selectedState)
    }
    @objc private func sizeValueChange(){
        let selectedSize = sizeSelector.titleForSegment(at: sizeSelector.selectedSegmentIndex) ?? "medium"
        settingsDelegate?.didApplySize(size: selectedSize)
    }
    @objc private func sliderValueChanged(){
        let cornerRadius = CGFloat(cornerRadiusSlider.value)
        settingsDelegate?.didChangeRadius(cornerRadius: cornerRadius)
    }
    @objc private func textFieldEditingChanged(){
        let buttonTitle = titleTextField.text ?? ""
        settingsDelegate?.didChangeText(title: buttonTitle)
    }
    @objc private func toggleValueChanged(){
        let isDisabled = disableToggle.isOn
        settingsDelegate?.didToggle(isDisabled: isDisabled)
    }
}

extension ButtonView: SelectorDelegate{
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
