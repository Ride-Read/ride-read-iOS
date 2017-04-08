//
//  QYRideMyCycleController.m
//  骑阅
//
//  Created by chen liang on 2017/3/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRideMyCycleController.h"
#import "define.h"

@interface QYRideMyCycleController ()

@end

@implementation QYRideMyCycleController

#pragma mark -life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.attentionAndMessageView.hidden = YES;
    
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

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSNumber *cuid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuid:cuid?:@(-1),kuser_id:cuid?:@(-1),klatitude:@(self.location.coordinate.latitude),klongitude:@(self.location.coordinate.longitude)};
    
}

#pragma mark - publice method

- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
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
