//
//  MTBaseRefresh.h
//  MeiTuan
//
//  Created by lk06 on 2017/9/2.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "MJRefresh.h"

@interface MTBaseRefresh : MJRefreshGifHeader
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
@end
