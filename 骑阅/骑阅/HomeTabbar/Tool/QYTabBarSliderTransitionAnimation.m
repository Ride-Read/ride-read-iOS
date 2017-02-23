//
//  QYTabBarSliderTransitionAnimation.m
//  骑阅
//
//  Created by 亮 on 2017/2/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTabBarSliderTransitionAnimation.h"
#import "define.h"

@interface QYTabBarSliderTransitionAnimation ()
@property (nonatomic, assign) CLTabBarSliderDirection direction;

@end
@implementation QYTabBarSliderTransitionAnimation
+(instancetype)transitionWithDirection:(CLTabBarSliderDirection)direction {
    
    return [[self alloc] initWithTransitionDirection:direction];
}

-(instancetype)initWithTransitionDirection:(CLTabBarSliderDirection)direction {
    
    self = [super init];
    self.direction = direction;
    return self;
    
}

#pragma mark - AnimationDelegate
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (_direction) {
        case CLTabBarSliderDirectionLeft:
        {
            [self sliderLeftAnimation:transitionContext];
            
            break;
        }
        case CLTabBarSliderDirectionRight:
        {
            [self sliderRightAnimation:transitionContext];
            break;
        }
     }
}

-(void)sliderLeftAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = CGRectMake(kScreenWidth, 0, containerView.bounds.size.width, containerView.bounds.size.height);
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        
        toVC.view.frame = CGRectMake(0, 0, containerView.bounds.size.width, containerView.bounds.size.height);
        fromVC.view.frame = CGRectMake(-kScreenWidth, 0, containerView.bounds.size.width, containerView.bounds.size.height);
    } completion:^(BOOL finished) {
       
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
}

-(void)sliderRightAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    // [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = CGRectMake(-kScreenWidth, 0, containerView.bounds.size.width, containerView.bounds.size.height);
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        
        toVC.view.frame = CGRectMake(0, 0, containerView.bounds.size.width, containerView.bounds.size.height);
        fromVC.view.frame = CGRectMake(kScreenWidth, 0, containerView.bounds.size.width, containerView.bounds.size.height);
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];


}


@end
