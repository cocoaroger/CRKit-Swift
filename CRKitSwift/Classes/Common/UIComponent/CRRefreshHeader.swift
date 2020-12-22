//
//  CRRefreshHeader.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import MJRefresh

class CRRefreshHeader: MJRefreshNormalHeader {
    
    
    public static func headerWithRefreshingBlock(refreshingBlock: @escaping MJRefresh.MJRefreshComponentAction) -> CRRefreshHeader {
        let header = CRRefreshHeader(refreshingBlock: refreshingBlock)
        header.lastUpdatedTimeLabel?.isHidden = true
        header.stateLabel?.isHidden = true
        return header
    }
}
