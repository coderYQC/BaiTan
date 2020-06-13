//
//  BaseTableView1Extension.swift
//  LynxIOS
//
//  Created by yanqunchao on 2019/7/18.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation 
import YQCKit
//import MJRefresh
//dvc
//pvc
//gvc
//ovc

//pdvc
//ppvc
//pgvc
//povc

extension QCTableView {
    
    func refreshControl(onlyFooterRefresh:Bool = false)->QCTableView{
        if onlyFooterRefresh == false {
            self.configureRefreshHeader = {[weak self] in
                self?.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
                    self?.refreshData()
                })
            }
            self.beginHeaderRefreshingConfigure = {[weak self] in
                self?.tableView.mj_header?.beginRefreshing()
            }
        }
        self.configureRefreshFooter = {[weak self] in
            self?.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                self?.loadMore()
            })
        }
        self.endHeaderRefreshingConfigure = {[weak self] in
            self?.tableView.mj_header?.endRefreshing()
        }
        self.beginFooterRefreshingConfigure = {[weak self] in
            self?.tableView.mj_footer?.beginRefreshing()
        }
        self.endFooterRefreshingConfigure = {[weak self] in
            self?.tableView.mj_footer?.endRefreshing()
        }
        self.hideRefreshFooterConfigure = {[weak self] in
            self?.tableView.mj_footer?.isHidden = true
        }
        self.showRefreshFooterConfigure = {[weak self] in
            self?.tableView.mj_footer?.isHidden = false
        }
        self.reloadDataConfigure = {[weak self] in
            self?.tableView.reloadData()
        }
        //处理加载结果
        self.handleRefresh()
        
        return self
    }
    
}
