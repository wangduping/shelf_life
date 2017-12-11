

//
//  DBManager.swift
//  shelf_life
//
//  Created by dupi on 2017/12/6.
//  Copyright © 2017年 dupi. All rights reserved.
//

import UIKit


class DBManager: NSObject {
    static let shared: DBManager = DBManager()
    let databaseFileName = "database.sqlite"

    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    override init() {
        super.init()
        
        let documentsDirectory = "/Users/tukeping/Desktop"
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
//   parhToDatabase = /Users/tukeping/Library/Developer/CoreSimulator/Devices/5D2B66E3-A0F1-4CB3-B81A-2909D77870F4/data/Containers/Data/Application/228796E9-F72C-46DE-AA08-623077E2282E/Documents/database.sqlite
     func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            if database != nil {
                // Open the database.
                if database.open(){
                    
                    do{
                        if  let pathToCreateTableFile = Bundle.main.path(forResource:"create_table",ofType:"tsv"){
                            let CreateTableFileContents = try String(contentsOfFile:pathToCreateTableFile)
                            let CreateTableData = CreateTableFileContents.components(separatedBy: "\r\n")
                            var query = ""
//                            var tab = "" //想要做成先获取数据库中有没有该表，若有则跳过，若没有，则对数据库中的表进行插入，注视掉的部分为该雏形， sql正确，程序错误
                            for cretab in CreateTableData{
//                                let tabParts = cretab.components(separatedBy: " ")//将文本按照空格隔开
//                                tab = tabParts[2]//获取到每一行的数据表
                                //判断表是否存在
//                                let results = try database.executeQuery("select count(1) from sqlite_master where type ='table' and name = \(tab)",values:nil)
//                                if (results == 0){//若数据表数量为0 则在最终的插入语句中加入
//                                    query += query
//                                }
                                query += cretab
                            }
                            do{
                                 database.executeStatements(query)
                                created = true
                            }
                            
                        }
                    }
                    catch{
                         print(error.localizedDescription)
                    }
                    // 最后关闭数据库
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
    
    func insertBasicData() {
        database = FMDatabase(path: pathToDatabase)
            
        if (database != nil){
                
            if openDatabase(){
                do{
                    if let pathToBasicBaseFile = Bundle.main.path(forResource: "basic_base", ofType: "tsv"){
                        let BasicBaseFileContents = try String(contentsOfFile:pathToBasicBaseFile)
                        let BasicBaseData = BasicBaseFileContents.components(separatedBy: "\n")//实际上没有生效，需要独立的进行分离
                        var query = ""
                        for bb in BasicBaseData{
                            query += bb
                        }
                        database.executeStatements(query)
                    }
                }
                catch  {
                    print(Error.self)
                }
                database.close()
                
            }
            else {
                print("Could not open the database.")
            }
        }
            
        }

    func insertGoods(god:Goods) ->Bool{
        database = FMDatabase(path: pathToDatabase)
        var result = false
        if (database != nil){
            if openDatabase(){
                do{
                    print(god.name)
                    print(god.number)
                    print(god.create_time)
                    print(god.update_time)
                    print(god.expiration_time)
                    let name :String = god.name
                    let number:int_fast8_t = god.number
                    let type : int_fast8_t = god.type
                    let create_time : String = god.create_time
                    let update_time : String = god.update_time
                    let expiration_time : String = god.expiration_time
                    let query = "insert into tb_goods (id,name,number,type,create_time,update_time,expiration_time) values (null,'\(name)','\(number)','\(type)','\(create_time)','\(update_time)','\(expiration_time)');"
                    if !database.executeStatements(query) {
                        print("Failed to insert initial data into the database.")
                        print(database.lastError(), database.lastErrorMessage())
                    }

                }
                catch {
                    print("insert goods failed")
                    print(error.self)
                    return result
                }
                database.close()
            }
            else {
                print("Could not open the database.")
            }
            result = true
        }
        return result
    }
    
    func findType () {
        var tp :[Types]
        database = FMDatabase(path:pathToDatabase)
        if (database != nil)
        {
            let query = "select id,name from tb_goods_type;"
            do{
                if openDatabase(){
                    let results = try database.executeQuery(query, values: nil)
                    var i = 0
                    while results.next(){
                        tp[i].id = int_fast8_t(results.int(forColumn: "id"));
                        tp[i].name = String(describing: results.string(forColumn: "name"))
                        i += 1
                        print(1)
                        print(String(describing: results.string(forColumn: "name")))
                        print(int_fast8_t(results.int(forColumn: "id")))
                        print(2)
//                         tp = Types(id:results.int(forColumn: id),
//                                       name:results.string(forColumn: uname))
               
                    }
                 
                }
                else{
                    print("can not open database")
                }
            }
            catch  {
                print(Error.self)
            }
        }
        else{
            print("can not find database")
        }
        
    }
    
}




