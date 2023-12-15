//
//  StoryBadgeViewController.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 14/12/23.
//

import UIKit
import practiceButton

protocol BadgeSettingsDelegate: AnyObject {
    func didApplyImage(image: String)
    func didApplyKind(kind: String)
    func didApplySize(size: String)
    func didChangeText(title: String)
}

class StoryBadgeViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var storyControlView: BadgeView = {
        let vc = BadgeView()
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.settingsDelegate = self
        return vc
    }()
    
    private let myBadge: pBadge = {
        let badge = pBadge()
        badge.translatesAutoresizingMaskIntoConstraints = false
        return badge
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Story - Badge"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(myBadge)
        scrollView.addSubview(storyControlView)
        applyConstraints()
    }

}

extension StoryBadgeViewController: BadgeSettingsDelegate{
    func didApplyImage(image: String) {
        myBadge.pBadgeImage = image
    }
    
    func didApplyKind(kind: String) {
        switch kind{
        case "normal":
            myBadge.pKind = .normal
        case "service":
            myBadge.pKind = .service
        default:
            myBadge.pKind = .normal
        }
    }
    
    func didApplySize(size: String) {
        switch size{
        case "zero":
            myBadge.pSize = .zero
        case "small":
            myBadge.pSize = .small
        case "medium":
            myBadge.pSize = .medium
        case "large":
            myBadge.pSize = .large
        default:
            myBadge.pSize = .medium
        }
    }
    
    func didChangeText(title: String) {
        myBadge.ptext = title
    }
}

extension StoryBadgeViewController{
    private func applyConstraints(){
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ]
        let badgeConstraints = [
            myBadge.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -310),
            myBadge.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]

        let viewConstraints = [
            storyControlView.heightAnchor.constraint(equalToConstant: 250),
            storyControlView.topAnchor.constraint(equalTo:  scrollView.topAnchor, constant: 200),
            storyControlView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            storyControlView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]

        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(badgeConstraints)
        NSLayoutConstraint.activate(viewConstraints)
    }
}
