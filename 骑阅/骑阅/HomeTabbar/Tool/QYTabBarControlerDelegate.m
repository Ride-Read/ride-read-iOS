//
//  QYTabBarControlerDelegate.m
//  骑阅
//
//  Created by 亮 on 2017/2/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTabBarControlerDelegate.h"
#import "QYSliderTabBarIntercativeTransiton.h"
#import "QYTabBarSliderTransitionAnimation.h"
#import "QYReadMapController.h"
#import "QYReadCycleController.h"
#import "QYReadMeController.h"


@interface QYTabBarControlerDelegate ()
@property (nonatomic, assign) NSInteger index;

@end
@implementation QYTabBarControlerDelegate

-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    return self.tabBar.intercating?self.tabBar:nil;
}
-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    NSLog(@"================");
    NSInteger fromIndex =  [tabBarController.viewControllers indexOfObject:fromVC];
    self.index = fromIndex;
    NSInteger toInex = [tabBarController.viewControllers indexOfObject:toVC];
    if (fromIndex > toInex) {
        
        return [QYTabBarSliderTransitionAnimation transitionWithDirection:CLTabBarSliderDirectionRight];
    } else {
        
        return [QYTabBarSliderTransitionAnimation transitionWithDirection:CLTabBarSliderDirectionLeft];
    }
    return nil;
}
@end
