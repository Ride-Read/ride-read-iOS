//
//  QYLocationAnnotionView.h
//  骑阅
//
//  Created by chen liang on 2017/4/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYAnnotionModel.h"

@interface QYLocationAnnotionView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *currentIcon;
@property (nonatomic, weak) QYAnnotionModel *model;
+ (instancetype)locaView;
@end
