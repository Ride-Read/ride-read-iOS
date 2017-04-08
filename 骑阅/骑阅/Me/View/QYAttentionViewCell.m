//
//  QYAttentionViewCell.m
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAttentionViewCell.h"
#import "define.h"

@interface QYAttentionViewCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) UILabel *personSiguare;
@property (nonatomic, strong) UILabel *timelabel;

@end
@implementation QYAttentionViewCell

- (instancetype)init {
    
    self = [super init];
    [self setupUI];
    [self layoutContent];
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    [self layoutContent];
    return self;
}

- (void)setupUI {
    
    self.showBottomLine = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.username];
    [self.contentView addSubview:self.personSiguare];
    [self.contentView addSubview:self.timelabel];
}

- (void)layoutContent {
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.height.equalTo(self.icon.mas_width);
    }];
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.icon.mas_right).offset(17.5);
        make.top.mas_equalTo(22);
    }];
    [self.personSiguare mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.icon.mas_right).offset(17.5);
        make.bottom.mas_equalTo(-21);
    }];
    [self.timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(22);
        make.right.mas_equalTo(-15);
    }];
}

#pragma mark - setter and getter

- (UIImageView *)icon {
    
    if (!_icon) {
        
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UILabel *)username {
    
    if (!_username) {
        
        _username = [[UILabel alloc] init];
        _username.textColor = [UIColor colorWithHexString:@"#000000"];
        _username.font = [UIFont systemFontOfSize:16];
    }
    return _username;
}

- (UILabel *)personSiguare {
    
    if (!_personSiguare) {
        
        _personSiguare = [[UILabel alloc] init];
        _personSiguare.textColor = [UIColor colorWithHexString:@"#555555"];
        _personSiguare.font = [UIFont systemFontOfSize:14];
    }
    return _personSiguare;
}

- (UILabel *)timelabel {
    
    if (!_timelabel) {
        
        _timelabel = [[UILabel alloc] init];
        _timelabel.textColor = [UIColor colorWithHexString:@"#555555"];
        _timelabel.font = [UIFont systemFontOfSize:12];
    }
    return _timelabel;
}

- (void)setInfo:(NSDictionary *)info {
    
    _info = info;
    MyLog(@"%@",info[kface_url]);
    [self.icon sd_setImageWithURL:[NSURL URLWithString:info[kface_url]] placeholderImage:nil];
    self.username.text = info[kusername];
    self.personSiguare.text = info[ksignature];
    self.timelabel.text = info[ktime];
    
}
@end
