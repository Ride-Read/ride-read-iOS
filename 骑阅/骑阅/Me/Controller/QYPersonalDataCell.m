//
//  QYPersonalDataCell.m
//  骑阅
//
//  Created by 谢升阳 on 2017/3/7.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPersonalDataCell.h"

@interface QYPersonalDataCell()

@end

@implementation QYPersonalDataCell

+(instancetype) loadCellWithTableView:(UITableView *)tableView {
    
    static NSString * ID = @"QYPersonalDataCell";
    QYPersonalDataCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QYPersonalDataCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}







@end
