//
//  QYHomeTabBarViewController.m
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYHomeTabBarViewController.h"
#import "QYNavigationController.h"
#import "QYReadMapController.h"
#import "QYReadCycleController.h"
#import "QYReadMeController.h"
#import "UIColor+QYHexStringColor.h"
#import "QYTabBarControlerDelegate.h"
#import "QYSliderTabBarIntercativeTransiton.h"
#import "QYPersonalDataViewController.h"
#import "QYReadMeController.h"
#import "QYChatkExample.h"
#import "MBProgressHUD+LLHud.h"
#import "define.h"
#import "CTLocationManager.h"

@interface QYHomeTabBarViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) QYReadCycleController *readCycleController;
@property (nonatomic, strong) QYReadMapController *readMapController;
@property (nonatomic, strong) QYReadMeController *readMeController;
@property (nonatomic, strong) QYTabBarControlerDelegate *tabBarDelegate;
@property (nonatomic, strong) QYSliderTabBarIntercativeTransiton *trasitonControll;

@end

@implementation QYHomeTabBarViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CTLocationManager sharedInstance] startLocation];
    [self addNotifation];
    [self loginLCIM];
    [self addChildController:self.readMapController image:[UIImage imageNamed:@"read_map_normal"] selectImage:[UIImage imageNamed:@"read_map_selected"] title:@"阅图" needNavc:YES];
    [self addChildController:self.readCycleController image:[UIImage imageNamed:@"read_circle_normal"] selectImage:[UIImage imageNamed:@"read_circle_selected"] title:@"阅圈" needNavc:YES];
//    [self addChildController:self.readMeController image:[UIImage imageNamed:@"me_normal"] selectImage:[UIImage imageNamed:@"me_selected"] title:@"我的" needNavc:YES];
    
    /**
     *  测试把QYPersonalDataViewController添加到HomeTabBarController
    **/
    [self addChildController:self.readMeController image:[UIImage imageNamed:@"me_normal"] selectImage:[UIImage imageNamed:@"me_selected"] title:@"我的" needNavc:YES];
    
    
//    self.delegate = self.tabBarDelegate;
//    QYSliderTabBarIntercativeTransiton *tabBar = [[QYSliderTabBarIntercativeTransiton alloc] init];
//    [tabBar fireToTabBarController:self];
//    self.tabBarDelegate.tabBar = tabBar;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [self removeNotifation];
    MyLog(@"dealloc:%@",[self class]);
}
#pragma mark - Private method

- (void)addNotifation {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationServiceError:) name:kLocationServiceStatusErrorNotifation object:nil];
}

- (void)removeNotifation {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)locationServiceError:(NSNotification *)info {
    
    [UIAlertController alertControler:@"提示" leftTitle:@"取消" rightTitle:@"去设置" from:self action:^(NSUInteger index) {
        
        if (index == 1) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
        }
    }];
}


-(void)addChildController:(UIViewController *)controller image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title needNavc:(BOOL)needNavc{
    
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#555555"],NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#52CAC1"],NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateSelected];
    if (needNavc) {
        
        QYNavigationController *navc = [[QYNavigationController alloc] initWithRootViewController:controller];
        [self addChildViewController:navc];
    } else
        [self addChildViewController:controller];
    
}

- (void)loginLCIM {
    
    QYUser *current = [CTAppContext sharedInstance].currentUser;
    NSString *usid = [NSString stringWithFormat:@"%@",current.uid];
    [QYChatkExample invokeThisMethodAfterLoginSuccessWithClientId:usid success:^{
        
        MyLog(@"login im success");
        [QYChatkExample test];
        
    } failed:^(NSError *error) {
        
        [MBProgressHUD showMessageAutoHide:@"登录失败" view:nil];
        
    }];

}
#pragma mark - Setters and getters

-(QYReadMapController *)readMapController {
    
    if (!_readMapController) {
        
        _readMapController = [[QYReadMapController alloc] init];
    }
    return _readMapController;
}
-(QYReadCycleController *)readCycleController {
    
    if (!_readCycleController) {
        
        _readCycleController = [[QYReadCycleController alloc] init];
    }
    return _readCycleController;
}
-(QYReadMeController *)readMeController {
    
    if (!_readMeController) {
        
        _readMeController = [[QYReadMeController alloc] init];
    }
    return _readMeController;
}
-(QYTabBarControlerDelegate *)tabBarDelegate {
    
    if (!_tabBarDelegate) {
        
        _tabBarDelegate = [[QYTabBarControlerDelegate alloc] init];
    }
    return _tabBarDelegate;
}
-(QYSliderTabBarIntercativeTransiton *)trasitonControll {
    
    if (!_trasitonControll) {
        
        _trasitonControll = [[QYSliderTabBarIntercativeTransiton alloc] init];
    }
    return _trasitonControll;
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
