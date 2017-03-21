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
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    [self.view addSubview:self.tableView];
    
    //添加tableView的约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
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
    
    if (indexPath.section == 0) {
        
        
        if (indexPath.row == 0) {
            
            QYPersonalDataCell * cell = [QYPersonalDataCell loadCellInTableView:tableView cellType:QYPersonalDataCellImageView];
            cell.mainTitleLabel.text = @"头像";
            cell.subImageView.image = [UIImage imageNamed:@"me"];
            cell.showBottomLine = YES;
            return cell;
        } else {
            
            QYPersonalDataCell * cell = [QYPersonalDataCell loadCellInTableView:tableView cellType:QYPersonalDataCellLabel];
            cell.mainTitleLabel.text = @"昵称";
            cell.subLabel.text = @"建议使用真实姓名";
            return cell;
        }
        
    } else if (indexPath.section == 1)  {
        
        
        if (indexPath.row == 0) {
            QYPersonalDataCell * cell = [QYPersonalDataCell loadCellInTableView:tableView cellType:QYPersonalDataCellLabel];
            cell.mainTitleLabel.text = @"性别";
            cell.showBottomLine = YES;
            return cell;

        } else if (indexPath.row == 1) {
            
            QYPersonalDataCell * cell = [QYPersonalDataCell loadCellInTableView:tableView cellType:QYPersonalDataCellLabel];
            cell.mainTitleLabel.text = @"标签";
            cell.subLabel.text = @"旅游、户外、美食";
            cell.showBottomLine = YES;
            return cell;
        } else {
            
            QYPersonalDataCell * cell = [QYPersonalDataCell loadCellInTableView:tableView cellType:QYPersonalDataCellLabel];
            cell.mainTitleLabel.text = @"个性签名";
            cell.subLabel.text = @"勤奋会带来好运";
            cell.showBottomLine = YES;
            return cell;
        }
        
    }
      else {
        
        NSArray * mainTitles = @[@"手机号",@"毕业/在读院校",@"所在地",@"家乡",@"职业"];
        NSArray * subLabels = @[@"15521337313",@"广东工业大学",@"广州",@"阳春",@"学生"];
        
        QYPersonalDataCell * cell = [QYPersonalDataCell loadCellInTableView:tableView cellType:QYPersonalDataCellLabel];
        cell.showBottomLine = YES;
        NSString * mainTitle = mainTitles[indexPath.row];
        NSString * subLabel = subLabels[indexPath.row];
        cell.mainTitleLabel.text = mainTitle;
        cell.subLabel.text = subLabel;
        return cell;
    }
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
