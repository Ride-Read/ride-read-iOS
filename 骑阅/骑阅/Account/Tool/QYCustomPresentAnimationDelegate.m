//
//  QYCustomPresentAnimationDelegate.m
//  骑阅
//
//  Created by 亮 on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCustomPresentAnimationDelegate.h"
#import "define.h"

@implementation QYCustomPresentAnimationDelegate
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewKey];

    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (toVC.isBeingPresented) {
        
        [containerView addSubview:toView];
        CGFloat toWidth = containerView.frame.size.width;
        CGFloat toHeight =kScreenHeight - 163 -  cl_caculation_y(180);
        toView.frame = CGRectMake(kScreenWidth, 163, toWidth, toHeight);
        if (IOS8_OR_LATER) {
            
            [UIView animateWithDuration:duration animations:^{
               
                toView.frame = CGRectMake(0, 163, toWidth, toHeight);
            } completion:^(BOOL finished) {
                
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
        
    }
    
    if (fromVC.isBeingDismissed) {
        
        
    }
    
}

@end
