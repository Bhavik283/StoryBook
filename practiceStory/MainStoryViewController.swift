//
//  MainStoryViewController.swift
//  practiceStory
//
//  Created by Bhavik Goyal on 14/12/23.
//

import UIKit

class MainStoryViewController: UIViewController {

    let titles: [String] = ["Avatar", "Badge", "Button"]
    let controllers: [UIViewController] = [StoryAvatarViewController(), StoryBadgeViewController(), StoryButtonViewController()]
    
    private let storyTable: UITableView = {
        let table = UITableView()
        table.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Stories"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(storyTable)
        storyTable.delegate = self
        storyTable.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        storyTable.frame = view.bounds
    }
}

extension MainStoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.identifier, for: indexPath) as? StoryTableViewCell else {return UITableViewCell()}
        let label = titles[indexPath.row]
        cell.configure(with: label)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = controllers[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
