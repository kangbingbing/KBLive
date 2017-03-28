//
//  liveModel.h
//  KBLive
//
//  Created by kangbing on 17/3/8.
//  Copyright © 2017年 kangbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonModel;

@interface LiveModel : NSObject

/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 直播地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 在线人数 */
@property (nonatomic, copy) NSString *online_users;

@property (nonatomic, strong) PersonModel *creator;

@end

@interface PersonModel : NSObject

/** 昵称 */
@property (nonatomic, copy) NSString *nick;
/** 头像 */
@property (nonatomic, copy) NSString *portrait;

@end
