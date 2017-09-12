//
//  KeilaCategoryViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 3/7/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit

class KeilaCategoryViewController: UIViewController {
    
    @IBOutlet var advertisementImageView: UIImageView!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
    }

}

extension KeilaCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        return cell
    }
    
}
