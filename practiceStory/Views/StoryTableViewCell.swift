//
//  StoryTableViewCell.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 14/12/23.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    static let identifier = "StoryTableViewCell"
    
    private let storyTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(storyTextLabel)
        applyConstraints()
    }

    required init?(coder: NSCoder){
        fatalError()
    }
    
    public func configure(with label: String){
        storyTextLabel.text = label
        contentView.backgroundColor = .systemTeal
        storyTextLabel.textColor = .white
        storyTextLabel.font = UIFont(name: "Arial", size: 20)
    }
    
    private func applyConstraints() {
        let labelConstraints = [
            storyTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            storyTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(labelConstraints)
    }
    
}
