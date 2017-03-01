//
//  QYCustomPresentAnimationDelegate.m
//  骑阅
//
//  Created by 亮 on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCustomPresentAnimationDelegate.h"
#import "define.h"

@interface QYCustomPresentAnimationDelegate ()
@property (nonatomic, assign) QYLogTransitionType type;

@end
@implementation QYCustomPresentAnimationDelegate

+(instancetype)customPresentAnimationWithType:(QYLogTransitionType)type {
    
    return [[self alloc] initCustomPresentWithType:type];
}

-(instancetype)initCustomPresentWithType:(QYLogTransitionType)type {
    
    self = [super init];
    self.type = type;
    return self;
    
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    CGFloat height =kScreenHeight - cl_caculation_y(163 * 2) -  cl_caculation_y(180);
    containerView.frame = CGRectMake(0, cl_caculation_y(163 * 2), kScreenWidth, height);
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (_type == QYLogTransitionTypePresent) {
        [containerView addSubview:toView];

        if (toVC.isBeingPresented) {
            
            CGFloat toWidth = containerView.frame.size.width;
            CGFloat toHeight =kScreenHeight - cl_caculation_y(163 * 2) -  cl_caculation_y(180);
            toView.frame = CGRectMake(0, toHeight, toWidth, toHeight);
            if (IOS8_OR_LATER) {
                
                [UIView animateWithDuration:duration animations:^{
                    
                    toView.frame = CGRectMake(0, 0, kScreenWidth, height);
                } completion:^(BOOL finished) {
                    
                    [transitionContext completeTransition:YES];
                }];
            }
            
        }
        
        if (fromVC.isBeingDismissed) {
            
            CGFloat fromWidth = containerView.frame.size.width;
            CGFloat fromHeight =kScreenHeight - cl_caculation_y(163 * 2) -  cl_caculation_y(180);
            [UIView animateWithDuration:duration animations:^{
                
                fromView.frame = CGRectMake(0, cl_caculation_y(163 *2) - fromHeight, fromWidth, fromHeight);
                
            } completion:^(BOOL finished) {
                
                [transitionContext completeTransition:YES];
            }];
            
        }

    } else {
        
        CGRect fromRect = fromView.frame;
        [UIView animateWithDuration:duration animations:^{
            
            fromView.frame = CGRectMake(fromRect.origin.x, CGRectGetMaxY(fromRect), fromRect.size.width,0);
            toView.frame = fromRect;
            
        } completion:^(BOOL finished) {
           
             [transitionContext completeTransition:YES];
        }];
        
        
    }
    
    
}

@end
