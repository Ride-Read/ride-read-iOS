//
//  QYFriendCycleDetailController.m
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYFriendCycleDetailController.h"
#import "QYCircleViewCell.h"
#include "YYBasicTableView.h"
#import "define.h"
#import "QYCommpentCellLayout.h"
#import "QYCommentViewCell.h"
#import "QYCommentSectionView.h"
#import "QYSendCommentView.h"
#import "QYHomeTabBarViewController.h"
#import "UIBarButtonItem+CreatUIBarButtonItem.h"
#import "QYButtonSheetPromptView.h"
#import "UIColor+QYHexStringColor.h"
#import "QYCyclePostController.h"
#import "QYDetailCycleLayout.h"

@interface QYFriendCycleDetailController ()<UITableViewDelegate,UITableViewDataSource,YYBaseicTableViewRefeshDelegate,QYFriendCycleDelegate,QYSendCommentViewDelegate,QYCommentViewCellDelegate>
@property (nonatomic, strong) QYCircleViewCell *cell;
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) NSMutableArray *layoutArray;
@property (nonatomic, strong) QYCommentSectionView *sectionView;
@property (nonatomic, strong) QYSendCommentView *sendView;

@end

@implementation QYFriendCycleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    [self analyseData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self addNotifaction];
    [self setNavc];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self removeNotifation];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    MyLog(@"%@",[self class]);
}
#pragma mark- private method 

- (void)addNotifaction {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeNotifation {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (void)setNavc {
    
    self.title = @"详情";
    UIBarButtonItem *rightItem = [UIBarButtonItem creatItemWithImage:@"navigation_more" highLightImage:nil title:nil target:self action:@selector(clcikRightItem:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sendView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.mas_equalTo(0);
        make.bottom.equalTo(self.sendView.mas_top);
    }];
    [self.sendView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)analyseData {
    
    [self.serialQueue addOperationWithBlock:^{
       
        NSArray *array = self.layout.status[kcomment];
        for (NSDictionary *comment in array) {
            
            QYCommpentCellLayout *layout = [QYCommpentCellLayout commentLayout:comment];
            [self.layoutArray addObject:layout];
        }
        if (self.layoutArray.count > 0) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
                [self.tableView reloadData];
            }];
        }
    }];
}

#pragma mark - traget action

- (void)keyBoardShow:(NSNotification *)info {
    // 动画时长
    CGFloat duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger option = [info.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    // 键盘高度
    CGFloat keyboardH = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self.sendView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-keyboardH);
        make.height.mas_equalTo(50);
    }];
    [UIView animateKeyframesWithDuration:duration delay:0 options:option animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:nil];
    
}

- (void)keyBoardHide:(NSNotification *)info {
    
    // 动画时长
    CGFloat duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger option = [info.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    // 键盘高度
    [self.sendView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    [UIView animateKeyframesWithDuration:duration delay:0 options:option animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:nil];
}

- (void)clcikRightItem:(UIBarButtonItem *)sender {
    
    QYButtonSheetPromptView *prompt = [QYButtonSheetPromptView promptWithButtonTitles:@[@"分享",@"收藏"] action:^(UIButton *button) {
        
//        QYCyclePostController *post = [[QYCyclePostController alloc] init];
//        [self.navigationController pushViewController:post animated:YES];
    }];
    [prompt show];
}
#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.layoutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYCommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    if (!cell) {
        
        cell = [[QYCommentViewCell alloc] init];
    }
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYCommentViewCell *commentCell = (QYCommentViewCell *)cell;
    QYCommpentCellLayout *layout = self.layoutArray[indexPath.row];
    commentCell.layout = layout;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.sectionView;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYCommpentCellLayout *layout = self.layoutArray[indexPath.row];
    return layout.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 43;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYCommpentCellLayout *layout = self.layoutArray[indexPath.row];
    self.sendView.info = layout.status;
}

#pragma mark - commentCellDeleagte

//点击回复者用户信息
- (void)commentCell:(QYCommentViewCell *)cell data:(NSDictionary *)data {
    
    self.sendView.info = data[kreply];

}

#pragma mark - sendView delegate

- (void)sendView:(QYSendCommentView *)view acitonSuccess:(NSMutableDictionary *)info {
    
    self.layout = [QYDetailCycleLayout friendStatusCellLayout:info];
    self.cell.layout = self.layout;
    [self.layoutArray removeAllObjects];
    [self analyseData];
    self.sectionView.data = info[kcomment];
    self.refresh();
}

#pragma mark - setter and getter
- (QYCircleViewCell *)cell {
    
    if (!_cell) {
        _cell = [[QYCircleViewCell alloc] initWithCycleType:QYFriendCycleTypedetail];
        _cell.layout = self.layout;
        _cell.delegate = self;
        _cell.frame = CGRectMake(0, 0, kScreenWidth,self.layout.height + 55);
    }
    return _cell;
}

- (YYBasicTableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[YYBasicTableView alloc] initWithRefeshSytle:YYTableViewRefeshStyleDefault];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.refesh = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.cell;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //_tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    }
    return _tableView;
}

- (QYCommentSectionView *)sectionView {
    
    if (!_sectionView) {
        _sectionView = [[QYCommentSectionView alloc] init];
        NSArray *array = _layout.status[kcomment];
        NSString *numberString;
        if (array.count > 0) {
            
            numberString = [NSString stringWithFormat:@"评论  %ld",array.count];
        } else
            numberString = @"评论";
        _sectionView.commentNumber.text = numberString;
    }
    return _sectionView;
}
- (QYSendCommentView *)sendView {
    
    if (!_sendView) {
        
        _sendView = [[QYSendCommentView alloc] init];
        _sendView.status = self.layout.status;
        _sendView.delegate = self;
    }
    return _sendView;
}

- (NSMutableArray *)layoutArray {
    
    if (!_layoutArray) {
        _layoutArray = [NSMutableArray array];
    }
    return _layoutArray;
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
