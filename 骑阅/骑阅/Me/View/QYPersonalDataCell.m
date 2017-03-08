//
//  QYPersonalDataCell.m
//  骑阅
//
//  Created by 谢升阳 on 2017/3/7.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPersonalDataCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+QYHexStringColor.h"

@interface QYPersonalDataCell()

@end

@implementation QYPersonalDataCell

+(instancetype) loadCellInTableView:(UITableView *)tableView cellType:(QYPersonalDataCellType)cellType {
    
    static NSString * ID = @"QYPersonalDataCell";
    QYPersonalDataCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
    
        cell = [[QYPersonalDataCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID cellType:cellType];
    }
    
    return cell;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(QYPersonalDataCellType)cellType{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUIWithCellType:cellType];
    }
    return self;
}

-(void) setupUIWithCellType:(QYPersonalDataCellType)cellType {
    
    self.mainTitleLabel = [[UILabel alloc]init];
    self.mainTitleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.mainTitleLabel setTextColor:[UIColor colorWithHexString:000000]];
    [self.contentView addSubview:self.mainTitleLabel];
    
    self.indicatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_arrow"]];
    [self.contentView addSubview:self.indicatorView];
    
    self.subLabel = [[UILabel alloc]init];
    self.subLabel.font = [UIFont systemFontOfSize:14.0];
    [self.subLabel setTextColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:self.subLabel];
    
    self.subImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.subImageView];

    
    if (cellType == QYPersonalDataCellDefault) {
        
        self.indicatorView.hidden = NO;
        self.mainTitleLabel.hidden = NO;
        self.subImageView.hidden = YES;
        self.subLabel.hidden = YES;
        
    } else if (cellType == QYPersonalDataCellLabel) {
        
        self.indicatorView.hidden = NO;
        self.mainTitleLabel.hidden = NO;
        self.subLabel.hidden = NO;
        self.subImageView.hidden = YES;
        
    } else {
        
        self.indicatorView.hidden = NO;
        self.mainTitleLabel.hidden = NO;
        self.subImageView.hidden = NO;
        self.subLabel.hidden = YES;
    }
    
}

-(void) layoutSubviews {
    
    [super layoutSubviews];
    
    [self.mainTitleLabel sizeToFit];
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        //左边距离父控件距离为15
        make.left.mas_equalTo(15);
        //中心点Y值跟父控件中心点Y值相等
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    
    [self.indicatorView sizeToFit];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //距离父控件的右边距离为16；
        make.right.mas_equalTo(-16);
        //中心点Y值跟父控件中心点Y值相等
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //右边距离self.indicatorView为16;
        make.right.mas_equalTo(self.indicatorView).mas_offset(-16.0);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
    }];
    
    [self.subImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.width.mas_equalTo(65);
//        make.height.mas_equalTo(65);
        make.top.mas_equalTo(self.contentView.mas_top).mas_equalTo(16);
        make.right.mas_equalTo(self.indicatorView).mas_offset(-16);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_equalTo(-16);
        make.width.mas_equalTo(self.subImageView.mas_height).multipliedBy(1.0);
        
    }];
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
