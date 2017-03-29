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
#import "QYNamePromptView.h"
#import "QYTagPromptView.h"


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
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 49, 0);
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    [self.tableView registerClass:[QYPersonalDataCell class] forCellReuseIdentifier:@"QYPersonalDataCell"];
    [self.view addSubview:self.tableView];
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

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row ==0) {
        return 80.0;
    } else {
        return 55.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYPersonalDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QYPersonalDataCell"];

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.cellType = QYPersonalDataCellImageView;
            cell.subImageView.image = nil;
        } else {
            cell.cellType = QYPersonalDataCellLabel;
            cell.subLabel.text = self.user.username;
        }
    } else if (indexPath.section == 1) {
        cell.cellType = QYPersonalDataCellLabel;
        if (indexPath.row == 0) {
            cell.subLabel.text = [NSString stringWithFormat:@"%zd",self.user.sex];
        } else if (indexPath.row == 1) {
            cell.subLabel.text = @"标签";
        } else {
            cell.subLabel.text = @"个性签名";
        }
    } else {
        cell.cellType = QYPersonalDataCellLabel;
        cell.subLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    }
    return cell;
}
#pragma -- <UITaleViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            QYNamePromptView * nameView = [QYNamePromptView creatView];
            nameView.title = @"昵称";
            [nameView show];
        }
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 1) {
            
            QYTagPromptView * tagView = [QYTagPromptView creatView];
            tagView.title = @"标签";
            [tagView show];
        }
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
