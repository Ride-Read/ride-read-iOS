//
//  QYSetFooterView.m
//  骑阅
//
//  Created by chen liang on 2017/3/25.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSetFooterView.h"
#import "define.h"
#import "UIButton+QYTitleButton.h"

@interface QYSetFooterView ()
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@end
@implementation QYSetFooterView

+ (instancetype)setFooterView:(id)target action:(SEL)action title:(NSString *)title {
    
    return [[self alloc] initFooterView:target action:action title:title];
}

- (instancetype)initFooterView:(id)target action:(SEL)action title:(NSString *)title {
    self = [super init];
    self.target = target;
    self.action = action;
    UIButton *button = [UIButton buttonTitle:title font:16 * SizeScale3x colco:[UIColor whiteColor]];
    button.backgroundColor = [UIColor colorWithHexString:@"#5ACAC1"];
    button.layer.cornerRadius = 4.0;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(37);
        make.right.mas_equalTo(-37);
        make.top.mas_equalTo(cl_caculation_3y(45));
        make.bottom.mas_equalTo(0);
    }];
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
