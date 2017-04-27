//
//  YYPopView.m
//  优悦一族
//
//  Created by 蒋永忠 on 16/4/6.
//  Copyright © 2016年 umed. All rights reserved.
//
#define ScreenSize [UIScreen mainScreen].bounds.size
#define MarginL 30
#define Height 50
#define Width ScreenSize.width - MarginL * 2
#import "YYPopView.h"
#import "define.h"
#import "NSString+QYDateString.h"

@interface YYPopView()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *nickNameView;
@property (nonatomic, strong) UIButton *nickBtn;
@property (nonatomic, copy) NSString *currentValue;
@property (nonatomic, strong) NSMutableArray *heightArr;
@property (nonatomic, strong) UIPickerView *heightPicker;
@property (nonatomic, strong) UIDatePicker *birthdayPicker;
@end

@implementation YYPopView

- (NSMutableArray *)heightArr
{
    if (!_heightArr) {
        _heightArr = [NSMutableArray array];
        for (int i = 50; i <= 255; i ++) {
            [_heightArr addObject:[@(i) stringValue]];
        }
    }
    return _heightArr;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginL, 17, 100, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [_titleLabel setTextColor:[UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1.00]];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (instancetype)init {
    
    self = [super init];
    
    self.layer.cornerRadius = 0;
    return self;
}

+ (instancetype)popViewUser:(QYUser *)user handler:(void (^)(NSString *))handler {
    
    YYPopView *popView = [[YYPopView alloc] init];
    popView.frame = CGRectMake(0, ScreenSize.height-230, ScreenSize.width, 230);
    popView.backgroundColor = [UIColor whiteColor];
    popView.handler = handler;
    popView.user = user;
    NSNumber *age = user.birthday;
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:age.doubleValue/1000];
    [popView setAgeViewWith:date];
    return popView;
}

- (void)setAgeViewWith:(NSDate *)birthday
{
    
    [self setTitleLabelWith:@"出生日期"];
    
    // 添加确定按钮
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor colorWithHexString:@"52CAC1"] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    doneBtn.frame = CGRectMake(ScreenSize.width - MarginL - 40, 10, 45, 34);
    [self addSubview:doneBtn];
    [doneBtn addTarget:self action:@selector(birthdayDoneBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.birthdayPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(MarginL, Height, ScreenSize.width - MarginL * 2, 150)];
    self.birthdayPicker.datePickerMode = UIDatePickerModeDate;
    birthday = birthday ? birthday : [NSDate dateWithTimeIntervalSince1970:86400*365*10 + 86400*2];
    [self.birthdayPicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:-86400*365*10]]; // 设置最大生日
    [self.birthdayPicker setMinimumDate:[NSDate dateWithTimeIntervalSince1970:-86400*365*60]]; // 最小年龄
    [self.birthdayPicker setDate:birthday animated:YES];
    [self addSubview:self.birthdayPicker];
}

- (void)birthdayDoneBtnDidClick
{
    
    if (self.handler) {
       
        NSString *result = [NSString dataFormatteryyyymmdd:self.birthdayPicker.date];
        self.handler(result);
        self.user.birthday = @([self.birthdayPicker.date timeIntervalSince1970] * 1000);
    }
    
    [self closeView];
}


/**
 *  如果选项是两个的时候添加三根线
 */
- (void)addThreeLins
{
    CGFloat lineW = Width;
    CGFloat lineH = 1;
    CGFloat lineY;
    for (int i = 0; i < 3; i ++) {
        lineY = (i + 1) * Height + 8;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(MarginL, lineY, lineW, lineH)];
        line.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:0.5];
        [self addSubview:line];
    }
}

/**
 *  设置弹出层的标题
 */
- (void)setTitleLabelWith:(NSString *)title
{
    self.titleLabel.text = title;
}

- (UIButton *)setCustomeButtonWith:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1.00] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.96 green:0.65 blue:0.14 alpha:1.00] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor colorWithRed:0.96 green:0.65 blue:0.14 alpha:1.00] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    return btn;
}


// 改动前的按钮样式
- (void)buttonDefaultStyle
{
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    doneBtn.backgroundColor = [UIColor colorWithRed:0.96 green:0.65 blue:0.14 alpha:1.00];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.00] forState:UIControlStateDisabled];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    doneBtn.frame = CGRectMake(ScreenSize.width - MarginL - 80, 13, 80, 34);
    doneBtn.layer.masksToBounds = YES;
    doneBtn.layer.cornerRadius = 5;
}
@end
