//
//  QYTagPromptView.m
//  骑阅
//
//  Created by 谢升阳 on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTagPromptView.h"
#import "YYLabel.h"
#import "UIView+Frame.h"
#import "UIColor+QYHexStringColor.h"



@interface QYTagPromptView ()<UITableViewDelegate,UITableViewDataSource>
/** titleLabel */
@property(nonatomic,strong) YYLabel * titleLabel;
/** cutLineTop */
@property(nonatomic,strong) UIView * cutLineTop;
/** cutLineBottom */
@property(nonatomic,strong) UIView * cutLineBottom;
/** cutLineMid */
@property(nonatomic,strong) UIView * cutLineMid;
/** cancleBtn */
@property(nonatomic,strong) UIButton * cancleBtn;
/** configBtn */
@property(nonatomic,strong) UIButton * configBtn;
/** subCutLine */
@property(nonatomic,strong) UIView * subCutLine;
/** inputTextField */
@property(nonatomic,strong) UITextField * inputTextField;
/** tableView */
@property(nonatomic,strong) UITableView * tableView;
@end


@implementation QYTagPromptView

+ (instancetype)creatView {
    
    return [[self alloc]init];
}
- (instancetype)init {
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.QY_x = 30;
        self.QY_y = 30;
        self.QY_height = kScreenHeight - 2 * self.QY_y;
        self.QY_width = kScreenWidth - 2 * self.QY_x;
        [self setupUI];
    }
    return  self;
}


- (void)setupUI {
    
    self.titleLabel = [[YYLabel alloc]init];
    [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#52CAC1"]];
    self.titleLabel.textAlignment = 1;
    [self addSubview:self.titleLabel];
    
    self.cutLineTop = [[UIView alloc]init];
    self.cutLineTop.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self addSubview:self.cutLineTop];
    
    self.cutLineBottom = [[UIView alloc]init];
    self.cutLineBottom.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self addSubview:self.cutLineBottom];
    
    self.cutLineMid = [[UIView alloc]init];
    self.cutLineMid.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self addSubview:self.cutLineMid];

    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancleBtn.tag = 1;
    [self.cancleBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:self.cancleBtn];
    
    self.configBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.configBtn.tag = 2;
    [self.configBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.configBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.configBtn setTitleColor:[UIColor colorWithHexString:@"#52CAC1"] forState:UIControlStateNormal];
    [self addSubview:self.configBtn];
    
    self.subCutLine = [[UIView alloc]init];
    self.subCutLine.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self addSubview:self.subCutLine];

    self.inputTextField = [[UITextField alloc]init];
    self.inputTextField.placeholder = @"建立个性标签";
    [self addSubview:self.inputTextField];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.cutLineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.titleLabel.mas_height);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5).offset(-0.5);
        make.right.mas_equalTo(self.configBtn.mas_left).offset(0);
    }];
    
    [self.configBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.cancleBtn.mas_height);
        make.left.mas_equalTo(self.cancleBtn.mas_right).offset(0);
    }];
    
    [self.subCutLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.cancleBtn.mas_height);
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.cutLineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.cancleBtn.mas_top).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.cutLineMid mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.inputTextField.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.cutLineTop.mas_bottom).offset(0);
        make.height.mas_equalTo(self.titleLabel.mas_height).multipliedBy(0.8);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.and.left.mas_equalTo(0);
        make.top.mas_equalTo(self.cutLineMid.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.cutLineBottom.mas_top).offset(0);
    }];
}


- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)buttonClick:(UIButton *)sender {
    
//    NSLog(@"%@-->%zd",self.inputTextField.text,sender.tag);
    [self closeView];
}

#pragma -- <UItableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
