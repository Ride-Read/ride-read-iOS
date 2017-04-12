//
//  QYReadMapController.m
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYReadMapController.h"
#import "UIBarButtonItem+CreatUIBarButtonItem.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "define.h"

@interface QYReadMapController ()
@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation QYReadMapController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    [self locationUser];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setNavc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private method

- (void)setNavc {
  
    self.navigationItem.title = @"阅圈";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.00 green:0.82 blue:0.77 alpha:0.5];


}
- (void)setContentView {
    
    [self.view addSubview:self.mapView];
}

//定位用户的地点
- (void)locationUser {
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}

#pragma mark - getter and setter
- (MAMapView *)mapView {
    
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    }
    return _mapView;
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
