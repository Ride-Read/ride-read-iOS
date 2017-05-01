//
//  QYRideMyCycleController.m
//  骑阅
//
//  Created by chen liang on 2017/3/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRideMyCycleController.h"
#import "define.h"
#import "QYDeleteCirleApiManager.h"

@interface QYRideMyCycleController ()
@property (nonatomic, strong) NSIndexPath *deletePath;
@property (nonatomic, strong) QYDeleteCirleApiManager *deleteApi;

@end

@implementation QYRideMyCycleController

#pragma mark -life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.attentionAndMessageView.hidden = YES;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"我的阅圈";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    
    if (manager == self.deleteApi) {
   
        QYFriendCycleCellLayout *layout = self.layoutArray[self.deletePath.row];
        NSNumber *mid = layout.status[kmid];
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        return @{kmid:mid?:@(-1),kuid:uid?:@(-1)};
        
    } else {
        
        return [super paramsForApi:manager];
    }
}


- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    [super managerCallAPIDidSuccess:manager];
    
    if (manager == self.deleteApi) {
      
        [MBProgressHUD showMessageAutoHide:@"删除成功" view:nil];
        [self.layoutArray removeObjectAtIndex:self.deletePath.row];
        self.numberView.data = self.layoutArray;
        [self.tableView deleteRowsAtIndexPaths:@[self.deletePath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    [super managerCallAPIDidFailed:manager];
    
    if (manager == self.deleteApi) {
        
        [MBProgressHUD showMessageAutoHide:@"删除失败" view:nil];
    }
}
#pragma mark - tableView delegate


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        self.hud = [MBProgressHUD showMessage:@"删除中..." toView:nil];
        self.tableView.editing = NO;
        self.deletePath = indexPath;
        [self.deleteApi loadData];

    }
}

#pragma mark - publice method

- (void)setContentView {
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

- (void)loadData {
    
    [self.serialQueue addOperationWithBlock:^{
       
        [self.cycleApiManager loadData];
    }];
}

//not need refresh user data rewrite super method do nothing
- (void)customView:(UIView *)customView refresh:(id)data {
    
    
}

#pragma mark - setter and getter

- (QYReadMeHeaderView *)headerView {
    
    return nil;
}

- (NSMutableDictionary *)user {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuid:uid}.mutableCopy;
}

- (QYDeleteCirleApiManager *)deleteApi {
    
    if (!_deleteApi) {
        
        _deleteApi = [[QYDeleteCirleApiManager alloc] init];
        _deleteApi.paramSource = self;
        _deleteApi.delegate = self;
    }
    return _deleteApi;
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
