//
//  QYRideMyCycleController.m
//  骑阅
//
//  Created by chen liang on 2017/3/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRideMyCycleController.h"

@interface QYRideMyCycleController ()

@end

@implementation QYRideMyCycleController

#pragma mark -life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"我的阅圈";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter

- (QYReadMeHeaderView *)headerView {
    
    return nil;
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
