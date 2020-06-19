//
//  MTBaseRefresh.m
//  MeiTuan
//
//  Created by lk06 on 2017/9/2.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "MTBaseRefresh.h"
CGFloat const animationDuration = .15;
@implementation MTBaseRefresh

+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    MTBaseRefresh *cmp = [[self alloc] init];
//    cmp.fixedHeight= @100;
    cmp.refreshingBlock = refreshingBlock;
    NSMutableArray *headRefreshStartGif = [NSMutableArray array];
    for (int i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",i]];
        [headRefreshStartGif addObject:image];
    }
    NSMutableArray *headRefreshingGif = [NSMutableArray array];
    for (int i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",i]];
        [headRefreshingGif addObject:image];
    }
    [cmp setImages:headRefreshStartGif forState:MJRefreshStateIdle];
    [cmp setImages:headRefreshingGif duration:animationDuration * 3 forState:MJRefreshStatePulling];
    cmp.stateLabel.hidden = YES;
    cmp.lastUpdatedTimeLabel.hidden = YES;
    return cmp;
}

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MTBaseRefresh *cmp = [[MTBaseRefresh alloc] init];
    cmp.frame=CGRectMake(0, 0, WUNTRACED, 115);
    
//     cmp.fixedHeight= @110;
    [cmp setRefreshingTarget:target refreshingAction:action];
    NSMutableArray *headRefreshStartGif = [NSMutableArray array];
    for (int i = 1; i <= 15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_kangaroo_home_pull_down_loading_%d",i]];
        [headRefreshStartGif addObject:image];
    }
    NSMutableArray *headRefreshingGif = [NSMutableArray array];
    for (int i = 1; i <= 15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_kangaroo_home_pull_down_loading_%d",i]];
        [headRefreshingGif addObject:image];
    }
    [cmp setImages:headRefreshStartGif forState:MJRefreshStateIdle];
    [cmp setImages:headRefreshingGif duration:animationDuration * 3 forState:MJRefreshStatePulling];
    cmp.stateLabel.hidden = YES;
//    cmp.gifView.fixedHeight= @40;
//    cmp.backgroundColor=[UIColor greenColor];
//    cmp.gifView.sd_layout
//    .centerXEqualToView(cmp)
//    .heightIs(0)
//    .widthIs(0)
//    .bottomSpaceToView(cmp, 20);
    cmp.lastUpdatedTimeLabel.hidden = YES;
    return cmp;
}


@end
