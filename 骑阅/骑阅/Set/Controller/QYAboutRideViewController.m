//
//  QYAboutRideViewController.m
//  骑阅
//
//  Created by chen liang on 2017/3/25.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAboutRideViewController.h"


@interface QYAboutRideViewController ()

@end

@implementation QYAboutRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"关于骑阅";
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
