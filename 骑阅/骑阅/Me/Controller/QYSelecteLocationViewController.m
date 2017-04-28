//
//  QYSelecteLocationViewController.m
//  骑阅
//
//  Created by 谢升阳 on 2017/4/26.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSelecteLocationViewController.h"
#import "define.h"
#import "YYBasicTableView.h"
#import "QYProvince.h"

@interface QYSelecteLocationViewController ()<UITableViewDelegate,UITableViewDataSource>
/** provinceView */
@property(nonatomic,strong) UITableView * provinceView;
/** cityView */
@property(nonatomic,strong) UITableView * cityView;
/** dataSource */
@property(nonatomic,strong) NSMutableArray * dataSource;
/** provinces */
@property(nonatomic,strong) NSMutableArray * provinces;
/** cities */
@property(nonatomic,copy) NSArray * cities;
/** resultAddress */
@property(nonatomic,strong) NSString * resultAddress;
/** provinceName */
@property(nonatomic,copy) NSString * provinceName;
@end

@implementation QYSelecteLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择地点";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self setupTableView];
}

- (void)loadData {
    
    NSString * addressPath = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"plist"];
    NSArray * addressArry = [NSArray arrayWithContentsOfFile:addressPath];
    for (NSDictionary * dict in addressArry) {
        QYProvince * province = [QYProvince loadWithDict:dict];
        [self.provinces addObject:province];
    }

}

- (void)setupTableView {
    
    self.provinceView = [[UITableView alloc]init];
    self.provinceView.delegate = self;
    self.provinceView.dataSource = self;
    [self.view addSubview:self.provinceView];
    [self.provinceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.5);
    }];
    
//    [self tableView:self.provinceView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    [self.provinceView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    self.cityView = [[UITableView alloc]init];
    self.cityView.delegate = self;
    self.cityView.dataSource = self;
    [self.view addSubview:self.cityView];
    
    [self.cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.5);
    }];
    
    [self tableView:self.provinceView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.provinceView) {
        
        return self.provinces.count;
    } else {
        return self.cities.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.provinceView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        QYProvince * province = self.provinces[indexPath.row];
        self.cities = province.cities;
        cell.textLabel.text = province.name;
        return cell;

    } else {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSDictionary * dict = self.cities[indexPath.row];
        cell.textLabel.text = dict[@"city"];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.provinceView) {
        
        QYProvince * province = self.provinces[indexPath.row];
        self.provinceName = province.name;
        self.cities = province.cities;
        [self.cityView reloadData];
        [self.cityView scrollsToTop];
        
    } else {
        
        NSDictionary * dict = self.cities[indexPath.row];
        NSString * cityName = dict[@"city"];
        self.resultAddress = [NSString stringWithFormat:@"%@ %@",self.provinceName,cityName];
        if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didFinishedSelectedAddress:)]) {
            [self.delegate viewController:self didFinishedSelectedAddress:self.resultAddress];
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -- <setter and getter>
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)provinces {
    if (!_provinces) {
        _provinces = [NSMutableArray array];
    }
    return _provinces;
}

@end
