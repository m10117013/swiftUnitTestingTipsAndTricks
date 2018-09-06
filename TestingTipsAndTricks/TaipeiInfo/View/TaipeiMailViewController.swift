//
//  TaipeiMailViewController.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/8/31.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit

class TaipeiMailViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    var viewModel : TaipeiMailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = TaipeiMailViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel?.reloadData {
            DispatchQueue.main.async {
                self.tableVIew.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension TaipeiMailViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // 放置cellViewModel
        if let cell =  cell as? TaipeiMailTableViewCell {
            cell.viewModel = self.viewModel?.cellViewModel(at: indexPath.row)
        }
        return cell
    }
}
