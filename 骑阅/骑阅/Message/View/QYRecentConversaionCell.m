//
//  QYRecentConversaionCell.m
//  骑阅
//
//  Created by chen liang on 2017/3/30.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRecentConversaionCell.h"

@interface QYRecentConversaionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *msg;
@property (weak, nonatomic) IBOutlet UILabel *time;


@end
@implementation QYRecentConversaionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
