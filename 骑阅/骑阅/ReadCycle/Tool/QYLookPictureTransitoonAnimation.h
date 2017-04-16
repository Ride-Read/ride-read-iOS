//
//  QYLookPictureTransitoonAnimation.h
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,QYlookPictureAnimationType) {
    
    QYlookPictureAnimationTypePresnet,
    QYlookPictureAnimationTypeDismiss
};
@interface QYLookPictureTransitoonAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) QYlookPictureAnimationType type;
@property (nonatomic, assign) CGRect from;
@property (nonatomic, assign) CGRect to;
+ (instancetype)picuteAnimationType:(QYlookPictureAnimationType)type from:(CGRect )from to:(CGRect)to;

@end
