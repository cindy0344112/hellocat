//
//  ViewController.swift
//  hellocat
//
//  Created by 邱珮瑜 on 2024/3/27.
//

import UIKit

class ViewController: UIViewController {
    
    // 貓咪顏色
    var catColorAry: [String] = []
    
    // 貓咪的資料，以貓的顏色作為key值，貓的名字為字串陣列
    var catData: [String: [String]] = [
        "黑貓": ["花生豬腳", "杏安", "花蜜"],
        "黑白": ["吃飯", "生乳捲", "飛高高"],
        "肥橘": ["啾啾", "豆皮", "鳳梨汁"],
        "花花": ["九妹", "妮妮", "招財"],
        "虎斑": ["看不見", "肯德基", "芭樂梅"],
    ]
    
    var currentColorIndex: Int = 0 // 目前選擇的貓咪顏色
    var currentCatIndex: Int = 0   // 目前選擇的貓咪

    @IBOutlet weak var catImage: UIImageView!  // 顯示貓咪大頭照
    @IBOutlet weak var catName: UILabel!    // 顯示貓咪名字
    @IBOutlet weak var catColorSegment: UISegmentedControl!  // 顯示貓咪顏色的segment控制器
    @IBOutlet weak var catPageControl: UIPageControl!  // 顯示貓咪的分頁控制
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        renderCatColorSegment() // 從catData中整理出貓咪花色，並且render出segment的選項
    }
    
    func renderCatColorSegment() {
        catColorAry = Array(catData.keys) // 從catData中取得所有貓的顏色
        catColorSegment.removeAllSegments() // 先移除分段控制器中的所有選項，沒寫這句會有預設的
        
        //用迴圈一個個將花色insert到segment中
        for catColor in catColorAry {
            catColorSegment.insertSegment(withTitle: catColor, at: catColorSegment.numberOfSegments, animated: false)
        }
        catColorSegment.selectedSegmentIndex = 0 // 預設選第一個segment（花色）
        
        //預設顯示第一個segment的第一隻貓咪
        updateCatInfo()
    }
    
    func updateCatInfo() {
        if let getTargetCatAry = catData[catColorAry[currentColorIndex]] { //取得該花色的貓咪名字array
            catImage.image = UIImage(named: getTargetCatAry[currentCatIndex])
            catName.text = getTargetCatAry[currentCatIndex]
            catPageControl.currentPage = currentCatIndex
        }
    }

    //前一隻貓
    @IBAction func prePage(_ sender: Any) {
        if let getTargetCatAry = catData[catColorAry[currentColorIndex]] { // 取得該花色的貓咪名字array
            currentCatIndex = (currentCatIndex + getTargetCatAry.count - 1) % getTargetCatAry.count  // 前一個貓index
            updateCatInfo() // 用新的index來update新的貓咪畫面
        }
    }
    
    //後一隻貓
    @IBAction func nextPage(_ sender: Any) {
        if let getTargetCatAry = catData[catColorAry[currentColorIndex]] { // 取得該花色的貓咪名字array
            currentCatIndex = (currentCatIndex + 1) % getTargetCatAry.count  // 後一個貓index
            updateCatInfo() // 用新的index來update新的貓咪畫面
        }
    }
    
    // 切換貓咪花色
    @IBAction func colorSegmentChange(_ sender: Any) {
        currentColorIndex = catColorSegment.selectedSegmentIndex // 更新選擇的貓顏色索引
        currentCatIndex = 0  //切換segment時，貓咪的圖片index歸零
        updateCatInfo() // 用新的index來update新的貓咪畫面
    }
    
}

