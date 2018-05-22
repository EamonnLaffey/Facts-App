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
        return imageView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
    }

    override func viewWillTransition(to _: CGSize, with _: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
//            imageView.image?.setSie = CGSize(width: self.view.frame.width / 3, height: self.view.frame.height)
        } else {
        }
    }
}
