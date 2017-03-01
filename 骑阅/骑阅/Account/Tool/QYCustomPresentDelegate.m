//
//  QYCustomPresentDelegate.m
//  骑阅
//
//  Created by 亮 on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCustomPresentDelegate.h"
#import "QYCustomPresentAnimationDelegate.h"

@implementation QYCustomPresentDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    QYCustomPresentAnimationDelegate *animation = [QYCustomPresentAnimationDelegate customPresentAnimationWithType:QYLogTransitionTypePresent];
    return animation;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    QYCustomPresentAnimationDelegate *animation = [QYCustomPresentAnimationDelegate customPresentAnimationWithType:QYLogTransitionTypeDismiss];
    return animation;
}

-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    return nil;
}
@end
