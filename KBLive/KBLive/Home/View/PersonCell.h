//
//  PersonCell.h
//  KBLive
//
//  Created by kangbing on 17/3/8.
//  Copyright © 2017年 kangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiveModel;

@interface PersonCell : UITableViewCell

@property (nonatomic, strong)UIImageView *iconImage;// 用户头像

@property (nonatomic, strong)UILabel *nameLabel;// 用户姓名

@property (nonatomic, strong)UIButton *address;// 用户地址

@property (nonatomic, strong)UILabel *peopleNumber;// 观看人数

@property (nonatomic, strong)UIImageView * coverImage;// 封面

@property (nonatomic, strong) LiveModel *liveModel;

@end
