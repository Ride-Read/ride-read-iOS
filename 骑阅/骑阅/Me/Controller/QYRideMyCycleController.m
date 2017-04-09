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


#pragma mark - publice method

- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

- (void)loadData {
    
    [self.serialQueue addOperationWithBlock:^{
       
        [self.cycleApiManager loadData];
    }];
}

//not need refresh user data rewrite super method do nothing
- (void)customView:(UIView *)customView refresh:(id)data {
    
    
}

#pragma mark - setter and getter

- (QYReadMeHeaderView *)headerView {
    
    return nil;
}

- (NSMutableDictionary *)user {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuid:uid}.mutableCopy;
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
