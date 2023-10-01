//
//  UITableView.swift
//  Volleyer
//
//  Created by 李童 on 2023/10/1.
//

import Foundation
import UIKit
import MJRefresh

extension UITableView {

    func addRefreshHeader(refreshingBlock: @escaping () -> Void) {
        mj_header = MJRefreshNormalHeader(refreshingBlock: refreshingBlock)
    }

    func endHeaderRefreshing() {
        mj_header?.endRefreshing()
    }

    func beginHeaderRefreshing() {
        mj_header?.beginRefreshing()
    }

    func addRefreshFooter(refreshingBlock: @escaping () -> Void) {
        mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: refreshingBlock)
    }

    func endFooterRefreshing() {
        mj_footer?.endRefreshing()
    }

    func endWithNoMoreData() {
        mj_footer?.endRefreshingWithNoMoreData()
    }

    func resetNoMoreData() {
        mj_footer?.resetNoMoreData()
    }
}
