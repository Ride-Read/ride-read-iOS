//
//  QYTabBarControlerDelegate.h
//  骑阅
//
//  Created by 亮 on 2017/2/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QYSliderTabBarIntercativeTransiton.h"

@interface QYTabBarControlerDelegate : NSObject<UITabBarControllerDelegate>
@property (nonatomic, strong) QYSliderTabBarIntercativeTransiton *readMap;
@property (nonatomic, strong) QYSliderTabBarIntercativeTransiton *readCycle;
@property (nonatomic, strong) QYSliderTabBarIntercativeTransiton *readMe;
@property (nonatomic, strong) QYSliderTabBarIntercativeTransiton *tabBar;

@end
