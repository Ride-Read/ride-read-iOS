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

@interface QYHomeTabBarViewController ()
@property (nonatomic, strong) QYReadCycleController *readCycleController;
@property (nonatomic, strong) QYReadMapController *readMapController;
@property (nonatomic, strong) QYReadMeController *readMeController;

@end

@implementation QYHomeTabBarViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildController:self.readMapController image:[UIImage imageNamed:@""] selectImage:[UIImage imageNamed:@""] title:@"阅图" needNavc:YES];
    [self addChildController:self.readCycleController image:[UIImage imageNamed:@""] selectImage:[UIImage imageNamed:@""] title:@"阅圈" needNavc:YES];
    [self addChildController:self.readMeController image:[UIImage imageNamed:@""] selectImage:[UIImage imageNamed:@""] title:@"我的" needNavc:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private method
-(void)addChildController:(UIViewController *)controller image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title needNavc:(BOOL)needNavc{
    
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = image;
    controller.tabBarItem.selectedImage = selectImage;
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#C1C0C0"]} forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#52CAC1"]} forState:UIControlStateSelected];
    if (needNavc) {
        
        QYNavigationController *navc = [[QYNavigationController alloc] initWithRootViewController:controller];
        [self addChildViewController:navc];
    } else
        [self addChildViewController:controller];
    
}

#pragma mark - Setters and getters
-(QYReadCycleController *)readCycleController {
    
    if (!_readCycleController) {
        
        _readCycleController = [[QYReadCycleController alloc] init];
    }
    return _readCycleController;
}
-(QYReadMapController *)readMapController {
    
    if (!_readMapController) {
        
        _readMapController = [[QYReadMapController alloc] init];
    }
    return _readMapController;
}
-(QYReadMeController *)readMeController {
    
    if (!_readMeController) {
        
        _readMeController = [[QYReadMeController alloc] init];
    }
    return _readMeController;
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
