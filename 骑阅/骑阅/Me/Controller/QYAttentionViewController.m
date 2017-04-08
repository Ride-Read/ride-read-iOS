//
//  QYAttentionViewController.m
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAttentionViewController.h"
#import "define.h"
#import "QYLookAttentionViewController.h"

@interface QYAttentionViewController ()

@end

@implementation QYAttentionViewController

@synthesize userApiManager;
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYLookAttentionViewController *look = [[QYLookAttentionViewController alloc] init];
    NSMutableDictionary *info = self.userArrays[indexPath.row];
    look.user = info;
    [self.navigationController pushViewController:look animated:YES];
    
}


#pragma mark - life cycle

- (NSDictionary *)paramForUserApi {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuid:uid?:@(-1)};
}

- (QYAttentionOrFansApiManager *)userApiManager {
    
    if (!userApiManager) {
        
        userApiManager = [[QYFollowingApiManager alloc] init];
        userApiManager.delegate = self;
        userApiManager.paramSource = self;
    }
    return userApiManager;
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
