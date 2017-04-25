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
#import "MBProgressHUD+LLHud.h"
#import "UIAlertController+QYQuickAlert.h"
#import "YYReplyView.h"
#import "QYQiuniuTokenCommand.h"
#import "QYSelectView.h"
#import "NSString+QYDateString.h"
#import "QYimageView.h"
#import "NSString+QYRegular.h"
#import "UIButton+QYTitleButton.h"
#import "QYLocationViewController.h"

@interface QYCyclePostController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,CLCommandDataSource,CLCommandDelegate>
@property (nonatomic, strong) QYCylePostMonentApiManager *postApiManager;
@property (weak, nonatomic) IBOutlet UIButton *check_button;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet YYReplyTextView *messageView;
@property (nonatomic,strong) UIImagePickerController * pickerController;
@property (nonatomic, strong) QYQiuniuTokenCommand *commad;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, weak) QYimageView *iamgeView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, weak) QYLocationViewController *locCtr;


@end

@implementation QYCyclePostController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.messageView.placeHolder = @"分享精彩时刻";
    self.scrollView.contentSize = CGSizeMake(100 * 9 + 200, 100);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self addNotifaction];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#555555"],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton *button = [UIButton buttonTitle:@"发送" font:16 colco:[UIColor whiteColor]];
    [button addTarget:self action:@selector(clickRightItem:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 50, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"post_send_bg"] forState:UIControlStateNormal];
    //button.layer.cornerRadius = 5.0;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
  
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self removeNotifation];
}

#pragma mark - private method
- (void)addNotifaction {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeNotifation {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark - traget action

- (void)keyBoardShow:(NSNotification *)info {
    // 动画时长
    CGFloat duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger option = [info.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    // 键盘高度
    CGFloat keyboardH = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-keyboardH);
        make.height.mas_equalTo(50);
    }];
    [UIView animateKeyframesWithDuration:duration delay:0 options:option animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:nil];
    
}

- (void)keyBoardHide:(NSNotification *)info {
    
    // 动画时长
    CGFloat duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger option = [info.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    // 键盘高度
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    [UIView animateKeyframesWithDuration:duration delay:0 options:option animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:nil];
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSArray *array = self.scrollView.subviews;
    NSMutableArray *urls = @[].mutableCopy;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[QYimageView class]]) {
            
            QYimageView *icon = (QYimageView *)obj;
            [urls addObject:icon.url];
        }
    }];
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    NSString *msg = self.messageView.lasteString;
    self.params = @{kmoment_location:self.check_button.selected?@"":self.locationLabel.text,kuid:uid,kmsg:msg,kpictures_url:urls,klatitude:@(self.location.coordinate.latitude),klongitude:@(self.location.coordinate.longitude)};
    
    return self.params;
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    [self.hud hide:YES];
    if (self.postResult) {
    
        NSMutableDictionary *info = @{}.mutableCopy;
        NSArray *pics = self.params[kpictures_url];
        NSInteger type = 0;
        if (pics.count > 0) {
            
            type = 1;
            info[kcover] = pics[0];
        }
        info[ktype] = @(type);
        self.postResult(info,nil);
        self.postResult = nil;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kPostCycleSuccessNotifation object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    [MBProgressHUD showMessageAutoHide:@"发表失败" view:nil];
    [self.hud hide:YES];
}

#pragma mark - target action

- (IBAction)clickLocationAction:(UIButton *)sender {
    
    
}
- (IBAction)clickImageView:(id)sender {
    
    [self.view endEditing:YES];
    if (self.iamgeView.count == 8) {
        
        [MBProgressHUD showMessageAutoHide:@"已经查过最大限制" view:nil];
        return;
    }
    NSArray *array = @[
                       [QYSelectModel QYSelectModelWithTitle:@"拍照" titleColor:nil],
                       [QYSelectModel QYSelectModelWithTitle:@"相册" titleColor:nil],
                       ];
    
    
    [QYSelectView QY_showSelectViewWithTitle:nil cancelButttonTitle:@"取消" actionContent:array selectBlock:^(QYSelectView *selectView, NSInteger index, NSString *selectedTitle) {
        
        if (index == 0) {
            
            //判断设备是否支持摄像头
            if ( [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
                //调用摄像头
                self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
            } else {
                
                MyLog(@"该设备不支持摄像头");
                return;
            }
            
        } else if (index == 1) {
            
            self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else if (index == 2){
            return ;
        }
        
        //        QYNavigationController * navc = [[QYNavigationController alloc]initWithRootViewController:self.pickerController];
        [self presentViewController:self.pickerController animated:YES completion:nil];
        //        [self.navigationController pushViewController:navc animated:YES];
    }];

}
- (IBAction)clickCheckAction:(id)sender {
    
//    UIButton *btn = (UIButton *)sender;
//    btn.selected = !btn.selected;
//    if (btn.selected) {
//        
//        self.locationLabel.text = @"不显示位置";
//    } else {
//        
//        self.locationLabel.text = self.site;
//    }
}
- (IBAction)clickLeftItem:(id)sender {
    
    
     [UIAlertController alertControler:nil message:@"您确定要退出编辑" leftTitle:@"取消" rightTitle:@"确定" from:self action:^(NSUInteger index) {
        
         if (index == 1) {
             
             if (self.postResult) {
                 
                 self.postResult(nil,nil);
                 self.postResult = nil;
             }
             [self dismissViewControllerAnimated:YES completion:nil];

         }
    }];
 
}
- (IBAction)clickRightItem:(id)sender {
    
    if (!self.messageView.lasteString) {
        
        [MBProgressHUD showMessageAutoHide:@"文字不能为空" view:nil];
        return;
    }
    BOOL space = [self.messageView.lasteString checkSpaceText];
    if (space) {
        
        [MBProgressHUD showMessageAutoHide:@"文字不能为空" view:nil];
    }
    self.hud = [MBProgressHUD showMessage:@"发表中" toView:nil];
    [self.postApiManager loadData];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage * image;
    if (self.pickerController.allowsEditing) {//如果是拍照
    
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    //上传图片
    
    WEAKSELF(_self);
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    self.hud  = [MBProgressHUD showMessage:@"上传中" toView:nil];
    _commad = [[QYQiuniuTokenCommand alloc] init];
    _commad.dataSource = self;
    _commad.delegate = self;
    self.commad.complete = ^(QNResponseInfo *info, NSString *key, NSDictionary *resp){
        
        [_self.hud hide:YES];
        if (info.isOK) {
            
            MyLog(@"++++++>>上传成功%@",key);
            QYimageView *icon = [[QYimageView alloc] init];
            icon.icon.image = image;
            icon.url = [Basic_Qiniu_URL stringByAppendingString:key];
            [_self.scrollView addSubview:icon];
            if (_self.iamgeView) {
                
                _self.iamgeView.next = icon;
                icon.last = _self.iamgeView;
                //icon.next = nil;
                _self.iamgeView = icon;
            } else {
                
                _self.iamgeView = icon;
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(15);
                    make.centerY.equalTo(_self.scrollView);
                    make.width.mas_equalTo(100);
                    make.height.equalTo(icon.mas_width);
                    
                }];
                
            }
            
        } else {
            
            [MBProgressHUD showMessageAutoHide:@"上传失败" view:nil];
            
        }
        MyLog(@"%@",info);
        _self.commad.complete = nil;
    };
    
    self.filename = [NSString uploadFilename];
    self.commad.nextParams = @{kdata:data,kfilename:self.filename};
    [self.commad execute];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CLCoommandDataSource
- (NSDictionary *)paramsForcommand:(CLCommands *)command {
    
    return @{kfilename:self.filename,ktoken:@"jsonsnow",@"uid":@(1)};
}

- (void)command:(CLCommands *)commands didSuccess:(CTAPIBaseManager *)apiManager {
    
    
}

- (void)command:(CLCommands *)commands didFaildWith:(CTAPIBaseManager *)apiManager {
    
    [self.hud hide:YES];
    [MBProgressHUD showMessageAutoHide:@"图片保存失败" view:nil];
}

#pragma mark - getter and setter

- (UIImagePickerController *)pickerController{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.allowsEditing = NO; // 允许编辑
        _pickerController.delegate = self; //设置代理，检测操作
    }
    return _pickerController;
}


- (QYCylePostMonentApiManager *)postApiManager {
    
    if (!_postApiManager) {
        
        _postApiManager = [[QYCylePostMonentApiManager alloc] init];
        _postApiManager.delegate = self;
        _postApiManager.paramSource = self;
    }
    return _postApiManager;
}
- (void)setLocation:(CLLocation *)location {
    
    [super setLocation:location];
    self.locCtr.location = location;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    QYLocationViewController *location = [segue destinationViewController];
    self.locCtr = location;
    location.location = self.location;
    location.handler = ^(NSInteger index,NSString *title) {
        
        if ([title isEqualToString:@""]) {
            
            self.locationLabel.text = @"不显示位置";
            self.check_button.selected = YES;
            return ;
        }
        self.locationLabel.text = title;
        self.check_button.selected = NO;
    };
}


@end
