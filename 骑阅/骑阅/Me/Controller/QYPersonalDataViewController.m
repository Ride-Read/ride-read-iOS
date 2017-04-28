//
//  QYPersonalDataViewController.m
//  骑阅
//
//  Created by 谢升阳 on 2017/3/7.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPersonalDataViewController.h"
#import "UIColor+QYHexStringColor.h"
#import "UIBarButtonItem+CreatUIBarButtonItem.h"
#import "define.h"
#import "QYPersonalDataCell.h"
#import "QYTextPromptView.h"
#import "QYTagPromptView.h"
#import "QYUpdateAPIManager.h"
#import "QYTakePhotoViewController.h"
#import "QYPersonSexSelectView.h"
#import "YYPopView.h"
#import "NSString+QYDateString.h"
#import "QYSelecteLocationViewController.h"

@interface QYPersonalDataViewController ()<UITableViewDataSource,UITableViewDelegate,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,QYSelectedLoactionDelegate>

/** tableView */
@property(nonatomic,strong) UITableView * tableView;
/** UpdatAPIManager */
@property(nonatomic,strong) QYUpdateAPIManager * updateAPIManager;
/** headImage */
@property(nonatomic,strong) UIImage * headImage;

@end

@implementation QYPersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavc];
    [self setupTableView];
}

- (void)setNavc {
    
    self.navigationItem.title = @"编辑资料";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#52CAC1"];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#52CAC1"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIBarButtonItem *saveButton = [UIBarButtonItem creatItemWithImage:nil highLightImage:nil title:@"保存" target:self action:@selector(clickSaveButton:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}
- (void) clickSaveButton:(UIButton *) sender {
    
    NSLog(@"%s",__func__);
    [self.updateAPIManager loadData];
    
    
}
- (void) setupTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 49, 0);
    self.tableView.sectionHeaderHeight = 2;
    self.tableView.sectionFooterHeight = 2;
    [self.tableView registerClass:[QYPersonalDataCell class] forCellReuseIdentifier:@"QYPersonalDataCell"];
    [self.view addSubview:self.tableView];
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if (manager == self.updateAPIManager) {
        MyLog(@"failed");
    }
}
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (manager == self.updateAPIManager) {
        MyLog(@"success");
    }

}


#pragma mark - private method
- (void)crateCustomTag:(NSString *)title plcaeHodel:(NSString *)placeHodel maxLength:(NSInteger)maxLength cell:(QYPersonalDataCell *)cell{
    
    QYTextPromptView * nameView = [QYTextPromptView creatView];
    nameView.placeHolder = placeHodel;
    nameView.title = title;
    nameView.maxLength = maxLength;
    [nameView show];
    [nameView ConfigClickWithBlock:^(NSString * targetString) {
        
        if ([placeHodel isEqualToString:@"我的个性签名"]) {
         
            self.user.signature = targetString;
        }
        
        if ([placeHodel isEqualToString:@"不要超过五个字哦!"]) {
            
            self.user.tagString = targetString;
        }
        
        if ([placeHodel isEqualToString:@"建议使用真实姓名"]) {
            
            self.user.username = targetString;
            
        }
        if ([placeHodel isEqualToString:@"学校"]) {
            
            self.user.school = targetString;
            
        }
        cell.subLabel.text = targetString;
       
    }];
}

#pragma -- <QYSelectedLoactionDelegate>
- (void)viewController:(QYSelecteLocationViewController *)controller didFinishedSelectedAddress:(NSString *)address {
    self.user.location = address;
    [self.tableView reloadData];
}



#pragma -- <UITableViewDataSource>
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 7;
    } else {
        return 0;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row ==0) {
        return 80.0;
    } else {
        return 55.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYPersonalDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QYPersonalDataCell"];

    if (indexPath.section == 0) {
        
        NSArray * data = @[@"头像",@"昵称"];
        cell.mainTitleLabel.text = data[indexPath.row];
        if (indexPath.row == 0) {
            
            cell.cellType = QYPersonalDataCellImageView;
            [cell.subImageView sd_setImageWithURL:[NSURL URLWithString:self.user.face_url ] placeholderImage:[UIImage imageNamed:@"meizi2.png"]];
            
        } else {
            
            cell.cellType = QYPersonalDataCellLabel;
            cell.subLabel.text = self.user.username;
            
        }
    } else if (indexPath.section == 1) {
        
        cell.cellType = QYPersonalDataCellLabel;
        NSArray * data = @[@"性别",@"标签",@"个性签名"];
        cell.mainTitleLabel.text = data[indexPath.row];
        if (indexPath.row == 0) {

            NSString *sexStr = @"女";
            if (self.user.sex.integerValue == 1) {
                
                sexStr = @"男";
            }
            cell.subLabel.text = [NSString stringWithFormat:@"%@",sexStr];
            
        } else if (indexPath.row == 1) {

            cell.subLabel.text = self.user.tagString;
            
        } else {
            
            cell.subLabel.text = self.user.signature;
            
        }
    } else if (indexPath.section == 2) {
        
        cell.cellType = QYPersonalDataCellLabel;
        NSArray * data = @[@"生日",@"手机号",@"毕业/在读学校",@"所在地",@"家乡",@"职业",@"骑阅号"];
        cell.mainTitleLabel.text = data[indexPath.row];
        
        if (indexPath.row == 0) {
            
            NSString *ageStr = [NSString dataFormatteryyyymmdd:[NSDate dateWithTimeIntervalSince1970:self.user.birthday.doubleValue/1000]];
            cell.subLabel.text = ageStr;
        }
        if (indexPath.row == 1) {
            
            cell.subLabel.text = self.user.phonenumber;
        }
        
        if (indexPath.row == 2) {
            
            cell.subLabel.text = self.user.school;
        }
        
        if (indexPath.row == 3) {
            
            cell.subLabel.text = self.user.location;
        }
        
        if (indexPath.row == 4) {
            
            cell.subLabel.text = self.user.hometown;
        }
        
        if (indexPath.row == 5) {
            
            cell.subLabel.text = self.user.career;
        }
        
        if (indexPath.row == 6) {
            
            cell.subLabel.text = self.user.ride_read_id;
        }
        
    } else  {
        return nil;
    }
    return cell;
}
#pragma -- <UITaleViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYPersonalDataCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            
            [self crateCustomTag:@"昵称" plcaeHodel:@"建议使用真实姓名" maxLength:0 cell:cell] ;
            
        } else {
            
            QYTakePhotoViewController * takeVC = [[QYTakePhotoViewController alloc]init];
            takeVC.user = self.user;
            takeVC.callBackIcon = ^(UIImage *icon,NSString *url) {
              
                self.user.face_url = url;
                cell.subImageView.image = icon;
            };
            [self.navigationController pushViewController:takeVC animated:YES];
            
        }
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            QYPersonSexSelectView *sexView = [QYPersonSexSelectView loadPersonSexView:self.user block:^(NSString *sex){
                
                cell.subLabel.text = sex;
            }];
            [sexView show];
            
        }
        
        if (indexPath.row == 1) {
            
            QYTagPromptView * tagView = [QYTagPromptView tagView:^(UIView *view){
                
               __weak QYTagPromptView *prom = (QYTagPromptView *)view;
                [prom closeView];
                [self crateCustomTag:@"个性标签" plcaeHodel:@"不要超过五个字哦!" maxLength:5 cell:cell] ;
                
            } clickConfirm:^(NSString *tags) {
                
                cell.subLabel.text = tags;
                self.user.tagString = tags;
            }];
            tagView.usr = self.user;
            tagView.title = @"标签";
            [tagView show];
            
        } else if (indexPath.row == 2) {
            
            [self crateCustomTag:@"个性签名" plcaeHodel:@"我的个性签名" maxLength:0 cell:cell];
        }
    } else {
        
        if (indexPath.row == 0) {
            
            YYPopView *ageView = [YYPopView popViewUser:self.user handler:^(NSString *age) {
               
                cell.subLabel.text = age;
            }];
            [ageView show];
        }
        if (indexPath.row == 2) {
            
            [self crateCustomTag:@"毕业/在读学校" plcaeHodel:@"学校" maxLength:0 cell:cell];

        }  if (indexPath.row == 3 || indexPath.row == 4) {
            QYSelecteLocationViewController * selecteLocation = [[QYSelecteLocationViewController alloc]init];
            selecteLocation.delegate = self;
            [self.navigationController pushViewController:selecteLocation animated:YES];
        }
        
        
    }
}


#pragma -- <CTAPIManagerParamSource>
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.updateAPIManager) {
        
        NSArray  * tags = @[@"学生",@"代码大神",@"月薪过万"];
        NSString * hometown = @"阳春";
        NSString * birthday = @"1992.02.18";
        NSNumber * uid = self.user.uid;
        NSString * school = @"关公";
        NSString * signature = @"个性其阿明";
        NSString * phonenumber = self.user.phonenumber;
        NSNumber * sex = self.user.sex;
        NSString * career = @"学生";
        NSString * location = @"广州";
        NSString * nickname = @"升阳";
        NSString * face_url = @"http://attach.bbs.miui.com/forum/201703/30/154935wkwmkllupipzwmuz.jpg";
        
        return @{khometown:hometown?:@"",
                 kbirthday:birthday?:@"",
                 klatitude:@(self.location.coordinate.latitude),
                 klongitude:@(self.location.coordinate.longitude),
                 kuid:uid?:@"",
                 kschool:school?:@"",
                 ksignature:signature?:@"",
                 ksex:sex?:@(0),
                 kphonenumber:phonenumber?:@"",
                 kcareer:career?:@"",
                 ktags:tags?:@[],
                 knickname:nickname?:@"",
                 kface_url:face_url?:@"",
                 klocation:location?:@""};
        
    }
    return nil;
}


#pragma -- <setter and getter>
- (QYUpdateAPIManager *)updateAPIManager {
    
    if (!_updateAPIManager) {
        _updateAPIManager = [[QYUpdateAPIManager alloc]init];
        _updateAPIManager.paramSource = self;
        _updateAPIManager.delegate = self;
    }
    return _updateAPIManager;
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
