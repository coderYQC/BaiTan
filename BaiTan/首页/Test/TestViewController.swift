//
//  TestViewController.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/20.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
let kToTopY:CGFloat = JHeight + Constants.statusBarHeight - kContentCellHeight
class TestViewController: BaseViewController {

    lazy var myTableView:BaseTableView = {
        let myTableView = BaseTableView(frame: CGRect(x: 0, y:-Constants.statusBarHeight, width: JWidth, height: JHeight + Constants.statusBarHeight),style: .plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = Constants.APP_BACKGROUND_COLOR
        myTableView.separatorStyle = .none
//        myTableView.showsVerticalScrollIndicator = false
      
        return myTableView
    }()
    var vcCanScroll:Bool = true
    var scroll1CanScroll:Bool = false
    var scroll2CanScroll:Bool = false
    lazy var scrollView1:BaseScrollView = {
        let scrollView = BaseScrollView(frame: CGRect(x: 0, y: 0, width: JWidth - 50, height: kContentCellHeight)).backgroundColor(.green)
        scrollView.contentSize = CGSize(width: JWidth, height: kContentCellHeight * 2)
        scrollView.delegate = self
        return scrollView
    }()
    lazy var scrollView2:BaseScrollView = {
        let scrollView = BaseScrollView(frame: CGRect(x: 0, y:100, width: JWidth - 100, height: kContentCellHeight)).backgroundColor(.blue)
        scrollView.contentSize = CGSize(width: JWidth, height: kContentCellHeight * 2)
        scrollView.delegate = self
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        self.view.addSubview(self.myTableView)
        self.scrollView1.addSubview(self.scrollView2)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: 400)).backgroundColor(.red)
        self.myTableView.tableHeaderView = headerView
        self.view.backgroundColor = .randomColor()
    }

}
extension TestViewController:UITableViewDelegate,UITableViewDataSource {
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return kContentCellHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.contentView.addSubview(self.scrollView1)
        }
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.myTableView {
            if scrollView.contentOffset.y > kToTopY {
                scrollView.contentOffset = CGPoint(x: 0, y: kToTopY)
                if self.vcCanScroll {
                    self.vcCanScroll = false
                    self.scroll1CanScroll  = true
                }
            }else{
                if self.vcCanScroll == false {
                    myTableView.contentOffset =  CGPoint(x: 0, y: kToTopY)
                }
            }
             print("tableView---------0-------------IsScrolling")
        }else if scrollView == self.scrollView1 {
            if self.scroll1CanScroll == false{
                scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
            if scrollView.contentOffset.y <= 0 {
                 self.scroll1CanScroll = false
                 scrollView.contentOffset = CGPoint(x: 0, y: 0)
                 self.vcCanScroll = true
            }else if scrollView.contentOffset.y > 100 {
                self.scroll2CanScroll = true
                 scrollView.contentOffset = CGPoint(x: 0, y: 100)
            }
            print("scrollView---------1-------------IsScrolling")
        }else{
            print("scrollView---------2-------------IsScrolling")
            if self.scroll2CanScroll == false{
                scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
            if scrollView.contentOffset.y <= 0 {
                 self.scroll2CanScroll = false
                 scrollView.contentOffset = CGPoint(x: 0, y: 0)
                 self.vcCanScroll = true
            }
        }
    }
}
