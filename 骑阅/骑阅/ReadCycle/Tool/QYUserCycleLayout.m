//
//  QYUserCycleLayout.m
//  骑阅
//
//  Created by chen liang on 2017/3/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYUserCycleLayout.h"
#import "UIColor+QYHexStringColor.h"

@implementation QYUserCycleLayout

- (void)layoutTime {
    
    [super layoutTime];
    self.profileHeight = self.timeLayout.textBoundingSize.height + 8.5;
}

- (CGFloat)contentViewMarginTop {
    
    return 15;
}
- (CGFloat)contentLayoutWidth {
    
    return kScreenWidth - 30;
}

- (CGFloat)pictureLayoutOneWidth {
    
    return cl_caculation_3x(225);
}

- (CGFloat)pictureLayoutTwoWidth {
    
    return cl_caculation_3x(225);
}

- (CGFloat)pictureLayoutMoreThanThreeWidth {
    
    return cl_caculation_3x(225);
}


@end
