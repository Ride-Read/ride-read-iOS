//
//  QYTagCell.h
//  骑阅
//
//  Created by chen liang on 2017/4/24.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYTagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (nonatomic, weak) UIView *prompt;

+ (instancetype)customTagCell:(void(^)(UIView *view))click;
@end
