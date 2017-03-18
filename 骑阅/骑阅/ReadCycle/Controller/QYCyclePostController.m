//
//  QYCyclePostController.m
//  骑阅
//
//  Created by chen liang on 2017/3/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCyclePostController.h"
#import "UIButton+QYTitleButton.h"
#import "define.h"
#import "QYCylePostMonentApiManager.h"

@interface QYCyclePostController ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYCylePostMonentApiManager *postApiManager;
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation QYCyclePostController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *text = [UIButton buttonTitle:@"发表文字" font:15 colco:[UIColor greenColor]];
    text.frame = CGRectMake(0, 64,kScreenWidth , 45);
    [text addTarget:self action:@selector(clickPostAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *image = [UIButton buttonTitle:@"发表图文" font:15 colco:[UIColor redColor]];
    image.frame = CGRectOffset(text.frame, 0, 64);
    image.tag = 1;
    [image addTarget:self action:@selector(clickPostAction:) forControlEvents:UIControlEventTouchUpInside];
    
   // UIButton *vido = [UIButton buttonTitle:@"发表视频" font:15 colco:[UIColor greenColor]];
    
    [self.view addSubview:text];
    [self.view addSubview:image];
    //[self.view addSubview:vido];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    return self.params;
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    
}

#pragma mark - target action

- (void)clickPostAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        NSString *msg = @"测试测试测试测试测试测试测试测试上厕所测试测试测试测试";
        self.params = @{kuid:uid,kmsg:msg};
        
    } else {
        
        int rand = arc4random() % 4;
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < rand; i ++) {
            [array addObject:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"];
        }
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        NSString *msg = @"测试测试测试测试测试测试测试测试上厕所测试测试测试测试";
        self.params = @{kuid:uid,kmsg:msg,kpictures_url:array};
    }
    [self.postApiManager loadData];
}

#pragma mark - getter and setter

- (QYCylePostMonentApiManager *)postApiManager {
    
    if (!_postApiManager) {
        
        _postApiManager = [[QYCylePostMonentApiManager alloc] init];
        _postApiManager.delegate = self;
        _postApiManager.paramSource = self;
    }
    return _postApiManager;
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
