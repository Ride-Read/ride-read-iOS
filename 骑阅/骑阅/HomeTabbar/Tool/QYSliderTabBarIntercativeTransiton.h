//
//  QYSliderTabBarIntercativeTransiton.h
//  骑阅
//
//  Created by 亮 on 2017/2/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,Transitiondirection) {
    
    TransitiondirectionLeft,
    TransitiondirectionRight
};
@interface QYSliderTabBarIntercativeTransiton : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL intercating;
@property (nonatomic, weak) UITabBarController *tabBarController;

-(void)fireToTabBarController:(UITabBarController *)tabBarController;
@end
