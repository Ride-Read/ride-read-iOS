//
//  QYNavigationController.m
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYNavigationController.h"
#import "UIColor+QYHexStringColor.h"

@interface QYNavigationController ()

@end

@implementation QYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavc];
    // Do any additional setup after loading the view.
}
- (void)configNavc {
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#52CAC1"];
    self.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#52CAC1"];
    self.navigationBar.shadowImage = [UIImage new];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
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
