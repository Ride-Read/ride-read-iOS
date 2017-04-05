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
    NSDictionary *info = self.userArrays[indexPath.row];
    QYUser *user = info[kdata];
    look.user = user;
    [self.navigationController pushViewController:look animated:YES];
    
}


#pragma mark - life cycle

- (NSDictionary *)paramForUserApi {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{ktype:@(0),kuid:uid?:@(-1)};
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
