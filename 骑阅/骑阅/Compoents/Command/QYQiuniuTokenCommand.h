//
//  QYQiuniuTokenCommand.h
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "CLCommands.h"
#import "QiniuSDK.h"

@interface QYQiuniuTokenCommand : CLCommands
@property (nonatomic, strong) NSDictionary *nextParams;
@property (nonatomic, strong) QNUpCompletionHandler complete;


@end
