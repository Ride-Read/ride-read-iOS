//
//  QYTableViewCell.m
//  骑阅
//
//  Created by 谢升阳 on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYSelectModel.h"

@interface QYTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;


@end

@implementation QYTableViewCell


+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView{
    
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QYTableViewCellReuseID];
    
    if (!cell){
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QYTableViewCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}

- (void)setModel:(QYSelectModel *)model{
    
    if (model == _model)
        return;
    
    _titleLable.text = model.title;
    _titleLable.textColor = model.titleColor; 
}
@end
