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

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"celll"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row + 1];
    return cell;
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
