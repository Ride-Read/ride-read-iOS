//
//  QYTagCell.m
//  骑阅
//
//  Created by chen liang on 2017/4/24.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTagCell.h"
#import "define.h"

@interface QYTagCell ()

@property (nonatomic, copy) void(^click)(UIView *view);

@end

@implementation QYTagCell

+ (instancetype)customTagCell:(void (^)(UIView *))click {
    
    QYTagCell *cell = [[NSBundle mainBundle] loadNibNamed:@"QYTagCell" owner:nil options:nil].firstObject;
    [cell.selectButton setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    cell.click = click;
    cell.tagLabel.text = @"创建个性标签";
    return cell;
    
}

- (void)clickCustom:(UIButton *)sender {
    
    if (self.click) {
        
        self.click(self.prompt);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.selectButton addTarget:self action:@selector(clickCustom:) forControlEvents:UIControlEventTouchUpInside];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
