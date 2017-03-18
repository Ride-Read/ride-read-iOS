//
//  CTService.h
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,YYServiceType) {
    
    YYServiceTypeDefault,
    YYServiceTypeRequestAuthen,
    YYServiceTypeRequstJsonEncode,
    YYServiceTypeResponseEncode
};
@protocol CTServiceProtocal <NSObject>

@property (nonatomic, readonly) BOOL isOnline;
@property (nonatomic, readonly) YYServiceType serviceType;

@property (nonatomic, readonly) NSString *offlineApiBaseUrl;
@property (nonatomic, readonly) NSString *onlineApiBaseUrl;

@property (nonatomic, readonly) NSString *offlinePublicKey;
@property (nonatomic, readonly) NSString *onlinePublickKey;

@property (nonatomic, readonly) NSString *offlinePrivateKey;
@property (nonatomic, readonly) NSString *onlinePrivateKey;

@property (nonatomic, readonly) NSString *offlineApiVersion;
@property (nonatomic, readonly) NSString *onlineApiVersion;




@end


@interface CTService : NSObject
@property (nonatomic, strong, readonly) NSString *publickKey;
@property (nonatomic, strong, readonly) NSString *privateKey;
@property (nonatomic, strong, readonly) NSString *apiBaseUrl;
@property (nonatomic, strong, readonly) NSString *apiVersion;
@property (nonatomic, assign, readonly) YYServiceType type;

@property (nonatomic, weak) id<CTServiceProtocal>child;
@end
