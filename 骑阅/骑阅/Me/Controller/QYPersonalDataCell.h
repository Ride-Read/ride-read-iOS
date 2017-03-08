//
//  QYPersonalDataCell.h
//  骑阅
//
//  Created by 谢升阳 on 2017/3/7.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYPersonalDataCell : UITableViewCell

/** MainTitleLabel */
@property(nonatomic,strong) UILabel * mainTitleLabel;
/** indicatorView */
@property(nonatomic,strong) UIImageView * indicatorView;

//快速创建cell方法
+(instancetype) loadCellWithTableView:(UITableView *)tableView;


@end
