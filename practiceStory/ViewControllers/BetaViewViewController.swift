//
//  BetaViewViewController.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 07/02/24.
//

import UIKit
import practiceButton

protocol BetaSettingsDelegate: AnyObject {
    func didShowImage(image: Bool)
    func didApplyKind(kind: String)
    func didApplySize(size: String)
    func didChangeText(title: String)
    func didChangeOrientation(orient: String)
    func didChangeState(state: String)
}

class BetaViewViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let myView: MyComponent = {
        let view = MyComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var storyControlView: BetaViewView = {
        let view = BetaViewView()
        view.settingsDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Story - Beta View"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(myView)
        scrollView.addSubview(storyControlView)
        applyConstraints()
    }
}

extension BetaViewViewController: BetaSettingsDelegate {
    func didShowImage(image: Bool) {
        myView.setIcon(image)
    }
    
    func didApplyKind(kind: String) {
        switch kind {
        case "background":
            myView.setKind(.background)
        default:
            myView.setKind(.normal)
        }
    }
    
    func didApplySize(size: String) {
        switch size {
        case "small":
            myView.setSize(.small)
        case "large":
            myView.setSize(.large)
        default:
            myView.setSize(.medium)
        }
        print(myView.layer.cornerRadius)
    }
    
    func didChangeText(title: String) {
        myView.setText(title)
    }
    
    func didChangeOrientation(orient: String) {
        switch orient {
        case "vertical":
            myView.setOrientation(.vertical)
        default:
            myView.setOrientation(.horizontal)
        }
    }
    
    func didChangeState(state: String) {
        switch state {
        case "disabled":
            myView.setState(.disabled)
        default:
            myView.setState(.normal)
        }
    }
    
    private func applyConstraints(){
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ]
        let badgeConstraints = [
            myView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -310),
            myView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]

        let viewConstraints = [
            storyControlView.heightAnchor.constraint(equalToConstant: 380),
            storyControlView.topAnchor.constraint(equalTo:  scrollView.topAnchor, constant: 200),
            storyControlView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            storyControlView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]

        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(badgeConstraints)
        NSLayoutConstraint.activate(viewConstraints)
    }
}

