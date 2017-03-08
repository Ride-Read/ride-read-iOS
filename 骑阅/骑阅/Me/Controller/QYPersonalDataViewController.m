//
//  QYPersonalDataViewController.m
//  骑阅
//
//  Created by 谢升阳 on 2017/3/7.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPersonalDataViewController.h"
#import "UIColor+QYHexStringColor.h"
#import "UIBarButtonItem+CreatUIBarButtonItem.h"
#import "define.h"
#import "QYPersonalDataCell.h"

@interface QYPersonalDataViewController ()<UITableViewDataSource,UITableViewDelegate>

/** tableView */
@property(nonatomic,strong) UITableView * tableView;
@end

@implementation QYPersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavc];
    [self setupTableView];
}

- (void)setNavc {
    
    self.navigationItem.title = @"编辑资料";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#52CAC1"];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#52CAC1"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIBarButtonItem *saveButton = [UIBarButtonItem creatItemWithImage:nil highLightImage:nil title:@"保存" target:self action:@selector(clickSaveButton:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}
- (void) clickSaveButton:(UIButton *) sender {
    
    NSLog(@"%s",__func__);
}
- (void) setupTableView {
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    //添加tableView的约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
}

#pragma -- <UITableViewDataSource>
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 5;
    } else {
        return 0;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 0;
    } else {
        return 10;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row ==0) {
        return 80.0;
    } else {
        return 55.0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        QYPersonalDataCell * cell = [QYPersonalDataCell loadCellInTableView:tableView cellType:QYPersonalDataCellImageView];
        cell.mainTitleLabel.text = @"头像";
        cell.subImageView.image = [UIImage imageNamed:@"me"];
        cell.showBottomLine = YES;
        return cell;
        
    } else {
        
        QYPersonalDataCell * cell = [QYPersonalDataCell loadCellInTableView:tableView cellType:QYPersonalDataCellLabel];
        cell.mainTitleLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
        cell.subLabel.text= [NSString stringWithFormat:@"%zd",indexPath.row];
        cell.showBottomLine = YES;
        return cell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
