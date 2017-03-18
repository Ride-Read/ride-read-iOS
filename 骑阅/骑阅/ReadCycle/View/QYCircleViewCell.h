//
//  QYCircleViewCell.h
//  骑阅
//
//  Created by chen liang on 2017/3/2.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "YYBaiscTableViewCell.h"
#import "YYLabel.h"
#import "QYFriendCycleCellLayout.h"

typedef NS_ENUM(NSUInteger,QYFriendCycleType) {
    
    QYFriendCycleTypelist,
    QYFriendCycleTypedetail
};
@class QYCircleViewCell;

@protocol QYFriendCycleDelegate <NSObject>

- (void)clickPraiseButton:(QYCircleViewCell *)cell dict:(NSDictionary *)dict;
- (void)clickCommpentButton:(QYCircleViewCell *)cell dict:(NSDictionary *)dict;
- (void)clickPictureView:(QYCircleViewCell *)cell imageView:(UIImageView *)imageView;

@end
@interface QYCircleViewPeople : UIView
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, strong) YYLabel *timeLabel;
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
@property (nonatomic, strong) YYLabel *site;
@property (nonatomic, strong) YYLabel *siteLength;
@property (nonatomic, strong) YYLabel *praiseNumber;
@property (nonatomic, strong) YYLabel *commentNumber;
@property (nonatomic, strong) UIButton *praiseButton;
@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, weak) QYCircleViewCell *cell;

@end

@interface QYCircleViewCellContent : UIView
@property (nonatomic, strong) QYCircleViewPeople *profileView;
@property (nonatomic, strong) QYCircleViewContent *contentView;
@property (nonatomic, strong) QYCircleViewImageView *pictureView;
@property (nonatomic, strong) QYCircleViewBottomView *toolView;
@property (nonatomic, weak) QYCircleViewCell *cell;

@end
@interface QYCircleViewCellPraiseView : UIView
@property (nonatomic, strong) UIButton *praiseButton;
@property (nonatomic, strong) UIButton *praiseNumber;
@property (nonatomic, weak) QYCircleViewCell *cell;

@end

@interface QYCircleViewCellContentDetail : UIView
@property (nonatomic, strong) QYCircleViewPeople *profileView;
@property (nonatomic, strong) QYCircleViewContent *contentView;
@property (nonatomic, strong) QYCircleViewImageView *pictureView;
@property (nonatomic, strong) QYCircleViewCellPraiseView *praiseView;
@property (nonatomic, weak) QYCircleViewCell *cell;

@end
@interface QYCircleViewCell : YYBaiscTableViewCell
@property (nonatomic, strong) QYCircleViewCellContent *statuView;
@property (nonatomic, strong) QYCircleViewCellContentDetail *detailView;
@property (nonatomic, weak) QYFriendCycleCellLayout *layout;
@property (nonatomic, assign) QYFriendCycleType type;
@property (nonatomic, weak) id <QYFriendCycleDelegate> delegate;
- (instancetype)initWithCycleType:(QYFriendCycleType)type;

@end
