 //
//  TaipeiMailViewController.swift
//  TestingTipsAndTricks
//
//  Created by wei on 2018/8/31.
//  Copyright © 2018年 wei. All rights reserved.
//

import UIKit

class TaipeiInfoViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    var viewModel : TaipeiInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.viewModel = TaipeiInfoViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return
            // Code only executes when tests are running
        }
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

extension TaipeiInfoViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // 放置cellViewModel
        if let cell =  cell as? TaipeiInfoTableViewCell {
            do {
                try cell.viewModel = self.viewModel?.cellViewModel(at: indexPath.row)
            } catch {
                
            }
        }
        return cell
    }
}
