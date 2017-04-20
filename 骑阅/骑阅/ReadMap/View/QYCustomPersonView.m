//
//  QYCustomPersonView.m
//  骑阅
//
//  Created by chen liang on 2017/4/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCustomPersonView.h"
#import "define.h"

@implementation QYCustomPersonView
+ (instancetype)loadPersonAnnoCus {
    
    QYCustomPersonView *locView = [[NSBundle mainBundle] loadNibNamed:@"QYCustomPersonView" owner:nil options:nil].firstObject;
    locView.frame = CGRectMake(0, 0,cl_caculation_3x(17),cl_caculation_3y(30));
    locView.backgroundColor = [UIColor clearColor];
    return locView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
