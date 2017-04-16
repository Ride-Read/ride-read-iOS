//
//  QYFromIconLickViewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYFromIconLickViewController.h"

@interface QYFromIconLickViewController ()

@end

@implementation QYFromIconLickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
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
