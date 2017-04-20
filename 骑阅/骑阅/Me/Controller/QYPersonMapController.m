//
//  QYPersonMapController.m
//  骑阅
//
//  Created by chen liang on 2017/4/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPersonMapController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "QYPersonAnnotion.h"
#import "QYAnnotationView.h"
#import "define.h"
#import "QYCycleDetailViewController.h"

@interface QYPersonMapController ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation QYPersonMapController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    [self loadData];
    [self locationUser];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
   
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}
#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[QYPersonAnnotion class]]) {
        
        QYAnnotationView *annoView = [QYAnnotationView annotionViewMapView:mapView];
        annoView.annotation = annotation;
        return annoView;
        
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    QYPersonAnnotion *anno = view.annotation;
    NSDictionary *info = anno.info;
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    NSMutableDictionary *data = @{kuid:uid,kmid:info[kmid]}.mutableCopy;
    QYCycleDetailViewController *detail = [[QYCycleDetailViewController alloc] init];
    detail.user = data;
    [self.navigationController pushViewController:detail animated:YES];
    
}


#pragma mark - private method

- (void)locationUser {
    
    NSNumber *lati = self.user.latitude;
    NSNumber *longti = self.user.longitude;
    CLLocationCoordinate2D coor;
    coor.latitude = lati.doubleValue;
    coor.longitude = longti.doubleValue;
    [self.mapView setCenterCoordinate:coor animated:YES];
    
}
- (void)loadData {
    
    [self.mapView addAnnotations:self.annos];
}
- (void)setContentView {
    
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(34);
        make.width.mas_equalTo(cl_caculation_3x(90));
        make.height.mas_equalTo(cl_caculation_3x(90));
    }];

}

#pragma mark - target action

- (void)clickBackAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter and setter
- (MAMapView *)mapView {
    
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        _mapView.delegate = self;
    }
    return _mapView;
}

- (UIButton *)backButton {
    
    if (!_backButton) {
        
        _backButton = [[UIButton alloc] init];
        [_backButton addTarget:self action:@selector(clickBackAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"person_map_back"] forState:UIControlStateNormal];
    }
    return _backButton;
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
