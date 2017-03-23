//
//  QYRequstFrindViewController.m
//  骑阅
//
//  Created by chen liang on 2017/3/24.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRequstFrindViewController.h"
#import "YYBasicTableView.h"
#import "define.h"

@interface QYRequstFrindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) YYBasicTableView *tableView;

@end

@implementation QYRequstFrindViewController

#pragma mark - lifec cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContent];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"邀请好友";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private method
- (void)setContent {
    
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"requestcell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell showBottomLine];
    switch (indexPath.row) {
        case 0:
        {
            
            cell.textLabel.text = @"分享给微信好友";
        }
            break;
        case 1:
        {
            
            cell.textLabel.text = @"分享到朋友圈";
        }
            break;
        case 2:
        {
            
            cell.textLabel.text = @"分享到QQ";
        }
            break;
        case 3:
        {
            
            cell.textLabel.text = @"分享到通讯录好友";
        }
            break;
        case 4:
        {
            
            cell.textLabel.text = @"分享到新浪微博";
        }
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cl_caculation_3y(110);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            
            break;
        }
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - getter and setter
- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleDefault];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = self.view.bounds;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"requestcell"];

    }
    return _tableView;
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
