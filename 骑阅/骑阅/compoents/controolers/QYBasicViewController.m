//
//  QYBasicViewController.m
//  骑阅
//
//  Created by chen liang on 2017/2/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicViewController.h"
#import "define.h"

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
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
