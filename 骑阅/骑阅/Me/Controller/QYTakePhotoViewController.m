//
//  QYTakePhotoViewController.m
//  骑阅
//
//  Created by 谢升阳 on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTakePhotoViewController.h"
#import <Masonry/Masonry.h>
#import "UIBarButtonItem+CreatUIBarButtonItem.h"
#import "QYSelectView.h"
#import "QYQiuniuTokenCommand.h"
#import "define.h"
#import "QYNavigationController.h"
#import "NSString+QYDateString.h"
#import "MBProgressHUD+LLHud.h"

@interface QYTakePhotoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLCommandDataSource,CLCommandDelegate>

/** headImageView */
@property(nonatomic,strong) UIImageView * headImageView;
/** pickVC */
@property(nonatomic,strong) UIImagePickerController * pickerController;
/** QYQiuniuTokenCommand */
@property (nonatomic, strong) QYQiuniuTokenCommand * commad;
/** filename */
@property(nonatomic,strong) NSString * filename;

@end

@implementation QYTakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self setupUI];
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"个人头像";
    UIBarButtonItem * more = [UIBarButtonItem creatItemWithImage:@"navigation_more" highLightImage:@"navigation_more" title:nil target:self action:@selector(moreBottonClick:)];
    self.navigationItem.rightBarButtonItem = more;

}

- (void)setupUI {
    
    NSLog(@" self.user.face_url --== %@",self.user.face_url);
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.user.face_url] placeholderImage:[UIImage imageNamed:@"meizi2.png"]];
    [self.view addSubview:self.headImageView];
    self.headImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
//    [self.headImageView addGestureRecognizer:tap];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.headImageView.mas_width).multipliedBy(1.0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        
    }];
}

- (void)moreBottonClick:(UIButton *)sender {
    
    
    NSArray *array = @[
                       [QYSelectModel QYSelectModelWithTitle:@"拍照" titleColor:nil],
                       [QYSelectModel QYSelectModelWithTitle:@"相册" titleColor:nil],
                       [QYSelectModel QYSelectModelWithTitle:@"录像" titleColor:nil],
                       [QYSelectModel QYSelectModelWithTitle:@"保存图片" titleColor:nil],
                       
                       ];
    
    
    [QYSelectView QY_showSelectViewWithTitle:nil cancelButttonTitle:@"取消" actionContent:array selectBlock:^(QYSelectView *selectView, NSInteger index, NSString *selectedTitle) {
        
        if (index == 0) {
            
            //判断设备是否支持摄像头
            if ( [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
                //调用摄像头
                self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
            } else {
                
                NSLog(@"该设备不支持摄像头");
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
//    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    NSLog(@"--->%@",mediaType);
    
    UIImage * image;
    if (self.pickerController.allowsEditing) {//如果是拍照
//        NSLog(@"%s",__func__);
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    self.headImageView.image = image;
    
    //上传图片

    WEAKSELF(_self);
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    
    self.commad.complete = ^(QNResponseInfo *info, NSString *key, NSDictionary *resp){
        
//        [_self.hud hide:YES];
        
        if (info.isOK) {
            
            NSLog(@"++++++>>上传成功%@",key);
//            [_self.rideInviteCodeView.icon.icon setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
//            _self.rideInviteCodeView.icon.title.hidden = YES;
//            _self.url = key;
            
        } else {
            
            [MBProgressHUD showMessageAutoHide:@"上传失败" view:nil];
            
        }
        MyLog(@"%@",info);
    };

    self.filename = [NSString uploadFilename];
    self.commad.nextParams = @{kdata:data,kfilename:self.filename};
    [self.commad execute];

    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CLCoommandDataSource
- (NSDictionary *)paramsForcommand:(CLCommands *)command {
    
    return @{kfilename:self.filename,ktoken:@"jsonsnow",@"uid":@"jsonsnow"};
    
}


#pragma -- <setter and getter>
- (UIImagePickerController *)pickerController{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.allowsEditing = YES; // 允许编辑
        _pickerController.delegate = self; //设置代理，检测操作
    }
    return _pickerController;
}

- (UIImageView *)headImageView {
    
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
    }
    return _headImageView;
}

- (QYQiuniuTokenCommand *)commad {
    
    if (!_commad) {
        
        _commad = [[QYQiuniuTokenCommand alloc] init];
        _commad.dataSource = self;
        _commad.delegate = self;
    }
    return _commad;
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
