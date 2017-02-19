//
//  QYRegisterViewController.m
//  骑阅
//
//  Created by 亮 on 2017/2/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRegisterViewController.h"
#import "define.h"
#import "QYRegisterView.h"

@interface QYRegisterViewController ()<QYViewClickProtocol>
@property (nonatomic, strong) QYRegisterView *registerView;

@end

@implementation QYRegisterViewController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.registerView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.registerView.frame = self.view.bounds;
}
-(void)dealloc {
    
    MyLog(@"dealloc:%@",[self class]);
}
#pragma mark - QYCustomClickDelegate

-(void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    if ([customView isKindOfClass:[QYRegisterView class]]) {
        
        if (index == 0) {
            MyLog(@"click next setup");
            return;
        }
        if (index == 1) {
            
            MyLog(@"click protocol");
            return;
        }
    }
}

#pragma mark - Targart action

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark - setters and getters

-(QYRegisterView *)registerView {
    
    if (!_registerView) {
        
        _registerView = [[QYRegisterView alloc] init];
        _registerView.delegate = self;
        
    }
    return _registerView;
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
