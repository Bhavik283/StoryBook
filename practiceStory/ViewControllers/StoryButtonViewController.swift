//
//  StoryButtonViewController.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 13/12/23.
//

import UIKit
import practiceButton

protocol ButtonSettingsDelegate: AnyObject {
    func didApplyImage(image: String)
    func didApplyKind(kind: String)
    func didApplyState(state: String)
    func didApplySize(size: String)
    func didToggle(isDisabled: Bool)
    func didChangeText(title: String)
    func didChangeRadius(cornerRadius: CGFloat)
}

class StoryButtonViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var storyControlView: ButtonView = {
        let vc = ButtonView()
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.settingsDelegate = self
        return vc
    }()
    
    private let myButton: pButton = {
        let button = pButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Story - Button"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(myButton)
        scrollView.addSubview(storyControlView)
        scrollView.alwaysBounceHorizontal = false
        applyConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

extension StoryButtonViewController: ButtonSettingsDelegate{
    func didApplyImage(image: String) {
        myButton.setImageValue(image)
    }
    
    func didApplyKind(kind: String) {
        var kindValue: pButton.Kind
        switch kind{
        case "primary":
            kindValue = .primary
        case "secondary":
            kindValue = .secondary
        case "tertiary":
            kindValue = .tertiary
        default:
            kindValue = .primary
        }
        myButton.setKindValue(kindValue)
        
    }
    
    func didApplyState(state: String) {
        var stateValue: pButton.State
        switch state{
        case "normal":
            stateValue = .normal
        case "destructive":
            stateValue = .destructive
        case "positive":
            stateValue = .positive
        default:
            stateValue = .normal
        }
        myButton.setStateValue(stateValue)
    }
    
    func didApplySize(size: String) {
        var sizeValue: pButton.Size
        switch size{
        case "zero":
            sizeValue = .zero
        case "small":
            sizeValue = .small
        case "medium":
            sizeValue = .medium
        case "large":
            sizeValue = .large
        default:
            sizeValue = .medium
        }
        myButton.setSizeValue(sizeValue)
    }
    
    func didToggle(isDisabled: Bool) {
        myButton.isEnabled = !isDisabled
    }
    
    func didChangeText(title: String) {
        myButton.setTextValue(title)
    }
    
    func didChangeRadius(cornerRadius: CGFloat) {
        myButton.setRadiusValue(cornerRadius)
    }
}

extension StoryButtonViewController{
    private func applyConstraints(){
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ]

        let buttonConstraints = [
            myButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80),
            myButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]

        let viewConstraints = [
            storyControlView.heightAnchor.constraint(equalToConstant: 400),
            storyControlView.topAnchor.constraint(equalTo: myButton.bottomAnchor, constant: 80),
            storyControlView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            storyControlView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            storyControlView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(viewConstraints)
    }
}
