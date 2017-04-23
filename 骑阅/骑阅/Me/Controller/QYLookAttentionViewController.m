//
//  QYLookAttentionViewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLookAttentionViewController.h"
#import "QYAttentionAndMessageView.h"

@interface QYLookAttentionViewController ()
@property (nonatomic, assign) NSInteger height;
@end

@implementation QYLookAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = 1;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"关注";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    
    [self.serialQueue addOperationWithBlock:^{
        
        [self.userApi loadData];
    }];
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager{
    
    [super managerCallAPIDidSuccess:manager];
    if (manager == self.userApi) {
        
        if (self.user_info.is_followed.integerValue == 0 || self.user_info.is_followed.integerValue == 1) {
            
            [self loadCycleData];
        } else {
            
            [self unLoadCircleData];
        }
    }
}

- (void)customView:(UIView *)customView refresh:(id)data {
    
    [super customView:customView refresh:data];
    
    if (self.user_info.is_followed.integerValue == 0 || self.user_info.is_followed.integerValue == 1) {
        
        [self loadCycleData];
        if (self.attentionHandle)
        {
            self.attentionHandle(1);
        }
    } else {
        
        if (self.attentionHandle)
        {
            self.attentionHandle(0);
        }
        [self unLoadCircleData];
    }
}

#pragma mark - private method

- (void)loadCycleData {
    
    [self.serialQueue addOperationWithBlock:^{
        
        [self.cycleApiManager loadData];
        
    }];
    self.height = 43;
    
}

- (void)unLoadCircleData {
    
    [self.layoutArray removeAllObjects];
    self.height = 0;
    [self.tableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.numberView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return self.height;
}

- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.attentionAndMessageView];
    [self.attentionAndMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.tableView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_3y(130));
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
