//
//  DetailViewController.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 28.01.24.
//

import UIKit
import Combine
import Kingfisher

class DetailViewController: UITableViewController {
    private var cancellables: Set<AnyCancellable> = []
    private var presenter: DetailPresenter?
    func bind(presenter: DetailPresenter) {
        self.presenter = presenter
        presenter.$contents
            .sink { [weak self] contents in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter else {
            assertionFailure("DEV: please check presenter binding")
            return
        }
        navigationItem.title = presenter.workout.name
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.contents.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else {
            return 0
        }
        let content = presenter.contents[section]
        switch content {
        case .description: return 1
        case .images(let images): return images.count
        case .variants(let workouts): return workouts.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter else {
            return UITableViewCell()
        }
        let content = presenter.contents[indexPath.section]
        switch content {
        case .description(let description):
            let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier, for: indexPath) as! TextCell
            cell.descriptionLabel.attributedText = NSAttributedString(description)
            return cell
        case .images(let images):
            let imageUrlString = images[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
            cell.pictureView.kf.setImage(with: URL(string: imageUrlString), placeholder: UIImage(systemName: "dumbbell"))
            return cell
        case .variants(let variants):
            let variant = variants[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
            cell.textLabel?.text = variant.name
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let presenter else {
            return nil
        }
        let content = presenter.contents[section]
        return content.title
    }

}


final class TextCell: UITableViewCell {
    @IBOutlet var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        descriptionLabel.text = nil
    }
}

final class ImageCell: UITableViewCell {
    @IBOutlet var pictureView: UIImageView!
    
    override func prepareForReuse() {
        pictureView.image = nil
    }
}
