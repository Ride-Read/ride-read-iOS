//
//  QYPersonalDataCell.h
//  骑阅
//
//  Created by 谢升阳 on 2017/3/7.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "YYBaiscTableViewCell.h"

@class QYPersonalDataCell;

typedef NS_ENUM(NSInteger, QYPersonalDataCellType) {
   
    QYPersonalDataCellDefault,    //* 没有子视图，
    QYPersonalDataCellImageView,  //* 子视图是UIImageView
    QYPersonalDataCellLabel,      //* 子视图是UIlabel
};

@interface QYPersonalDataCell : YYBaiscTableViewCell

/** mainTitleLabel */
@property(nonatomic,strong) UILabel * mainTitleLabel;
/** indicatorView */
@property(nonatomic,strong) UIImageView * indicatorView;
/** subImageView */
@property(nonatomic,strong) UIImageView * subImageView;
/** subLabel */
@property(nonatomic,strong) UILabel * subLabel;


+(instancetype) loadCellInTableView:(UITableView *)tableView cellType:(QYPersonalDataCellType)cellType;

@end
