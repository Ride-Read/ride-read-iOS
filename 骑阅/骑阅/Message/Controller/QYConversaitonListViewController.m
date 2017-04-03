//
//  QYConversaitonListViewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/2.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYConversaitonListViewController.h"
#import "QYChatkExample.h"
#import "QYConversationViewController.h"

@interface QYConversaitonListViewController ()

@end

@implementation QYConversaitonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LCChatKit sharedInstance] setDidSelectConversationsListCellBlock:^(NSIndexPath *indexPath, AVIMConversation *conversation, LCCKConversationListViewController *controller) {
        NSLog(@"conversation selected");
        QYConversationViewController *conversationVC = [[QYConversationViewController alloc] initWithConversationId:conversation.conversationId];
        [controller.navigationController pushViewController:conversationVC animated:YES];    }];
    // Do any additional setup after loading the view.
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
