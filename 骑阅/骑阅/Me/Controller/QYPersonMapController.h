//
//  QYPersonMapController.h
//  骑阅
//
//  Created by chen liang on 2017/4/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicViewController.h"
#import "QYUser.h"

@interface QYPersonMapController : QYBasicViewController

//目前传过来，实际上逻辑和阅图一致，需要抽出该逻辑供该两部分处理
@property (nonatomic, strong) NSArray *annos;
@property (nonatomic, weak) QYUser *user;
@end
