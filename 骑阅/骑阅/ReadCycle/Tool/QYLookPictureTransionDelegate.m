//
//  QYLookPictureTransionDelegate.m
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLookPictureTransionDelegate.h"
#import "QYLookPictureTransitoonAnimation.h"

@implementation QYLookPictureTransionDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    

    QYLookPictureTransitoonAnimation *animation = [QYLookPictureTransitoonAnimation picuteAnimationType:QYlookPictureAnimationTypePresnet from:self.from to:self.to];
    return animation;;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    QYLookPictureTransitoonAnimation *animation = [QYLookPictureTransitoonAnimation picuteAnimationType:QYlookPictureAnimationTypeDismiss from:self.from to:self.to];
    return animation;;
}
@end
