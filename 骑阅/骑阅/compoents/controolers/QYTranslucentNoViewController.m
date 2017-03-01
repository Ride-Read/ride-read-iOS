//
//  QYTranslucentNoViewController.m
//  骑阅
//
//  Created by chen liang on 2017/3/1.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTranslucentNoViewController.h"

@interface QYTranslucentNoViewController ()

@end

@implementation QYTranslucentNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
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
