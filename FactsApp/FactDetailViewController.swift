//
//  FactDetailViewController.swift
//  FactsApp
//
//  Created by Eamonn Laffey on 22/5/18.
//  Copyright © 2018 Eamonn Laffey. All rights reserved.
//

import UIKit

class FactDetailViewController: UIViewController {
    @IBOutlet var factImage: UIImageView!
    @IBOutlet var factDescription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
