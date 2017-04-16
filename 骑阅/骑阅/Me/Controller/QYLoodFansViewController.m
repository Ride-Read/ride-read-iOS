//
//  QYLoodFansViewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoodFansViewController.h"

@interface QYLoodFansViewController ()

@end

@implementation QYLoodFansViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.attentionAndMessageView.type = QYAttentionAndMessageViewSelect;
    self.type = 2;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"粉丝";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
