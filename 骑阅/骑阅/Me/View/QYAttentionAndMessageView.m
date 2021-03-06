//
//  QYAttentionAndMessageView.m
//  骑阅
//
//  Created by chen liang on 2017/4/9.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAttentionAndMessageView.h"
#import "QYConversationViewController.h"
#import "UIAlertController+QYQuickAlert.h"
#import "QYFollowApiManager.h"
#import "QYUnfollowApiManager.h"
#import "define.h"

@interface QYAttentionAndMessageView ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYUnfollowApiManager *unApi;
@property (nonatomic, strong) QYFollowApiManager *followApi;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation QYAttentionAndMessageView

+ (instancetype)loadAttentionAndMessage {
    
    QYAttentionAndMessageView *view = [[NSBundle mainBundle] loadNibNamed:@"QYAttentionAndMessageView" owner:nil options:nil].firstObject;
    return view;
}
- (void)setType:(QYAttentionAndMessageViewType)type {
    
    _type = type;
   
}
- (IBAction)clickAttention:(UIButton *)sender {
    
    QYBasicViewController *contr = (QYBasicViewController *)self.dataRefresh;
    
    if (self.type == QYAttentionAndMessageViewNoselect) {
        
        [UIAlertController alertControler:nil message:@"是否取消关注" leftTitle:@"取消" rightTitle:@"确认" from:contr action:^(NSUInteger index) {
           
            if (index == 1) {
                
                self.hud = [MBProgressHUD showMessage:@"取关中..." toView:nil];
                [self.unApi loadData];
            }
        }];
        return;
    }
    
    [UIAlertController alertControler:nil message:@"关注该用户" leftTitle:@"取消" rightTitle:@"确认" from:contr action:^(NSUInteger index) {
        
        if (index == 1) {
            
            self.hud = [MBProgressHUD showMessage:@"关注中..." toView:nil];
            [self.followApi loadData];
        }
    }];
    
}
- (IBAction)clickMessage:(UIButton *)sender {
    
    NSNumber *uid = self.user.uid;
    if (self.user.is_followed.integerValue == 1 || self.user.is_followed.integerValue == 0) {
        
        QYConversationViewController *conver = [[QYConversationViewController alloc] initWithPeerId:[NSString stringWithFormat:@"%@",uid]];
        QYBasicViewController *contr = (QYBasicViewController *)self.dataRefresh;
        [contr.navigationController pushViewController:conver animated:YES];
        return;
    }
    [MBProgressHUD showMessageAutoHide:@"未关注该用户，无法操作" view:nil];
   
}

#pragma mark - paramSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSNumber *cuid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuser_id:self.user.uid,kuid:cuid};

}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    
    [self.hud hide:YES];
    [MBProgressHUD showMessageAutoHide:@"操作成功" view:nil];
    if (manager == self.followApi) {
        
        self.user.follower = @(self.user.follower.integerValue + 1);
        self.user.is_followed = @(1);
        [self analyze];
        
    }
    
    if (manager == self.unApi) {
        
        self.user.follower = @(self.user.follower.integerValue - 1);
        self.user.is_followed = @(-1);
        [self analyze];
       
    }
    if ([self.dataRefresh respondsToSelector:@selector(customView:refresh:)]) {
        
        [self.dataRefresh customView:self refresh:nil];
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if (manager == self.unApi) {
        
        [MBProgressHUD showMessageAutoHide:@"取消关注失败" view:nil];
        return;
    }
    
    if (manager == self.followApi) {
        
        [MBProgressHUD showMessageAutoHide:@"关注失败" view:nil];
    }
}

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

- (void)setUser:(QYUser *)user {
    
    _user = user;
    [self analyze];

}

- (void)analyze {
    
    NSNumber *is_followd = self.user.is_followed;
    if (is_followd.integerValue == 0 || is_followd.integerValue == 1) {
        
        self.attention.selected = NO;
        self.message.selected = NO;
        self.type = QYAttentionAndMessageViewNoselect;
        return;
    }
    
    self.type = QYAttentionAndMessageViewSelect;
    self.attention.selected = YES;
    self.message.selected = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
