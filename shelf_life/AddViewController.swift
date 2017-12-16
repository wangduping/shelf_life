//
//  AddViewController.swift
//  shelf_life
//
//  Created by dupi on 2017/12/7.
//  Copyright © 2017年 dupi. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var time_picker: UIDatePicker!
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    //数据库插入所需要的数据
    @IBOutlet weak var goods: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var goods_type: UITextField!
    
    //类型下拉列表的展示
    @IBOutlet weak var goods_type_table: UITableView!
    @IBOutlet weak var goods_type_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.addTarget(self, action:  #selector(AddViewController.segmentDidchange(_:)),for: .valueChanged)
        //用lable button tableview来实现下拉框
        goods_type_table.isHidden = true
        let tp_array = DBManager.shared.findType()
        print(tp_array[0].id)
        print(tp_array[0].name)
        
    }
    
    @IBAction func show_type(_ sender: Any) {
        goods_type_table.isHidden = false
                                       
    }
    
    
    
    @objc func segmentDidchange(_ segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
        print(segmented.titleForSegment(at: segmented.selectedSegmentIndex))
        if (segment.selectedSegmentIndex == 0){
            time_picker.isEnabled = true
//            time_picker.isHidden = false
        }
        else{
            time_picker.isEnabled = false
//            time_picker.isHidden = true
            
        }
    }
    
    @IBAction func AddGoods(_ sender: Any) {
        let create_time :Date = Date()
        let update_time :Date = Date()
        let god :Goods = Goods()
        if (segment.selectedSegmentIndex == 0){
            //将名称中的数据获取出来
            let name = String(describing: goods.text).components(separatedBy: "\"")
            god.name = name[1]
            god.number = int_fast8_t(number.text!)!
//            god.type = int_fast8_t(type.text)
            god.create_time = String(describing: create_time)
            god.update_time = String(describing: update_time)
            god.expiration_time = String(describing: time_picker.date)

            //如果数据插入成功，所有的数据清空
//            if (DBManager.shared.insertGoods(god: god)){
//                //如果数据插入成功，所有的数据清空

//            }
        }
        else{
            god.name = String(describing: goods.text)
            god.number = int_fast8_t(number.text!)!
            //            god.type = String(describing: type.text)

            god.name = String(describing: goods.text)
            god.create_time = String(describing: create_time)
            god.update_time = String(describing: update_time)
            god.expiration_time = ""
            if (DBManager.shared.insertGoods(god: god)){
                //如果数据插入成功
                
            }
        }
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
