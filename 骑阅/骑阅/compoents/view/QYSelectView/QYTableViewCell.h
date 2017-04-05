//
//  QYTableViewCell.h
//  骑阅
//
//  Created by 谢升阳 on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYSelectModel;


static NSString *QYTableViewCellReuseID = @"QYTableViewCell";

@interface QYTableViewCell : UITableViewCell
@property (nonatomic,weak) QYSelectModel *model;

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;
@end
