//
//  QYNeedSiteViewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYNeedSiteViewController.h"

@interface QYNeedSiteViewController ()

@end

@implementation QYNeedSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationServiceError:(NSNotification *)info {
    
    [super locationServiceError:info];
    [[CTLocationManager sharedInstance] reverseGeocodeLocation:^(NSArray *array, NSError *error) {
        
    }];
}

- (void)locationResult:(NSNotification *)info {
    
    [super locationResult:info];
    [[CTLocationManager sharedInstance] reverseGeocodeLocation:^(NSArray *array, NSError *error) {
       
        self.site = array[0];
    }];
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
