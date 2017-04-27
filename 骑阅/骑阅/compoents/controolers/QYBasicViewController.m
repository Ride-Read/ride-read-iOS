//
//  QYBasicViewController.m
//  骑阅
//
//  Created by chen liang on 2017/2/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicViewController.h"
#import "define.h"
#import "UIAlertController+QYQuickAlert.h"
#import "QYLoginOrRegisterFatherController.h"

@interface QYBasicViewController ()

@end

@implementation QYBasicViewController

- (instancetype)init {
    
    self = [super init];
    self.dataRefresh = self;
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    self.dataRefresh = self;
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.dataRefresh = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authfailed) name:kBSUserTokenInvalidNotifation object:nil];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private method

- (void)authfailed {
    
    if ([self isvaisbal]) {
        
        MyLog(@"the count for handle this message");
        [UIAlertController alertControler:@"提示" message:@"认证失败，请重新登录" leftTitle:nil rightTitle:@"确定" from:self action:^(NSUInteger index) {
           
            QYLoginOrRegisterFatherController *ctr = [[QYLoginOrRegisterFatherController alloc] init];
            [CTAppContext sharedInstance].currentUser = nil;
            [UIApplication sharedApplication].keyWindow.rootViewController = ctr;
        }];
    }
}

- (BOOL)isvaisbal {
    
    BOOL isvisibel = NO;
    if (self.isViewLoaded && self.view.window) {
        
        isvisibel = YES;
    }
    return isvisibel;
}

#pragma mark - notifaction

- (void)locationError {
 
    
}

#pragma mark - getter and setter
- (NSOperationQueue *)serialQueue {
    
    if (!_serialQueue) {
        
        _serialQueue = [[NSOperationQueue alloc] init];
        _serialQueue.maxConcurrentOperationCount = 1;
    }
    return _serialQueue;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
