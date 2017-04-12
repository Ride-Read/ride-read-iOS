//
//  QYimageView.h
//  骑阅
//
//  Created by chen liang on 2017/4/11.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYimageView : UIView
@property (nonatomic, weak) QYimageView *next;
@property (nonatomic, weak) QYimageView *last;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIButton *delegateButton;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSUInteger count;


- (void)deleteSelf;
@end
