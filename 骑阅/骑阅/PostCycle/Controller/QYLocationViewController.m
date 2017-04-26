//
//  QYLocationViewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLocationViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "QYLocationCell.h"
#import "define.h"

@interface QYLocationViewController ()
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) CLLocation *one;
@property (nonatomic, strong) CLLocation *two;
@property (nonatomic, strong) CLLocation *three;
@property (nonatomic, strong) CLLocation *foure;

@end

@implementation QYLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#555555"],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"fristcell" forIndexPath:indexPath];

        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
        QYLocationCell *loc_cell = (QYLocationCell *)cell;
        NSDictionary *info = self.array[indexPath.row-1];
        loc_cell.locatonTitle.text = info[@"name"];
        loc_cell.detailTitle.text = info[@"sub"];
        
    }
 
    return cell;
}

#pragma mark - taregt action
- (IBAction)clickBackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        if (self.handler) {
            
            self.handler(0,@"",nil);
        }
        
    } else {
        
        NSDictionary *info = self.array[indexPath.row-1];
        NSString *sub = info[@"sub"];
        NSArray *array = [sub componentsSeparatedByString:@"."];
        NSString *location = [NSString stringWithFormat:@"%@.%@",array[1],array[3]];
        CLLocation *loc = self.locations[indexPath.row-1];
        self.handler(indexPath.row,location,loc);
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter and setter

- (void)setLocation:(CLLocation *)location {
    
    _location = location;
    [self.array removeAllObjects];
    [self.locations removeAllObjects];
    
    self.one =  [[CLLocation alloc] initWithLatitude:location.coordinate.latitude+0.00009 longitude:location.coordinate.longitude];
    self.two = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude-0.00009];
    self.three = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude+0.00001 longitude:location.coordinate.longitude];
    self.foure = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude-0.00001];
    NSArray *locations = @[_location,_one,_three,_two,_foure];
    for (int  i = 0; i < locations.count ; i ++) {
        
        CLLocation *loc = locations[i];
        CLGeocoder *geo = [[CLGeocoder alloc] init];
        [geo reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (placemarks.count > 0) {
                
                CLPlacemark *plcace = placemarks[0];
                NSString *site = [NSString stringWithFormat:@"%@.%@.%@.%@"
                                      ,plcace.administrativeArea?:plcace.subAdministrativeArea,
                                      plcace.locality,
                                      plcace.subLocality,
                                      plcace.name];
                NSDictionary *info = @{@"name":plcace.name,@"sub":site};
                [self.array addObject:info];
                [self.locations addObject:plcace.location];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                });
                
            } else {
             
                MyLog(@"rego error");
            }
        }];
    }
   
}

- (NSMutableArray *)array {
    
    if (!_array) {
        
        _array = [NSMutableArray array];
    }
    return _array;
}

- (NSMutableArray *)locations {
    
    if (!_locations) {
        
        _locations = @[].mutableCopy;
    }
    return _locations;
}

@end
