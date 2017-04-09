//
//  QYCommentViewCell.h
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "YYBaiscTableViewCell.h"
#import "YYLabel.h"
#import "QYCommpentCellLayout.h"
#import "QYViewClickProtocol.h"

@class QYCommentViewCell;
@protocol QYCommentViewCellDelegate <NSObject>

@optional;
- (void)commentCell:(QYCommentViewCell *)cell data:(NSDictionary *)data;

@end
@interface QYCommentViewCell : YYBaiscTableViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) YYLabel *nickName;
@property (nonatomic, strong) YYLabel *timeLabel;
@property (nonatomic, strong) YYLabel *comment;
@property (nonatomic, weak) QYCommpentCellLayout *layout;
@property (nonatomic, weak) id <QYCommentViewCellDelegate> delegate;

@end
