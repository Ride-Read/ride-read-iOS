//
//  QYReadMeHeaderView.h
//  骑阅
//
//  Created by chen liang on 2017/3/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYUser.h"
@class QYReadMeHeaderView;
@protocol QYReadMeHeaderViewDelegate <NSObject>

@optional;
- (void)clickIcon:(QYReadMeHeaderView *)headerView;
- (void)clickPersonMap:(QYReadMeHeaderView *)headerView;
- (void)clickMessageButton:(QYReadMeHeaderView *)headerView;
- (void)clickAttentionButton:(QYReadMeHeaderView *)headerView;
- (void)clickFansButton:(QYReadMeHeaderView *)headerView;
@end
@interface QYReadMeHeaderView : UIView
@property (nonatomic, weak) id <QYReadMeHeaderViewDelegate> delegate;
@property (nonatomic, weak) QYUser *user;
@property (nonatomic, strong) UIButton *messageButton;

@end
