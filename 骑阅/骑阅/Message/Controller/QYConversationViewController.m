//
//  QYConversationViewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/2.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYConversationViewController.h"
#import "QYChatBar.h"
#import "QYReadLookUserController.h"
#import "define.h"

@interface QYConversationViewController ()

@end

@implementation QYConversationViewController

@synthesize chatBar;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self configLeftItem];
}

#pragma mark - private method
- (void)configLeftItem {
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Placeholder_Avatar"] style:UIBarButtonItemStyleDone target:self action:@selector(clickRightItem:)];
    //self.navigationItem.rightBarButtonItem = right;
}

#pragma mark - target action

- (void)clickRightItem:(UIBarButtonItem *)sender {
    
    QYReadLookUserController *look = [[QYReadLookUserController alloc] init];
    look.user = @{kuid:@(self.peerId.integerValue)}.mutableCopy;
    [self.navigationController pushViewController:look animated:YES];
}
#pragma mark - getter
- (LCCKChatBar *)chatBar {
    if (!chatBar) {
        QYChatBar *bar = [[QYChatBar alloc] init];
        [self.view addSubview:(chatBar = bar)];
        [self.view bringSubviewToFront:chatBar];
    }
    return chatBar;
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
