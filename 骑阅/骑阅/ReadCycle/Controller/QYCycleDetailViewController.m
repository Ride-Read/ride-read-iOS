//
//  QYCycleDetailViewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/17.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleDetailViewController.h"
#import "QYShowOneMonentApiManager.h"
#import "QYMomentReform.h"
#import "define.h"

@interface QYCycleDetailViewController ()
@property (nonatomic, strong) QYShowOneMonentApiManager *showOne;
@property (nonatomic, strong) QYMomentReform *refrom;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation QYCycleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDetailData];
    self.hud = [MBProgressHUD showMessage:@"加载中..." toView:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - private method

- (void)loadDetailData {
    
    [self.serialQueue addOperationWithBlock:^{
       
        [self.showOne loadData];
    }];
}

- (void)reloadData {
    
    self.cell = nil;
    self.tableView.tableHeaderView = nil;
    self.cell.layout = self.layout;
    self.tableView.tableHeaderView = self.cell;
    self.sendView.status = self.layout.status;
    [self analyseData];
    
}

#pragma mark - apiParam
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.showOne) {

        return @{kuid:self.user[kuid],kmid:self.user[kmid],klatitude:@(self.location.coordinate.latitude),klongitude:@(self.location.coordinate.longitude)};

    } else
        return [super paramsForApi:manager];
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if (manager == self.showOne) {

        [self.hud hide:YES];
        [MBProgressHUD showMessageAutoHide:@"加载失败" view:nil];
        [self.navigationController popViewControllerAnimated:YES];

    } else
        [super managerCallAPIDidFailed:manager];
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (manager == self.showOne) {
    
        [self.hud hide:YES];
        NSDictionary *info = [self.showOne fetchDataWithReformer:self.refrom];
        QYDetailCycleLayout *detailLayout = [QYDetailCycleLayout friendStatusCellLayout:info];
        self.layout = detailLayout;
        [self reloadData];
        
    } else
        [super managerCallAPIDidSuccess:manager];
    
}

#pragma mark - getter and settter
- (QYShowOneMonentApiManager *)showOne {
    
    if (!_showOne) {
        
        _showOne = [[QYShowOneMonentApiManager alloc] init];
        _showOne.delegate = self;
        _showOne.paramSource = self;
    }
    return _showOne;
}
- (QYMomentReform *)refrom {
    
    if (!_refrom) {
        
        _refrom = [[QYMomentReform alloc] init];
    }
    return _refrom;
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
