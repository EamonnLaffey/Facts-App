//
//  FactDetailViewController.swift
//  FactsApp
//
//  Created by Eamonn Laffey on 22/5/18.
//  Copyright © 2018 Eamonn Laffey. All rights reserved.
//

import UIKit

class FactDetailViewController: UIViewController {
    let factImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    lazy var landscapeContraints = [
        self.factImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        self.factImageView.topAnchor.constraint(equalTo: view.topAnchor),
        self.view.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
        self.view.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),

        self.descriptionLabel.topAnchor.constraint(equalTo: view.bottomAnchor),
        self.descriptionLabel.leadingAnchor.constraint(equalTo: factImageView.trailingAnchor),
        self.descriptionLabel.topAnchor.constraint(equalTo: view.bottomAnchor),
    ]
    lazy var portraitConstraints = [
        self.factImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        self.factImageView.topAnchor.constraint(equalTo: view.topAnchor),
        self.view.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
        self.view.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
        self.descriptionLabel.topAnchor.constraint(equalTo: factImageView.bottomAnchor),
        self.view.trailingAnchor.constraint(equalTo: factImageView.trailingAnchor),
        self.descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    ]
    var image: UIImage?
    var factTitle: String?
    var factDescription: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(factImageView)
        view.addSubview(descriptionLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_: Bool) {
        descriptionLabel.text = factDescription
        factImageView.image = image
        title = factTitle
        setupLayout()
    }

    func setupLayout() {
        if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeContraints)

        } else {
            NSLayoutConstraint.deactivate(landscapeContraints)
            NSLayoutConstraint.activate(portraitConstraints)
        }
        view.layoutIfNeeded()
    }

    override func viewWillTransition(to _: CGSize, with _: UIViewControllerTransitionCoordinator) {
        setupLayout()
    }
}
