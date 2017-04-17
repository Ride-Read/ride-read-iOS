
//
//  QYMapSearchView.m
//  骑阅
//
//  Created by chen liang on 2017/4/17.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYMapSearchView.h"

@interface QYMapSearchView ()<UITextFieldDelegate>

@end
@implementation QYMapSearchView

+ (instancetype)mapSearchView {
    
    QYMapSearchView *search = [[NSBundle mainBundle] loadNibNamed:@"QYMapSearchView" owner:nil options:nil].firstObject;
    return search;
    
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.textFiled.delegate = self;
    self.textFiled.leftViewMode = UITextFieldViewModeAlways;
    self.textFiled.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索"]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(mapSearchView:start:)]) {
        
        [self.delegate mapSearchView:self start:textField.text];
    }
    
}

@end
