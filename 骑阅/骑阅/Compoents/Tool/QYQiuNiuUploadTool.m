//
//  QYQiuNiuUploadTool.m
//  骑阅
//
//  Created by chen liang on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYQiuNiuUploadTool.h"
#import "QYGetQiNiuTokenApiManager.h"
#import "CTAppContext.h"
#import "QiniuSDK.h"
#import "QYQiuniuReformer.h"

@interface QYQiuNiuUploadTool ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>

@property (nonatomic, strong) QYGetQiNiuTokenApiManager *apiManager;
@property (nonatomic, strong) QNUploadManager *up;
@property (nonatomic, copy) QNUpCompletionHandler handler;
@property (nonatomic, strong) QYQiuniuReformer *reformer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) NSData *data;

@end
@implementation QYQiuNiuUploadTool

- (void)updateData:(NSData *)data fileName:(NSString *)filename complete:(void (^)(QNResponseInfo *, NSString *, NSDictionary *))complete {
    
    NSString *token = [CTAppContext sharedInstance].qiuniu_token;
    self.key = filename;
    self.handler = complete;
    self.data = data;
    if (token) {
        
        [self.up putData:data key:@"ride_read_image" token:token complete:complete option:nil];
        self.handler = nil;
        
    } else {
        
        [self.apiManager loadData];
        
    }
}
#pragma mark - CTAPIManagerCallback
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    return nil;
}

#pragma mark - CTAPIManagaerCallbackDelegate
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
     self.handler([QNResponseInfo responseInfoWithInvalidToken:@"invalid token"], self.key, nil);
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    NSString *token =  [self.apiManager fetchDataWithReformer:self.reformer];
    [self.up putData:self.data key:@"ride_read_image" token:token complete:self.handler option:nil];
}

- (QYGetQiNiuTokenApiManager *)apiManager {
    
    if (!_apiManager) {
        _apiManager = [[QYGetQiNiuTokenApiManager alloc] init];
        _apiManager.delegate = self;
        _apiManager.paramSource = self;
    }
    return _apiManager;
}
- (QYQiuniuReformer *)reformer {
    
    if (!_reformer) {
        
        _reformer = [[QYQiuniuReformer alloc] init];
    }
    return _reformer;
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
