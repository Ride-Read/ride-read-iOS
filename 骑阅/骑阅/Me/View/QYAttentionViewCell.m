//
//  QYAttentionViewCell.m
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAttentionViewCell.h"
#import "define.h"
#import "UIView+YYAdd.h"
#import "UIAlertController+QYQuickAlert.h"
#import "QYFollowApiManager.h"
#import "QYUnfollowApiManager.h"

@interface QYAttentionViewCell ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYUnfollowApiManager *unApi;
@property (nonatomic, strong) QYFollowApiManager *followApi;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) UILabel *personSiguare;
@property (nonatomic, strong) UILabel *timelabel;
@property (nonatomic, strong) UIButton *attenion;

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
    [self.contentView addSubview:self.attenion];
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
    self.attenion.left = kScreenWidth - 16 - 41;
    self.attenion.top = 20;
    self.attenion.width = 41;
    self.attenion.height = 28.6;
    
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
- (UIButton *)attenion {
    
    if (!_attenion) {
        
        _attenion = [[UIButton alloc] init];
        [_attenion addTarget:self action:@selector(clickAttention:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attenion;
}

- (void)clickAttention:(UIButton *)sender {
    
    
    NSNumber *tag = _info[@"tag"];
    if (tag.integerValue == 0) {
        
        [UIAlertController alertControler:@"提示" message:@"是否关注该用户" leftTitle:@"取消" rightTitle:@"确定" from:_ctr action:^(NSUInteger index) {
           
            if (index == 1) {
                
                [self.followApi loadData];
                
            }
        }];
        
    } else {
        
        
        [UIAlertController alertControler:@"提示" message:@"是否取消关注该用户" leftTitle:@"取消" rightTitle:@"确定" from:_ctr action:^(NSUInteger index) {
            
            if (index == 1) {
                
                [self.unApi loadData];
            }
        }];

    }
    
}

#pragma mark - paramSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSDictionary *info = self.info;
    NSNumber *cuid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuser_id:info[kuid],kuid:cuid};
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    
    if ([manager isKindOfClass:[QYFollowApiManager class]]) {
        
        
        [MBProgressHUD showMessageAutoHide:@"关注成功" view:nil];
        _info[@"tag"] = @(1);
        _info[kstatus] = @"attention";
        [_ctr.dataRefresh customView:self refresh:nil];
    }
    
    if (manager == self.unApi) {
        
        [MBProgressHUD showMessageAutoHide:@"取消关注成功" view:nil];
        _info[@"tag"] = @(0);
        _info[kstatus] = @"attentioned";
        [_ctr.dataRefresh customView:self refresh:nil];
        
        
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if (manager == self.unApi) {
        
        [MBProgressHUD showMessageAutoHide:@"取消关注失败" view:nil];
    }
    
    if (manager == self.followApi) {
        
        [MBProgressHUD showMessageAutoHide:@"关注失败" view:nil];
    }
}

//- (void)attentionSuccess:(NSNotification *)info {
//    
//    if (info) {
//        
//        NSDictionary *dic = info.userInfo;
//        NSNumber *usid = dic[kuid];
//        NSNumber *cuCyuid = self.cell.layout.status[kuid];
//        if (usid.integerValue == cuCyuid.integerValue) {
//            
//            [self.attention setBackgroundImage:[UIImage imageNamed:@"attentioned"] forState:UIControlStateNormal];
//            self.cell.layout.status[kstatus] = @"attentioned";
//            self.attention.tag = 1;
//            self.cuAttN = @"attentioned";
//            
//        }
//        return;
//    }
//    [self.attention setBackgroundImage:[UIImage imageNamed:@"attentioned"] forState:UIControlStateNormal];
//    self.cell.layout.status[kstatus] = @"attentioned";
//    self.attention.tag = 1;
//    self.cuAttN = @"attentioned";
//    
//    
//}

- (QYUnfollowApiManager *)unApi {
    
    if (!_unApi) {
        
        _unApi = [[QYUnfollowApiManager alloc] init];
        _unApi.delegate = self;
        _unApi.paramSource = self;
    }
    return _unApi;
}

- (QYFollowApiManager *)followApi {
    
    if (!_followApi) {
        
        _followApi = [[QYFollowApiManager alloc] init];
        _followApi.delegate = self;
        _followApi.paramSource = self;
    }
    return _followApi;
}


- (void)setInfo:(NSMutableDictionary *)info {
    
    _info = info;
    MyLog(@"%@",info[kface_url]);
    [self.icon sd_setImageWithURL:[NSURL URLWithString:info[kface_url]] placeholderImage:nil];
    self.username.text = info[kusername];
    self.personSiguare.text = info[ksignature];
    self.timelabel.text = info[ktime];
    NSString *attention = info[kstatus];
    [self.attenion setBackgroundImage:[UIImage imageNamed:attention] forState:UIControlStateNormal];
    
    
}
@end
