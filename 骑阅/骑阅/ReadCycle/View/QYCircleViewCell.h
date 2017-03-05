//
//  QYCircleViewCell.h
//  骑阅
//
//  Created by chen liang on 2017/3/2.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "YYBaiscTableViewCell.h"
#import "YYLabel.h"

@class QYCircleViewCell;
@interface QYCircleViewPeople : UIView
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *attention;
@property (nonatomic, weak) QYCircleViewCell *cell;

@end

@interface QYCircleViewContent : UIView
@property (nonatomic, strong) YYLabel *content;
@property (nonatomic, weak) QYCircleViewCell *cell;

@end
@interface QYCircleViewImageView : UIView
@property (nonatomic, weak) QYCircleViewCell *cell;
@end
@interface QYCircleViewBottomView : UIView
@property (nonatomic, strong) UILabel *site;
@property (nonatomic, strong) UILabel *siteLength;
@property (nonatomic, weak) QYCircleViewCell *cell;

@end
@interface QYCircleViewCell : YYBaiscTableViewCell

@end
