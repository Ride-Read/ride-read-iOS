//
//  QYQiuniuUploadCommand.h
//  骑阅
//
//  Created by chen liang on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "CLCommands.h"
#import "QiniuSDK.h"

@interface QYQiuniuUploadCommand : CLCommands
@property (nonatomic, strong) QNUpCompletionHandler complete;

@end
