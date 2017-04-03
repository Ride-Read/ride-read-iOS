//
//  QYBasicNeedLocationController.m
//  骑阅
//
//  Created by chen liang on 2017/4/3.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicNeedLocationController.h"
#import "define.h"
#import "QYUser.h"


@interface QYBasicNeedLocationController ()

@end

@implementation QYBasicNeedLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addNotifation];
    [[CTLocationManager sharedInstance] startLocation];
}
-(void)dealloc {
    
    [self removeNotifation];
}

#pragma mark - life cycle

- (void)addNotifation {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationServiceError:) name:kLocationServiceStatusErrorNotifation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationResult:) name:kLocationResultNotifationl object:nil];
}

- (void)removeNotifation {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Targart action

- (void)locationServiceError:(NSNotification *)info {
    
    [UIAlertController alertControler:@"提示" leftTitle:@"取消" rightTitle:@"去设置" from:self action:^(NSUInteger index) {
        
        if (index == 1) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
        }
    }];
}

- (void)locationResult:(NSNotification *)info {
    
    self.location = [CTLocationManager sharedInstance].currentLocation;
}


#pragma mark - getter
- (CLLocation *)location {
    
    if (![CTLocationManager sharedInstance].currentLocation) {
        
        QYUser *user = [CTAppContext sharedInstance].currentUser;
        NSNumber *longitude = user.longitude;
        NSNumber *latitude = user.latitude;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude.doubleValue longitude:longitude.doubleValue];
        return location;
    }
    return [CTLocationManager sharedInstance].currentLocation;
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
