//
//  QYPersonSexSelectView.m
//  骑阅
//
//  Created by chen liang on 2017/4/27.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPersonSexSelectView.h"

@interface QYPersonSexSelectView ()
@property (weak, nonatomic) IBOutlet UIImageView *manIcon;
@property (weak, nonatomic) IBOutlet UIImageView *femaleIcon;
@property (nonatomic, strong) NSNumber *sex;
@end
@implementation QYPersonSexSelectView

+ (instancetype)loadPersonSexView:(QYUser *)user block:(void (^)(NSString *))block{
    
    QYPersonSexSelectView *sexView = [[NSBundle mainBundle] loadNibNamed:@"QYPersonSexSelectView" owner:nil options:nil].firstObject;
    sexView.frame = CGRectMake(cl_caculation_x(30), cl_caculation_y(300), kScreenWidth-cl_caculation_x(60), cl_caculation_y(400));
    sexView.user = user;
    sexView.handler = block;
    sexView.layer.cornerRadius = 5;
    return sexView;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)setUser:(QYUser *)user {
    
    _user = user;
    if (self.user.sex.integerValue == 1) {
        
        [self layoutMale];
        
    } else {
        
        [self layoutFemale];
    }
}

- (void)layoutMale {
    
    self.manIcon.image = [UIImage imageNamed:@"current_location"];
    self.manIcon.layer.cornerRadius = 0;
    self.manIcon.layer.borderWidth = 0.0;
    self.femaleIcon.layer.cornerRadius = 10;
    self.femaleIcon.layer.borderColor = [UIColor grayColor].CGColor;
    self.femaleIcon.layer.borderWidth = 2.0;
    self.femaleIcon.image = nil;
    self.sex = @(1);
    
}

- (void)layoutFemale {
    
    self.femaleIcon.image = [UIImage imageNamed:@"current_location"];
    self.femaleIcon.layer.cornerRadius = 0;
    self.femaleIcon.layer.borderWidth = 0.0;
    self.manIcon.layer.cornerRadius = 10;
    self.manIcon.layer.borderColor = [UIColor grayColor].CGColor;
    self.manIcon.layer.borderWidth = 2.0;
    self.manIcon.image = nil;
    self.sex = @(2);

}
#pragma mark - target aciton
- (IBAction)clickMaleAction:(UIButton *)sender {
    
    [self layoutMale];
}
- (IBAction)clickFemaleAction:(id)sender {
    
    [self layoutFemale];
}

- (IBAction)clickConfirmAction:(UIButton *)sender {
    
    if (self.handler) {
        
        self.user.sex = self.sex;
        NSString *sexText = @"女";
        if (self.sex.integerValue == 1) {
            
            sexText = @"男";
        }
        self.handler(sexText);
    }
    
    [self closeView];
}

@end
