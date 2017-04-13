
//  QYSendCommentView.m
//  骑阅
//
//  Created by chen liang on 2017/3/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSendCommentView.h"
#import "UIView+YYAdd.h"
#import "UIButton+QYTitleButton.h"
#import "define.h"
#import "QYAddThumbApiManager.h"
#import "QYAddCommnetApiManager.h"
#import "NSString+QYRegular.h"
#import "QYUserReform.h"

@interface QYSendCommentView ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic ,strong) UIButton *praiseButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) QYAddThumbApiManager *addThump;
@property (nonatomic, strong) QYAddCommnetApiManager *addComment;
@property (nonatomic, strong) NSDictionary *paramSource;
@property (nonatomic, strong) QYUserReform *reform;
@end

@implementation QYSendCommentView

- (instancetype)init {
    
    self = [super init];
    [self setupUI];
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self addSubview:self.praiseButton];
    [self addSubview:self.textField];
    [self addSubview:self.sendButton];
    self.praiseButton.left = 16;
    self.praiseButton.top = 6;
    self.praiseButton.size = CGSizeMake(44, 40);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.praiseButton.mas_right).offset(5.5);
        make.top.mas_equalTo(6);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.sendButton.mas_left).offset(-5.5);
    }];
    self.sendButton.size = CGSizeMake(58, 40);
    self.sendButton.top = 6;
    self.sendButton.left = kScreenWidth - 16 - 58;
    
}

- (UIButton *)praiseButton {
    
    if (!_praiseButton) {
        
        _praiseButton = [UIButton new];
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"click_up_selected"] forState:UIControlStateNormal];
        [_praiseButton addTarget:self action:@selector(clickPraise:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseButton;
}

- (UITextField *)textField {
    if (!_textField) {
        
        _textField = [UITextField new];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:14];
        //_textField.attributedPlaceholder = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        [_textField addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.placeholder = @"   说点什么";
    }
    return _textField;
}

- (UIButton *)sendButton {
    
    if (!_sendButton) {
        _sendButton = [UIButton buttonTitle:@"发送" font:14 colco:[UIColor whiteColor]];
        [_sendButton setBackgroundColor:[UIColor colorWithRed:0.32 green:0.79 blue:0.76 alpha:1.00]];
        _sendButton.tag = 1;
        _sendButton.layer.cornerRadius = 5;
        [_sendButton addTarget:self action:@selector(clickPraise:) forControlEvents:UIControlEventTouchUpInside];
       }
    return _sendButton;
}

- (void)setInfo:(NSDictionary *)info {
    
    NSString *username = info[kusername];
    self.textField.placeholder = [NSString stringWithFormat:@"回复%@",username];
    self.textField.text = nil;
    _info = info;
    
}

#pragma mark - CTAPIManagParamSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
 
    return self.paramSource;
}

#pragma mark - CTAPIManagerCallback
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    
    if (manager == self.addThump) {
        
        [MBProgressHUD showMessageAutoHide:@"点赞失败" view:nil];
    }
    if (manager == self.addComment) {
        
        [MBProgressHUD showMessageAutoHide:@"回复失败" view:nil];
    }
 }

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    
    if (manager == self.addThump) {
        
        NSArray *thumbs = self.status[kpraise];
        NSMutableArray *thums = thumbs.mutableCopy;
        NSDictionary *info = [self.addThump fetchDataWithReformer:self.reform];
        [thums insertObject:info atIndex:0];
        self.status[kpraise] = thums;
    }
    
    if (manager == self.addComment) {
        
        [self.textField resignFirstResponder];
       NSDictionary *info =  [self.addComment fetchDataWithReformer:self.reform];
        NSArray *comments = self.status[kcomment];
        NSMutableArray *comms = comments.mutableCopy;
        [comms insertObject:info atIndex:0];
        self.status[kcomment] = comms;

    }
    if ([self.delegate respondsToSelector:@selector(sendView:acitonSuccess:)]) {
        
        [self.delegate sendView:self acitonSuccess:self.status];
    }
}

#pragma mark

- (void)textValueChange:(UITextField *)textFiled {
    
    if (textFiled.text.length == 0 || !textFiled.text) {
        
        self.info = nil;
        self.textField.placeholder = @"说的什么吧";
    }
}
- (void)clickPraise:(UIButton *)button {
    
    if (button.tag == 0) {
        
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        self.paramSource = @{kuid:uid,kmid:self.status[kmid]};
        [self.addThump loadData];
        return;
    }
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    NSString *text = self.textField.text;
    BOOL isSpace = [text checkSpaceText];
    if (isSpace) {
        return;
    }
    [self.textField resignFirstResponder];
    
    if (self.info) {
        
        self.paramSource = @{kmsg:text,kuid:uid,kmid:self.status[kmid],kreply_uid:self.info[kuid]};

        
    } else {
        self.paramSource = @{kmsg:text,kuid:uid,kmid:self.status[kmid]};
 
        
    }
    [self.addComment loadData];
}

- (QYAddThumbApiManager *)addThump {
    
    if (!_addThump) {
        
        _addThump = [[QYAddThumbApiManager alloc] init];
        _addThump.paramSource = self;
        _addThump.delegate = self;
    }
    
    return _addThump;
}

- (QYAddCommnetApiManager *)addComment {
    
    
    if (!_addComment) {
        
        _addComment = [[QYAddCommnetApiManager alloc] init];
        _addComment.paramSource = self;
        _addComment.delegate = self;
    }
    
    return _addComment;
}

- (QYUserReform *)reform {
    
    if (!_reform) {
        
        _reform = [[QYUserReform alloc] init];
    }
    return _reform;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
