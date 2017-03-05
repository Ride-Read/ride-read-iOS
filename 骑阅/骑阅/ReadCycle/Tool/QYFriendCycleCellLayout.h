//
//  QYFriendCycleCellLayout.h
//  骑阅
//
//  Created by chen liang on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QYFrIendStatusMessage.h"

@interface QYFriendCycleCellLayout : NSObject
@property (nonatomic, strong) QYFrIendStatusMessage *status;

+ (instancetype)friendStatusCellLayout:(QYFrIendStatusMessage *)status;
@end
