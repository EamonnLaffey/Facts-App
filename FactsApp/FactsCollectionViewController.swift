//
//  ViewController.swift
//  FactsApp
//
//  Created by Eamonn Laffey on 22/5/18.
//  Copyright © 2018 Eamonn Laffey. All rights reserved.
//

import UIKit

struct Facts: Decodable {
    let title: String
    let rows: [Row]
}

struct Row: Decodable {
    let title: String?
    let description: String?
    let imageHref: URL?
}

struct Image {
    var fetched = false
    var image: UIImage?
}

class FactsCollectionViewController: UICollectionViewController {
    var facts: Facts?
    var images = [Int: Image]()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()

    @objc func handleRefresh(_: UIRefreshControl) {
        fetchData()
    }

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if let facts = self.facts {
            return facts.rows.count
        } else {
            return 0
        }
    }

    func downloadImageFrom(url: URL, at indexPath: IndexPath) {
        let index = indexPath.row
        let keyDoesntExists = images[index] == nil
        if keyDoesntExists || images[index]?.fetched == false {
            var image = Image()
            image.fetched = true
            images[index] = image

            URLSession.shared.dataTask(with: url) { data, _, _ in
                DispatchQueue.main.async {
                    if let data = data {
                        self.images[index]?.image = UIImage(data: data)
                        self.collectionView?.reloadItems(at: [indexPath])
                    }
                }
            }.resume()
        }
    }

    override func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: "factCollectionViewCell",
                                                       for: indexPath) as! FactCollectionViewCell
        let index = indexPath.row
        if let row = facts?.rows[index] {
            cell.factTitle.text = row.title
            if let imageHref = row.imageHref {
                downloadImageFrom(url: imageHref, at: indexPath)
                if images[index] != nil {
                    cell.factImage.image = images[index]?.image
                }
            } else {
                cell.factImage.image = nil
            }
        }
        return cell
    }

    func fetchData() {
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        refreshControl.beginRefreshing()
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.refreshControl.endRefreshing()
            }
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            // I convert the data here to a string and back again because
            // JSONDecoder expects it to be encoded utf8 but the endpoint
            // return ascii
            guard let dataString = String(data: data, encoding: .ascii) else {
                return
            }
            guard let dataConverted = dataString.data(using: .utf8) else {
                return
            }
            print("Data ", dataString)
            do {
                self.facts = try JSONDecoder().decode(Facts.self, from: dataConverted)
                print(self.facts!.title)
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            } catch let jsonError {
                print("Json Error", jsonError)
            }
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.addSubview(refreshControl)
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "gotoDetailView" {
            let detailViewController = segue.destination as! FactDetailViewController
            if let index = self.collectionView?.indexPathsForSelectedItems?.first?.item {
                if facts?.rows[index].description != nil {
                    detailViewController.factDescription = facts?.rows[index].description
                }
                detailViewController.image = images[index]?.image
            }
        }
    }
}
