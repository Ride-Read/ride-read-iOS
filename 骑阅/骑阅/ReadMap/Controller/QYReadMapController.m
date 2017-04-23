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
#import <AMapSearchKit/AMapSearchKit.h>
#import "define.h"
#import "QYMapSignView.h"
#import "QYSendCycleView.h"
#import "QYCyclePostController.h"
#import "QYRecentlyCycleApiManager.h"
#import "QYMapSearchView.h"
#import "QYAnnotationView.h"
#import "QYAnimationSign.h"
#import "QYSignAnnotion.h"

@interface QYReadMapController ()<QYViewClickProtocol,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,QYMapSearchViewDelegate,AMapSearchDelegate,MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) QYMapSignView *signView;
@property (nonatomic, assign) BOOL showSendCycleView;
@property (nonatomic, strong) QYRecentlyCycleApiManager *recentApi;
@property (nonatomic, strong) QYMapSearchView *searchView;
@property (nonatomic, strong) AMapSearchAPI *searchApi;
@property (nonatomic, strong) QYAnnotionModel *sendAnnotion;

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
  
    self.navigationItem.title = @"阅图";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.00 green:0.82 blue:0.77 alpha:0.5];
    self.tabBarController.tabBar.translucent = YES;


}
- (void)setContentView {
    
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.signView];
    [self.view addSubview:self.searchView];
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(-45);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_3y(135));
    }];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(15+64);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(-15);
    }];
}

//定位用户的地点
- (void)locationUser {
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
   
}

#pragma mark - serchDelegate

- (void)mapSearchView:(QYMapSearchView *)view start:(NSString *)text {
    
    if (text.length == 0) {
        
        return;
    }
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = text;
    [self.searchApi AMapPOIKeywordsSearch:request];
 }
#pragma mark - AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    
    [MBProgressHUD showMessageAutoHide:@"搜索失败" view:nil];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    
    if (response.count == 0) {
        [MBProgressHUD showMessageAutoHide:@"搜索失败" view:nil];
        return;
    }
    
    self.mapView.zoomLevel = 12;
    AMapPOI *poi = response.pois[0];
    CLLocationCoordinate2D loc;
    loc.latitude = poi.location.latitude;
    loc.longitude = poi.location.longitude;
    [self.mapView setCenterCoordinate:loc animated:YES];
   
}

#pragma mark - mapViewDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    self.location = userLocation.location;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[QYAnnotionModel class]]) {
        
        QYAnnotationView *view = [QYAnnotationView annotionViewMapView:mapView];
        view.annotation = annotation;
        return view;
        
    }
    return nil;
}
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    
    //获取到mapview的frame
    CGRect visibleRect = [mapView annotationVisibleRect];
    
    for (QYAnnotationView *view in views) {
        
        if ([view isKindOfClass:[QYAnnotationView class]]) {
            
            if ([view.annotation isKindOfClass:[QYAnimationSign class]]) {

                    CGRect endFrame = view.frame;
                    CGRect startFrame = endFrame;
                    startFrame.origin.y = visibleRect.origin.y - startFrame.size.height;
                    view.frame = startFrame;
                    [UIView animateWithDuration:1.0 animations:^{
                    
                    view.frame = endFrame;
                    
                    } completion:^(BOOL finished) {
                    
                    [self.mapView removeAnnotation:view.annotation];
                }];
                
                
            }
            
        }
       
    }
}

#pragma mark - CTApiManagerParmSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuid:uid?:@(-1),klatitude:@(self.location.coordinate.latitude),klongitude:@(self.location.coordinate.longitude)};
}

#pragma mark - CTApiManagerCallbackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if (manager == self.recentApi) {
        
        [MBProgressHUD showMessageAutoHide:@"附近阅圈加载失败" view:nil];
    }
    
}

#pragma mark - customDelegate
- (void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    if (index == 1) {
        
        if (self.showSendCycleView)
            return;
        
        QYAnnotionModel *annotion = [[QYAnimationSign alloc] init];
        annotion.coordinate = self.location.coordinate;
        [self.mapView addAnnotation:annotion];
        self.sendAnnotion = annotion;
        QYSendCycleView *send = [QYSendCycleView sendCycle:^(QYSendCycleView *cycle, NSInteger index) {
            
            if (index == 1) {
                
                UIStoryboard *post = [UIStoryboard storyboardWithName:@"QYPostCycleStoryboard" bundle:nil];
                UINavigationController *navc = [post instantiateViewControllerWithIdentifier:@"postCntr"];
                QYCyclePostController * postCtr = (QYCyclePostController *)navc.topViewController;
                postCtr.postResult = ^(NSDictionary *info,NSError *error) {
                
                    if (info) {
                        
                        QYSignAnnotion *sigin = [[QYSignAnnotion alloc] init];
                        sigin.info = info;
                        sigin.coordinate = self.sendAnnotion.coordinate;
                        self.sendAnnotion = nil;
                        [self.mapView addAnnotation:sigin];
                        
                    } else {
                        
                        self.sendAnnotion = nil;
                    }
                };
                [self presentViewController:navc animated:YES completion:nil];
            } else {
                
                self.sendAnnotion = nil;
                
            }
            self.showSendCycleView = NO;
        }];
        send.frame = CGRectMake(45, cl_caculation_3y(500), kScreenWidth-90, 45);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            [send show];
            
        });
        send.closeAction = ^() {
            
            self.showSendCycleView = NO;
            
        };
        self.showSendCycleView = YES;
    }
    
    if (index == 0) {
        
        [self.mapView setCenterCoordinate:self.location.coordinate animated:YES];
    }
    
    if (index == 2) {
     
        [self.serialQueue addOperationWithBlock:^{
           
            [self.recentApi loadData];
        }];
    }
}

#pragma mark - getter and setter
- (MAMapView *)mapView {
    
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        _mapView.delegate = self;
    }
    return _mapView;
}

- (QYMapSignView *)signView {
    
    if (!_signView) {
        
        _signView = [QYMapSignView signView];
        _signView.backgroundColor = [UIColor clearColor];
        _signView.delegate = self;
    }
    return _signView;
}

- (QYRecentlyCycleApiManager *)recentApi {
    
    if (!_recentApi) {
        
        _recentApi = [[QYRecentlyCycleApiManager alloc] init];
        _recentApi.delegate = self;
        _recentApi.paramSource = self;
    }
    return _recentApi;
}

- (QYMapSearchView *)searchView {
    
    if (!_searchView) {
        
        _searchView = [QYMapSearchView mapSearchView];
        _searchView.delegate = self;
    }
    return _searchView;
}

- (AMapSearchAPI *)searchApi {
    
    if (!_searchApi) {
        
        _searchApi = [[AMapSearchAPI alloc] init];
        _searchApi.delegate = self;
    }
    return _searchApi;
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
