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
#import "QYPersonAnnotionView.h"
#import "define.h"
#import "QYDetailCycleByPresentedController.h"
#import "QYNavigationController.h"

@interface QYPersonMapController ()<MAMapViewDelegate, QYCustomAnnotionViewDelegate>
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
        
        
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        QYPersonAnnotionView *annotationView = (QYPersonAnnotionView *)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        if (!annotationView) {
            
            annotationView = [[QYPersonAnnotionView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
        }
        
        return annotationView;
        
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    MyLog(@"hello click");
    QYPersonAnnotion *anno = view.annotation;
    NSDictionary *info = anno.info;
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    NSMutableDictionary *data = @{kuid:uid,kmid:info[kmid]}.mutableCopy;
    QYCycleDetailViewController *detail = [[QYDetailCycleByPresentedController alloc] init];
    detail.user = data;
    QYNavigationController *navc = [[QYNavigationController alloc] initWithRootViewController:detail];
    [self presentViewController:navc animated:YES completion:nil];
}

#pragma mark - customAnnotionView delegate
- (void)clickCustomAnnotion:(QYCustomAnnotionView *)view info:(NSDictionary *)info {
    
    MyLog(@"fuck you");
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
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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
