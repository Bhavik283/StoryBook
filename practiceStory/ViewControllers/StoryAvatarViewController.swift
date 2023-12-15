//
//  StoryAvatarViewController.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 14/12/23.
//

import UIKit
import practiceButton

protocol AvatarSettingsDelegate: AnyObject {
    func didApplyKind(kind: String, label: String)
    func didApplySize(size: String)
    func didChangeText(title: String, kind: String)
    func didToggle(isDisabled: Bool)
    func didClick(isClick: Bool)
}


class StoryAvatarViewController: UIViewController {

    private let myImage: UIImage! = UIImage(systemName: "house")
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var storyControlView: AvatarView = {
        let vc = AvatarView()
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.settingsDelegate = self
        return vc
    }()
    
    private let myAvatar: pAvatar = {
        let avatar = pAvatar()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Story - Avatar"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(myAvatar)
        scrollView.addSubview(storyControlView)
        applyConstraints()
        clickAvatar()
    }
    
    private func clickAvatar(){
        myAvatar.clickAction = {pAvatar in
            let alertController = UIAlertController(
                title: "Avatar Clicked",
                message: "You clicked the avatar!",
                preferredStyle: .alert
            )

            alertController.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))

            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension StoryAvatarViewController: AvatarSettingsDelegate{
    
    func didApplyKind(kind: String, label: String) {
        switch kind{
        case "icon":
            myAvatar.pKind = .icon
        case "image":
            myAvatar.pKind = .image(myImage)
        case "initials":
            myAvatar.pKind = .initials(label)
        default:
            myAvatar.pKind = .icon
        }
    }
    
    func didApplySize(size: String) {
        switch size{
        case "xsmall":
            myAvatar.pSize = .xSmall
        case "small":
            myAvatar.pSize = .small
        case "medium":
            myAvatar.pSize = .medium
        case "large":
            myAvatar.pSize = .large
        case "xLarge":
            myAvatar.pSize = .xLarge
        case "xxLarge":
            myAvatar.pSize = .xxLarge
        default:
            myAvatar.pSize = .medium
        }
    }
    
    func didChangeText(title: String, kind: String) {
        if(kind == "initials"){
            myAvatar.pKind = .initials(title)
        }
    }
    
    func didToggle(isDisabled: Bool) {
        myAvatar.setAvatarState(isDisabled)
    }
    
    func didClick(isClick: Bool) {
        myAvatar.isClickable = isClick
    }
}


extension StoryAvatarViewController{
    private func applyConstraints(){
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ]

        let avatarConstraints = [
            myAvatar.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -300),
            myAvatar.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]

        let viewConstraints = [
            storyControlView.heightAnchor.constraint(equalToConstant: 300),
            storyControlView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 250),
            storyControlView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            storyControlView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(avatarConstraints)
        NSLayoutConstraint.activate(viewConstraints)
        NSLayoutConstraint.activate(scrollViewConstraints)
    }
}
