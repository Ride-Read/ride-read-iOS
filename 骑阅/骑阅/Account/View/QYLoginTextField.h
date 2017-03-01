//
//  QYLoginTextField.h
//  骑阅
//
//  Created by 亮 on 2017/2/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYLoginTextField : UIView

/**
 该距离修改为距离中线左边的距离
 */
@property (nonatomic, assign) CGFloat textFieldCenterLeft;
@property (nonatomic, assign) CGFloat textFieldLeft;
@property (nonatomic, assign) CGFloat textFieldBottom;
@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) UIKeyboardType type;

@end
