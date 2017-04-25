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
#import "QYTagCell.h"


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
@property (nonatomic, assign) NSInteger seleceNumber;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) QYTagCell *customTag;
@property (nonatomic, copy) void(^clickCustom)(UIView *view);
@property (nonatomic, copy) void (^handler)(NSString *tags);
@end


@implementation QYTagPromptView

+ (instancetype)creatView {
    
    return [[self alloc]init];
}
+ (instancetype)tagView:(void (^)(UIView *))clickCustom clickConfirm:(void (^)(NSString *))handler {
    
    return [[self alloc] initWithClick:clickCustom clickConfirm:handler];
}

- (instancetype)initWithClick:(void (^)(UIView *))clickCustom clickConfirm:(void (^)(NSString *))handler {
    
    self = [super init];
    self.clickCustom = clickCustom;
    self.backgroundColor = [UIColor whiteColor];
    self.QY_x = 30;
    self.QY_y = 30;
    self.QY_height = cl_caculation_3y(1100);
    self.QY_width = kScreenWidth - 2 * self.QY_x;
    [self setupUI];
    [self layout];
    self.handler = handler;
    return self;
}

- (void)setupUI {
    
    self.titleLabel = [[YYLabel alloc]init];
    [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#52CAC1"]];
    self.titleLabel.textAlignment = 1;
    [self addSubview:self.titleLabel];
    [self.titleLabel showBottomLine];
    [self addSubview:self.cutLineBottom];
    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancleBtn.tag = 0;
    [self.cancleBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    [self addSubview:self.cancleBtn];
    [self.cancleBtn showRightLine];
    [self.cancleBtn showTopLine];
    
    self.configBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.configBtn.tag = 1;
    [self.configBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.configBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.configBtn setTitleColor:[UIColor colorWithHexString:@"#52CAC1"] forState:UIControlStateNormal];
    [self addSubview:self.configBtn];
    [self.configBtn showTopLine];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"QYTagCell" bundle:nil] forCellReuseIdentifier:@"tagcell"];
    self.tableView.scrollEnabled = NO;
    self.tableView.tableHeaderView = self.customTag;
    self.tableView.tableFooterView = [UIView new];
    [self addSubview:self.tableView];
    [self.tableView showBottomLine];
    
}

- (void)layout {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
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
    
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.and.left.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.cancleBtn.mas_top).offset(0);
    }];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
   
}


- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 1) {
        
        if (self.handler) {
            
            NSString *tags = [self.tags componentsJoinedByString:@","];
            self.handler(tags);
        }
    }
//    NSLog(@"%@-->%zd",self.inputTextField.text,sender.tag);
    [self closeView];
}

#pragma -- <UItableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tagcell" forIndexPath:indexPath];
    cell.selectButton.layer.borderWidth = 1.0;
    cell.selectButton.layer.borderColor = [UIColor colorWithHexString:@"#555555"].CGColor;
    
    switch (indexPath.row) {
        case 0:
        {
            
            cell.tagLabel.text = @"随性";
            BOOL select = [self checkSelect:@"随性"];
            if (select) {
                
                cell.selectButton.selected = YES;
                cell.selectButton.layer.borderWidth = 0.;
            }
            
        }
            break;
        case 1:
        {
            
            cell.tagLabel.text = @"喜欢简单";
            BOOL select = [self checkSelect:@"喜欢简单"];
            if (select) {
                
                cell.selectButton.selected = YES;
                cell.selectButton.layer.borderWidth = 0.;
            }
            
        }
            break;
         
        case 2:
        {
            
            cell.tagLabel.text = @"理想主义";
            BOOL select = [self checkSelect:@"理想主义"];
            if (select) {
                
                cell.selectButton.selected = YES;
                cell.selectButton.layer.borderWidth = 0.;
            }
            
        }
            break;
         
        case 3:
        {
            
            cell.tagLabel.text = @"热血";
            BOOL select = [self checkSelect:@"热血"];
            if (select) {
                
                cell.selectButton.selected = YES;
                cell.selectButton.layer.borderWidth = 0.;
            }
            
        }
            break;
         
        case 4:
        {
            
            cell.tagLabel.text = @"安静";
            BOOL select = [self checkSelect:@"安静"];
            if (select) {
                
                cell.selectButton.selected = YES;
                cell.selectButton.layer.borderWidth = 0.;
            }
            
        }
            break;
         
        case 5:
        {
            
            cell.tagLabel.text = @"萌萌哒";
            BOOL select = [self checkSelect:@"萌萌哒"];
            if (select) {
                
                cell.selectButton.selected = YES;
                cell.selectButton.layer.borderWidth = 0.;
            }
            
        }
            break;
         
        case 6:
        {
            
            cell.tagLabel.text = @"女汉子";
            BOOL select = [self checkSelect:@"女汉子"];
            if (select) {
                
                cell.selectButton.selected = YES;
                cell.selectButton.layer.borderWidth = 0.;
            }
            
        }
            break;
         
        case 7:
        {
            
            cell.tagLabel.text = @"强迫症";
            BOOL select = [self checkSelect:@"强迫症"];
            if (select) {
                
                cell.selectButton.selected = YES;
                cell.selectButton.layer.borderWidth = 0.;
            }
            
        }
            break;
        
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 56;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [UIView new] ;
    [view showBottomLine];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYTagCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell.selectButton.isSelected && self.seleceNumber == 3) {
        
        [MBProgressHUD showMessageAutoHide:@"最多选择三个标签" view:nil];
        return;
    }
    if (cell.selectButton.isSelected) {
        
        self.seleceNumber--;
        [self.tags enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSString *tag = obj;
            if ([tag isEqualToString:cell.tagLabel.text]) {
                
                [self.tags removeObject:obj];
            }
        }];
    } else {
        
        self.seleceNumber ++;
        [self.tags addObject:cell.tagLabel.text];
    }
    cell.selectButton.selected = !cell.selectButton.selected;
    if (cell.selectButton.isSelected) {
        
        cell.selectButton.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.selectButton.layer.borderWidth = 0.;
      
    } else {
        
        cell.selectButton.layer.borderColor = [UIColor colorWithHexString:@"#555555"].CGColor;
        cell.selectButton.layer.borderWidth = 1.0;
    }
}

- (BOOL)checkSelect:(NSString *)text {
 
    NSString *tags = self.usr.tagString;
    NSArray *tagA = [tags componentsSeparatedByString:@","];
    BOOL check = NO;
    for (NSString *temp in tagA) {
        
        if ([temp isEqualToString:text]) {
            
            check = YES;
            self.seleceNumber = self.seleceNumber + 1;
            [self.tags addObject:text];
            break;
        }
    }
    return check;
}

- (NSMutableArray *)tags {
    
    if (!_tags) {
        
        _tags = @[].mutableCopy;
    }
    return _tags;
}

- (QYTagCell *)customTag {
    
    if (!_customTag) {
        
        _customTag = [QYTagCell customTagCell:self.clickCustom];
        _customTag.prompt = self;
        _customTag.frame = CGRectMake(0, 0, kScreenWidth, 56);
        
    }
    return _customTag;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
