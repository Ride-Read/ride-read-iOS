//
//  QYReadMapController.m
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYReadMapController.h"
#import "UIBarButtonItem+CreatUIBarButtonItem.h"

@interface QYReadMapController ()

@end

@implementation QYReadMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    /** test */
//    UIBarButtonItem * right = [UIBarButtonItem creatItemWithImage:@"read_map_normal" highLightImage:@"read_map_selected" target:self action:@selector(clickItem)];
//    self.navigationItem.rightBarButtonItem = right;
}

/** test */
- (void)clickItem {
    NSLog(@"%s",__func__);
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
