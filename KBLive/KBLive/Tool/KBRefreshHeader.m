//
//  KBRefreshHeader.m
//  KBLive
//
//  Created by kangbing on 17/4/1.
//  Copyright © 2017年 kangbing. All rights reserved.
//

#import "KBRefreshHeader.h"

@implementation KBRefreshHeader

- (void)prepare{
    
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *nomalImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        if (image) {
            [nomalImages addObject:image];
        }
    }
    [self setImages:nomalImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        if (image) {
            [refreshingImages addObject:image];
        }
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
