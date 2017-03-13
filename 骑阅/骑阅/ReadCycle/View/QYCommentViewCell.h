//
//  QYCommentViewCell.h
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "YYBaiscTableViewCell.h"
#import "YYLabel.h"

@interface QYCommentViewCell : YYBaiscTableViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) YYLabel *nickName;
@property (nonatomic, strong) YYLabel *timeLabel;
@property (nonatomic, strong) YYLabel *comment;

@end
