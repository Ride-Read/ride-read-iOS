//
//  QYAttentionAndMessageView.h
//  骑阅
//
//  Created by chen liang on 2017/4/9.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYBasicViewController.h"
#import "QYUser.h"
typedef NS_ENUM(NSUInteger,QYAttentionAndMessageViewType) {
    
    QYAttentionAndMessageViewNoselect,
    QYAttentionAndMessageViewSelect
};

@interface QYAttentionAndMessageView : UIView
@property (weak, nonatomic) IBOutlet UIButton *attention;
@property (weak, nonatomic) IBOutlet UIButton *message;
@property (nonatomic, weak) NSDictionary *info;
@property (nonatomic, assign) QYAttentionAndMessageViewType type;
@property (nonatomic, weak) id <QYDataRefreshProtocol> dataRefresh;
@property (nonatomic, weak) QYUser *user;

+ (instancetype)loadAttentionAndMessage;
@end
