//
//  QYProfessionViewController.m
//  骑阅
//
//  Created by 谢升阳 on 2017/4/28.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYProfessionViewController.h"
#import "QYPersonalDataCell.h"

@interface QYProfessionViewController ()<UITableViewDelegate,UITableViewDataSource>
/** profession */
@property(nonatomic,copy) NSMutableArray * professions;
/** tableView */
@property(nonatomic,strong) UITableView * tableView;
@end

@implementation QYProfessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"职业";
    [self setupTableView];
}

- (void)setupTableView {
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = self.view.frame;
    [self.tableView registerClass:[QYPersonalDataCell class] forCellReuseIdentifier:@"QYPersonalDataCell"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.professions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYPersonalDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QYPersonalDataCell"];
    cell.cellType = QYPersonalDataCellDefault;
    cell.mainTitleLabel.text = self.professions[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * pro = self.professions[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didFinishSelectedProfession:)]) {
        [self.delegate viewController:self didFinishSelectedProfession:pro];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma -- <setter and getter>
- (NSMutableArray *)professions {
    if (_professions == nil) {
        NSArray * pro = @[@"学生",
                          @"IT/互联网/通信",
                          @"媒体/公关",
                          @"法律",
                          @"金融",
                          @"咨询",
                          @"文化/艺术",
                          @"影视/娱乐",
                          @"医药/健康",
                          @"房地产/建筑",
                          @"教育/科研",
                          @"能源/环保",
                          @"政府机构",
                          @"其他",];
        _professions = [NSMutableArray arrayWithArray:pro];
    }
    return _professions;
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
