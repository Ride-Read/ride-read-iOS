//
//  QYCycleCollectCellTableViewCell.m
//  骑阅
//
//  Created by chen liang on 2017/3/24.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleCollectCellTableViewCell.h"
#import "define.h"

@interface QYCycleCollectCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *usename;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *from;

@end
@implementation QYCycleCollectCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 25.0/2;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self showBottomLine];
    // Initialization code
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(NSDictionary *)info {
    
    _info = info;
    NSString *url = info[kcover];
    NSString *face = info[kface_url];
    NSString *usernaem = info[kusername];
    NSString *title = info[kmsg];
    NSString *from = info[kfrom];
    NSString *time = info[ktime];
    [self.cover sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:face] placeholderImage:nil];
    self.usename.text = usernaem;
    self.time.text = time;
    self.title.text = title;
    self.from.text = from;
}


@end
