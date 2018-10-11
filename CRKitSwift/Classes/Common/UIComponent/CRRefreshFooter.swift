//
//  CRRefreshFooter.swift
//  CRKitSwift
//
//  Created by roger wu on 2018/10/9.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

import Foundation
import MJRefresh

class CRRefreshFooter: MJRefreshBackNormalFooter {
    
    public static func footerWithRefreshingBlock(refreshingBlock: @escaping MJRefresh.MJRefreshComponentRefreshingBlock) -> CRRefreshFooter {
        let footer = CRRefreshFooter(refreshingBlock: refreshingBlock)!
        return footer
    }
}
