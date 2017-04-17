//
//  QYMapSignView.m
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYMapSignView.h"

@interface QYMapSignView ()
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *recentlyButton;
@property (weak, nonatomic) IBOutlet UIButton *sginButton;

@end
@implementation QYMapSignView

+ (instancetype)signView {
    
    QYMapSignView *sginView = [[NSBundle mainBundle] loadNibNamed:@"QYMapSignView" owner:nil options:nil].firstObject;
    return sginView;
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.sginButton.layer.cornerRadius = 30;
    UILongPressGestureRecognizer *getsture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressAction:)];
    getsture.minimumPressDuration = 1.2;
    [self.sginButton addGestureRecognizer:getsture];
}

- (void)pressAction:(UILongPressGestureRecognizer *)gesture {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:1];
    }
}

- (IBAction)clickLocationButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:0];
    }
    
}
- (IBAction)clickRecentButton:(UIButton *)sender {
 
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:2];
    }
}

@end
