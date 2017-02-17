//
//  QYLoginOrRegisterFatherController.m
//  骑阅
//
//  Created by 亮 on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoginOrRegisterFatherController.h"
#import "QYLoginHeaderView.h"
#import "define.h"
#import "Masonry.h"
#import "QYOtherLoginView.h"
#import "QYLoginViewController.h"
#import "QYRegisterViewController.h"

@interface QYLoginOrRegisterFatherController ()<QYViewClickProtocol>
@property (nonatomic, strong) QYLoginHeaderView *headerView;
@property (nonatomic, strong) QYOtherLoginView *otherLoginView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) QYLoginViewController *logController;
@property (nonatomic, strong) QYRegisterViewController *registerController;

@end

@implementation QYLoginOrRegisterFatherController

#pragma makr - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.otherLoginView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(163);
    }];
    [self.otherLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_bottom);
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    [self createLogController];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private method
-(void)createLogController {
    
    self.logController = [[QYLoginViewController alloc] init];
    [self.logController willMoveToParentViewController:self];
    [self addChildViewController:self.logController];
    [self.view addSubview:self.logController.view];
    self.logController.view.frame = CGRectMake(0, 163, kScreenWidth, CGRectGetHeight(self.contentView.frame));
    [self.logController didMoveToParentViewController:self];

}
-(void)backCreateController {
    
    self.logController = [[QYLoginViewController alloc] init];
    [self.logController willMoveToParentViewController:self];
    [self addChildViewController:self.logController];
    [self.view addSubview:self.logController.view];
    self.logController.view.frame = CGRectMake(-kScreenWidth, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
    [UIView animateWithDuration:0.15 animations:^{
        
        self.logController.view.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
        
    } completion:nil];
    [self.logController didMoveToParentViewController:self];

}

-(void)removeLogControoler {
    
    [self.logController willMoveToParentViewController:nil];
    [self.logController removeFromParentViewController];
    [UIView animateWithDuration:0.15 animations:^{
        
        self.logController.view.frame = CGRectMake(-kScreenWidth, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
        
    } completion:nil];
    [self.logController.view removeFromSuperview];
    [self.logController didMoveToParentViewController:nil];
    self.logController = nil;
    
    
}

-(void)createRegisterController {
    
    
    self.registerController = [[QYRegisterViewController alloc] init];
    [self.registerController willMoveToParentViewController:self];
    [self addChildViewController:self.registerController];
    [self.view addSubview:self.registerController.view];
    self.registerController.view.frame = CGRectMake(kScreenWidth, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
    [UIView animateWithDuration:0.15 animations:^{
        
        self.registerController.view.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenWidth, CGRectGetHeight(self.contentView.frame));
        
    } completion:nil];
    [self.registerController didMoveToParentViewController:self];

}

-(void)removeRegisterController {
    
    
    [self.registerController willMoveToParentViewController:nil];
    [self.registerController removeFromParentViewController];
    [self.registerController.view removeFromSuperview];
    [self.registerController didMoveToParentViewController:nil];
    self.registerController = nil;
}

#pragma mark - QYViewClickProtocol
-(void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    if ([customView isKindOfClass:[QYLoginHeaderView class]]) {
      
         MyLog(@"click %ld",(long)index);
        if (index == 0) {
            
            [self removeRegisterController];
            [self backCreateController];
            
            return;
        }
        if (index == 1) {
            
            [self removeLogControoler];
            [self createRegisterController];
        }
        //self.transitioningDelegate = id;
        //self.modalPresentationStyle = UIModalPresentationCustom;
        return;
    }
    
    if ([customView isKindOfClass:[QYOtherLoginView class]]) {
        
         MyLog(@"click %ld",(long)index);
        return;
    }
   
}
#pragma makr - getters and setters
-(QYLoginHeaderView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[QYLoginHeaderView alloc] init];
        _headerView.delegate = self;
    }
    return _headerView;
}
-(UIView *)contentView {
    
    if (!_contentView) {
        
        _contentView = [[UIScrollView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        //_contentView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight - 163 -  cl_caculation_y(180));
        _contentView.frame = CGRectMake(0, 163, kScreenWidth, kScreenHeight - cl_caculation_y(180) - 163);
        //_contentView.showsHorizontalScrollIndicator = NO;
        //_contentView.showsVerticalScrollIndicator = NO;
    }
    return _contentView;
}

-(QYOtherLoginView *)otherLoginView {
    
    if (!_otherLoginView) {
        
        _otherLoginView = [[QYOtherLoginView alloc] init];
        _otherLoginView.delegate = self;
    }
    return _otherLoginView;
}


@end
