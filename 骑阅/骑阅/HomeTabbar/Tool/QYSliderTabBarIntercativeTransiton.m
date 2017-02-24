//
//  QYSliderTabBarIntercativeTransiton.m
//  骑阅
//
//  Created by 亮 on 2017/2/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSliderTabBarIntercativeTransiton.h"
#import "define.h"

@interface QYSliderTabBarIntercativeTransiton ()

@end
@implementation QYSliderTabBarIntercativeTransiton

-(void)fireToTabBarController:(UITabBarController *)tabBarController {
    
    self.tabBarController = tabBarController;
    [self prepareGestureRecognizerInView:tabBarController.view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view {
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

//-(CGFloat)completionSpeed {
//    
//    return 1 - self.percentComplete;
//}

-(void)handleGesture:(UIPanGestureRecognizer *)gesture {
    
    CGPoint translation = [gesture translationInView:self.tabBarController.view];
    CGFloat translationAbs = translation.x > 0?translation.x:-translation.x;
    CGFloat pregress = translationAbs/self.tabBarController.view.frame.size.width;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.intercating = YES;
            CGFloat veloctyX = [gesture velocityInView:self.tabBarController.view].x;
            if (veloctyX < 0) {
                
                if (self.tabBarController.selectedIndex < self.tabBarController.viewControllers.count - 1) {
                    
                    self.tabBarController.selectedIndex += 1;
                }
                
            } else {
                
                if (self.tabBarController.selectedIndex > 0) {
                    
                    self.tabBarController.selectedIndex -= 1;
                }

            }
            break;
        }
        case UIGestureRecognizerStateChanged: {

            [self updateInteractiveTransition:pregress];
            break;
            
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
           
            self.intercating = NO;
            if (pregress < 0.3) {
                
                self.completionSpeed = 0.99;
                [self cancelInteractiveTransition];
            } else {
                
                self.completionSpeed = 0.99;
                [self finishInteractiveTransition];
            }
            break;

        }
            
        default:
            break;
    }
}

@end
