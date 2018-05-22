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

class FactsCollectionViewController: UICollectionViewController {
    var facts: Facts?

    func fetchData() {
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        URLSession.shared.dataTask(with: url) { data, _, error in
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
