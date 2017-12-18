//
//  Group_listViewController.swift
//  shelf_life
//
//  Created by dupi on 2017/12/13.
//  Copyright © 2017年 dupi. All rights reserved.
//

import UIKit

class Group_listViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let group_list = DBManager.shared.LoadGroups()
    var todos = [String]()
    var allgoods:Dictionary<Int, [String]?> = [:]
    var adHeaders = [String!]()
    var tableView:UITableView?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        total += group_list[se].tp_array.count
//        se += 1
        return group_list[section].tp_array.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return group_list.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            let data = allgoods[section]!
            print (data!.count)
            return "\(adHeaders[section]!)\t共\(data!.count)个物品"
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify:String = "SwiftCell"
        //同一形式的单元格重复使用，在声明时已注册，
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identify, for: indexPath)
        let secno = indexPath.section
        var data = allgoods[secno]
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = data!?[indexPath.row]
        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        self.tableView!.deselectRow(at: indexPath, animated: true)
//        let itemString = self.allgoods[indexPath.section]!![indexPath.row]
//        let alertController = UIAlertController(title: "提示!",
//                                                message: "你选中了【\(itemString)】",
//            preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0
        for group in group_list{
            adHeaders.append("\(group.group_name!)")
            var temp = [String!]()
            for goods in group.tp_array{
                temp.append("\(goods.name!)\t\(goods.number)")
            }
            allgoods[i] = temp
            i += 1
        }
        
        //创建表视图
        let tableView = UITableView(frame:self.view.frame, style:.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        //创建一个重用的单元格
        tableView.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(tableView)
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
