//
//  QYQiuniuUploadCommand.m
//  骑阅
//
//  Created by chen liang on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYQiuniuUploadCommand.h"
#import "define.h"

@interface QYQiuniuUploadCommand ()
@property (nonatomic, strong) QNUploadManager *up;

@end

@implementation QYQiuniuUploadCommand


- (void)execute {
    
    NSData *data = self.params[kdata];
    NSString *fileName = self.params[kfilename];
    NSString *token = self.params[ktoken];
    [self.up putData:data key:fileName token:token complete:self.complete option:nil];
    
}
- (CTAPIBaseManager *)apiManager {
    
    return nil;
}

- (QNUploadManager *)up {
    
    if (!_up) {
        
        QNZone *httpsZone = [[QNAutoZone alloc] initWithHttps:YES dns:nil];
        QNConfiguration *cfg = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
            
            builder.zone = httpsZone;
        }];
        _up = [[QNUploadManager alloc] initWithConfiguration:cfg];
    }
    return _up;
}

@end
