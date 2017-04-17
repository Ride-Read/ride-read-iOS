//
//  QYSendCycleView.m
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSendCycleView.h"

@interface QYSendCycleView ()
@property (nonatomic, copy) void(^clickAction)(QYSendCycleView *send,NSInteger index);

@end
@implementation QYSendCycleView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
}
+ (instancetype)sendCycle {
    
    QYSendCycleView *send = [[NSBundle mainBundle] loadNibNamed:@"QYSendCycleView" owner:nil options:nil].firstObject;
    return send;
}
+ (instancetype)sendCycle:(void (^)(QYSendCycleView *, NSInteger))action {
    QYSendCycleView *send = [[NSBundle mainBundle] loadNibNamed:@"QYSendCycleView" owner:nil options:nil].firstObject;
    send.clickAction = action;
    return send;
}

- (instancetype)initCycle:(void (^)(QYSendCycleView *, NSInteger))action {
    
    self = [super init];
    self.clickAction = action;
    return self;
}

- (void)clickMaskView {
    
    [self endEditing:YES];
    
}
- (IBAction)clickSendAction:(id)sender {
    
    if (self.clickAction) {
        
        self.clickAction(self,1);
    }
    [self closeView];
    
}
- (IBAction)clickSharedAction:(id)sender {
    
    if (self.clickAction) {
        
        self.clickAction(self,0);
        
    }
    
    [self closeView];
    
}
- (IBAction)clickCloseAction:(id)sender {
    
    if (self.closeAction) {
        
        self.closeAction();
        [self closeView];
    }
}
@end
