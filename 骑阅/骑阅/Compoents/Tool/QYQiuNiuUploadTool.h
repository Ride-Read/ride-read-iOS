//
//  QYQiuNiuUploadTool.h
//  骑阅
//
//  Created by chen liang on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QiniuSDK.h"

@interface QYQiuNiuUploadTool : NSObject

- (void)updateData:(NSData *)data fileName:(NSString *)filename complete:(void(^)(QNResponseInfo *info, NSString *key, NSDictionary *resp))complete;
@end
