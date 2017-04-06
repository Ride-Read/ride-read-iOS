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

@interface QYTakePhotoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** headImageView */
@property(nonatomic,strong) UIImageView * headImageView;
/** pickVC */
@property(nonatomic,strong) UIImagePickerController * pickerController;


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
    
    self.headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"meizi2.png"]];
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
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    NSLog(@"--->%@",mediaType);
    
    UIImage * image;
    if (self.pickerController.allowsEditing) {//如果是拍照
//        NSLog(@"%s",__func__);
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    self.headImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
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
