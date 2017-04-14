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
            
            self.handler(0,@"");
        }
        
    } else {
        
        NSDictionary *info = self.array[indexPath.row-1];
        self.handler(indexPath.row,info[@"sub"]);
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter and setter

- (void)setLocation:(CLLocation *)location {
    
    _location = location;
    [self.array removeAllObjects];
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    [geo reverseGeocodeLocation:_location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            
            for (CLPlacemark *plcace in placemarks) {
                
                MyLog(@"plcate:%@",plcace);
                MyLog(@"name:%@,%@,%@,%@,%@",plcace.name,plcace.administrativeArea,plcace.subAdministrativeArea,plcace.locality,plcace.subLocality);
                NSString *site = [NSString stringWithFormat:@"%@%@%@%@"
                                  ,plcace.administrativeArea?:plcace.subAdministrativeArea,
                                  plcace.locality,
                                  plcace.subLocality,
                                  plcace.name];
                NSDictionary *info = @{@"name":plcace.name,@"sub":site};
                [self.array addObject:info];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                    
                });
                
            }
        } else {
            
            [MBProgressHUD showMessageAutoHide:@"定位失败" view:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (NSMutableArray *)array {
    
    if (!_array) {
        
        _array = [NSMutableArray array];
    }
    return _array;
}

@end
