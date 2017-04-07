//
//  QYSendCommentView.h
//  骑阅
//
//  Created by chen liang on 2017/3/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYSendCommentView;
@protocol QYSendCommentViewDelegate <NSObject>

@required;

- (void)sendView:(QYSendCommentView *)view acitonSuccess:(NSMutableDictionary *)info;
@optional;
- (void)sendView:(QYSendCommentView *)view button:(UIButton *)sender;

- (void)sendView:(QYSendCommentView *)view text:(NSString *)text;

@end

@interface QYSendCommentView : UIView
@property (nonatomic, weak) NSMutableDictionary *status;//该阅圈的用户信息
@property (nonatomic, weak) NSDictionary *info;//点击用户的信息
@property (nonatomic, weak) id <QYSendCommentViewDelegate> delegate;

@end
