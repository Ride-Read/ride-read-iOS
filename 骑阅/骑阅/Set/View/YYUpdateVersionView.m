//
//  YYUpdateVersionView.m
//  优悦一族
//
//  Created by liang on 2017/4/14.
//  Copyright © 2017年 umed. All rights reserved.
//

#import "YYUpdateVersionView.h"

@interface YYUpdateVersionView ()

@property (weak, nonatomic) IBOutlet UILabel *updateContent;
@property (nonatomic, strong) void(^action)();
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end
@implementation YYUpdateVersionView

+ (instancetype)loadUpdatePromptView:(void (^)(NSInteger))action {
    
    
    YYUpdateVersionView *update = [[[NSBundle mainBundle] loadNibNamed:@"YYUpdateVersionView" owner:nil options:nil] lastObject];
    update.action  = action;
    update.layer.cornerRadius = 8.0;
    update.layer.masksToBounds = YES;
    return update;
    
}

- (void)show {
    
    [super show];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.superview.mas_centerY);
        make.left.mas_equalTo(cl_caculation_3x(60));
        make.right.mas_equalTo(cl_caculation_3y(-60));
        make.bottom.equalTo(self.bottomView.mas_bottom);
    }];
}
- (void)clickMaskView {
    
    
}
- (IBAction)clickLookAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        self.updateContent.text = self.updateText;
    } else {
        
        self.updateContent.text = @"";
    }
}

- (IBAction)clickCancelAction:(UIButton *)sender {
    
    [self closeView];
    if (self.action) {
        
        self.action(0);
        self.action = nil;
    }
    
}
- (IBAction)clickConfirmAction:(UIButton *)sender {
    
    [self closeView];
    if (self.action) {
        
        self.action(1);
        self.action = nil;
    }
}

@end
