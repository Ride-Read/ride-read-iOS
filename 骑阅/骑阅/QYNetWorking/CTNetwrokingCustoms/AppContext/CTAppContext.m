//
//  AXRuntimeInfomation.m
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import "CTAppContext.h"
#import "NSObject+AXNetworkingMethods.h"
#import "UIDevice+IdentifierAddition.h"
#import "AFNetworkReachabilityManager.h"
#import "CTLogger.h"
#import "CTLocationManager.h"

@interface CTAppContext ()

// 用户的token管理
@property (nonatomic, copy, readwrite) NSString *accessToken;
@property (nonatomic, copy, readwrite) NSString *refreshToken;
@property (nonatomic, assign, readwrite) NSTimeInterval lastRefreshTime;
@property (nonatomic, strong) dispatch_queue_t barrier_queue;

@property (nonatomic, copy, readwrite) NSString *sessionId; // 每次启动App时都会新生成,用于日志标记


@end

@implementation CTAppContext

@synthesize userInfo = _userInfo;
@synthesize userID = _userID;
@synthesize timestamp = _timestamp;


#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static CTAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
    });
    return sharedInstance;
}

#pragma mark - public methods
- (void)updateAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken
{
    self.accessToken = accessToken;
    self.refreshToken = refreshToken;
    self.lastRefreshTime = [[NSDate date] timeIntervalSince1970] * 1000;
    
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:@"refreshToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)cleanUserInfo
{
    self.accessToken = nil;
    self.refreshToken = nil;
    self.userInfo = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"refreshToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - getters and setters

-(dispatch_queue_t)barrier_queue {
    if (!_barrier_queue) {
     
        _barrier_queue = dispatch_queue_create("property.read.write.queque", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return _barrier_queue;
}

- (void)setUserID:(NSString *)userID
{
    _userID = [userID copy];
    [[NSUserDefaults standardUserDefaults] setObject:_userID forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userID
{
    if (_userID == nil) {
        _userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    return _userID;
}

- (void)setUserInfo:(NSDictionary *)userInfo
{

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[NSNull class]]) {
            
            if ([key isEqualToString:@"tags"]) {
                
                dic[key] = @[];
            } else {
                if ([key isEqualToString:@"sex"] || [key isEqualToString:@"latitude"] || [key isEqualToString:@"longitude"] ||[key isEqualToString:@"follower"] ||[key isEqualToString:@"following"]) {
                    dic[key] = @(0);
                } else
                    dic[key] = @"";
            }
            NSLog(@"find null");
        }
        
    }];
    _userInfo = [dic copy];
    
    [[NSUserDefaults standardUserDefaults] setObject:_userInfo forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)userInfo
{
    if (_userInfo == nil) {
        _userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    }
    return _userInfo;
}
- (NSString *)qiuniu_token {
    
    if (!_qiuniu_token) {
        
        _qiuniu_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"qiuniu_token"];
    }
    return _qiuniu_token;
}

- (NSNumber *)timestamp {
    
    if (!_timestamp) {
        
        _timestamp = [[NSUserDefaults standardUserDefaults] objectForKey:@"timestamp"];
    }
    return _timestamp;
}

- (void)setTimestamp:(NSNumber *)timestamp {
    
    _timestamp = timestamp;
    [[NSUserDefaults standardUserDefaults] setObject:timestamp forKey:@"timestamp"];
}
- (void)configQiuniuToken:(NSString *)qiuniu {
    
    [[NSUserDefaults standardUserDefaults] setObject:qiuniu forKey:@"qiuniu_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _qiuniu_token = qiuniu;
    
}
//- (void)setQiuniu_token:(NSString *)qiuniu_token {
//    
//    
//}
- (QYUser *)currentUser {
    
    if (!_currentUser) {
        
        _currentUser = [QYUser userWithDict:self.userInfo];
        if (self.userInfo == nil) _currentUser = nil;
    }
    
    return _currentUser;
}


- (void)setUserHasFollowings:(BOOL)userHasFollowings
{
    [[NSUserDefaults standardUserDefaults] setBool:userHasFollowings forKey:@"userHasFollowings"];
}

- (BOOL)userHasFollowings
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"userHasFollowings"];
}

- (NSString *)accessToken
{
    if (_accessToken == nil) {
        _accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"accessToken"];
    }
    return _accessToken;
}

- (NSString *)refreshToken
{
    if (_refreshToken == nil) {
        _refreshToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"refreshToken"];
    }
    return _refreshToken;
}

- (NSString *)type
{
    return @"ios";
}

- (NSString *)model
{
    return [[UIDevice currentDevice] name];
}

- (NSString *)os
{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)rom
{
    return [[UIDevice currentDevice] model];
}

- (NSString *)imei
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)imsi
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)deviceName
{
    return [[UIDevice currentDevice] name];
}

-(NSString *)deviceDetailMessage {
    
    return [[UIDevice alloc] machineType];
}
- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (NSString *)ppi
{
    NSString *ppi = @"";
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"]) {
        
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"]) {
        
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"]) {
        ppi = @"401";
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,2"]) {
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        ppi = @"132";
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        ppi = @"264";
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        ppi = @"326";
    }
    else {
        ppi = @"264";
    }
    return ppi;
}

- (CGSize)resolution
{
    CGSize resolution = CGSizeZero;
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        resolution = CGSizeMake(320, 480);
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"]) {
        
        resolution = CGSizeMake(640, 960);
    }
    else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"]) {
        
        resolution = CGSizeMake(640, 1136);
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"]) {
        resolution = CGSizeMake(1080, 1920);
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,2"]) {
        resolution = CGSizeMake(750, 1334);
    }
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else {
        resolution = CGSizeMake(640, 960);
    }
    return resolution;
}

- (NSString *)appVersion
{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

- (CGFloat)latitude
{
    return [CTLocationManager sharedInstance].currentLocation.coordinate.latitude;
}

- (CGFloat)longitude
{
    return [CTLocationManager sharedInstance].currentLocation.coordinate.longitude;
}

- (void)appStarted
{
    self.sessionId = [[NSUUID UUID].UUIDString copy];
    [[CTLocationManager sharedInstance] startLocation];
}

- (void)appEnded
{
    [[CTLocationManager sharedInstance] stopLocation];
}

- (BOOL)isLoggedIn
{
    BOOL result = (self.userID.length != 0);
    return result;
}

- (BOOL)isOnline
{
    
    static dispatch_once_t onceToken;
    static BOOL isOnline = YES;
    dispatch_once(&onceToken, ^{
        
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"CTNetworkingConfiguration" ofType:@"plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
            NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filepath];
            isOnline = [settings[@"isOnline"] boolValue];
        } else {
            isOnline = kCTServiceIsOnline;
        }
        
    });
    return isOnline;
}
-(NSNumber *)app_version {
    
    static dispatch_once_t onceToken;
    static NSNumber *version;
    dispatch_once(&onceToken, ^{
        
        version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"local_version"];
    });
    return version;
}

- (NSString *)deviceToken
{
    if (_deviceToken == nil) {
        _deviceToken = @"";
    }
    return _deviceToken;
}

- (NSData *)deviceTokenData
{
    if (_deviceTokenData == nil) {
        _deviceTokenData = [NSData data];
    }
    return _deviceTokenData;
}

#pragma mark

#pragma mark - 选中的的操作放入在一个栅栏中提供读写速度
-(void)configSelectArray {
    
   
    dispatch_barrier_async(self.barrier_queue, ^{
       
        NSMutableArray *select = [NSMutableArray array];
        [self.devceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary *dic = obj;
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([key isEqualToString:@"status"]) {
                    
                    NSNumber *status = obj;
                    if (status.integerValue == 1) {
                        
                        [select addObject:dic];
                        
                    }
                }
            }];
            
        }];
        self.selectArray = select;
        
        //return selectarray;

    });
}

-(NSArray *)selectArray {
    
    __block NSArray *array;
    dispatch_barrier_sync(self.barrier_queue, ^{
       
        array = _selectArray;
    });
    
    return array;
}

-(void )configSelectCycleArray {
    
    dispatch_barrier_async(self.barrier_queue, ^{
       
        NSMutableArray *selectarray = [NSMutableArray array];
        [self.cycleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary *dic = obj;
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([key isEqualToString:@"status"]) {
                    
                    NSNumber *status = obj;
                    if (status.integerValue == 1) {
                        
                        [selectarray addObject:dic];
                        
                    }
                }
            }];
            
        }];
        self.slectCycleArray = selectarray;

    });
}

-(NSArray *)slectCycleArray {
    
    
    __block NSArray *array;
    dispatch_barrier_sync(self.barrier_queue, ^{
        
        array  = _slectCycleArray;
    });
    return array;
    
}

-(void )configSelectFunctionArray {
    
    dispatch_barrier_async(self.barrier_queue, ^{
        
        NSMutableArray *selectarray = [NSMutableArray array];
        [self.functionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary *dic = obj;
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([key isEqualToString:@"status"]) {
                    
                    NSNumber *status = obj;
                    if (status.integerValue == 1) {
                        
                        [selectarray addObject:dic];
                        
                    }
                }
            }];
            
        }];
        self.slectFunctionArray = selectarray;
        
    });
}

-(NSArray *)slectFunctionArray {
    
    __block NSArray *array;
    dispatch_barrier_sync(self.barrier_queue, ^{
       
        array = _slectFunctionArray;
    });
    
    return array;
}

-(NSArray *)functionArray {
    
    if (!_functionArray) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSArray *array = [ud objectForKey:@"use_function"];
        
        if (array.count == 0 || !array) {
            
            array = @[[[NSMutableDictionary alloc]
                       initWithDictionary:@{@"name":@"体重管理",
                                            @"en_name":@"weight_manager",
                                            @"imageName":@"CMWeightManager",
                                            @"hm_imageName":@"hm_result_weight",
                                            @"tag":@(0),
                                            @"status":@(YES)
                                   
                                   }],
                      [[NSMutableDictionary alloc]
                       initWithDictionary: @{@"name":@"睡眠管理",
                                             @"en_name":@"sleep_manager",
                                             @"imageName":@"CMSleep",
                                             @"hm_imageName":@"hm_result_sleep",
                                             @"tag":@(1),
                                             @"status":@(NO)
                                 
                                 }],
                      [[NSMutableDictionary alloc]
                       initWithDictionary: @{@"name":@"康复理疗",
                                             @"en_name":@"health_manager",
                                             @"imageName":@"CMHealthCure",
                                             @"hm_imageName":@"hm_result_health",
                                             @"tag":@(2),
                                             @"status":@(NO)
                                 
                                 }]];
            [ud setObject:array forKey:@"use_function"];
            [ud synchronize];
           
        } else {
            
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                
                NSMutableDictionary *m_dict = [NSMutableDictionary dictionaryWithDictionary:dic];
                [temp addObject:m_dict];
            }
            
            array = temp;
        }
         _functionArray = array;
    }
    
    return _functionArray;
}

-(void)updateCustomMessage:(NSArray *)array withKey:(NSString *)key{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([key isEqualToString:@"use_function"]) {
        
        self.functionArray = array;
    }
    
    if ([key isEqualToString:@"use_device"]) {
    
        self.devceArray = array;
    }
    
    if ([key isEqualToString:@"use_cycle"]) {
        
        self.cycleArray = array;
    }
    [ud setObject:array forKey:key];
    [ud synchronize];
}

-(NSArray *)devceArray {
    
    if (!_devceArray) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSArray *array = [ud objectForKey:@"use_device"];
     
        if (array.count == 0 || !array) {
            NSMutableDictionary *scale = [[NSMutableDictionary alloc]
                                          initWithDictionary:@{@"name":@"蓝牙秤",
                                                               @"en_name":@"scale",
                                                               @"imageName":@"cm_result_scale",
                                                               @"hm_imageName":@"hm_result_scale",
                                                               @"en":@"Bluetooth scales",
                                                               @"tag":@(0),
                                                               @"status":@YES}];
            
            NSDictionary *mini = [[NSMutableDictionary alloc]
                                  initWithDictionary:@{@"name":@"随身松",
                                                       @"en_name":@"massager",
                                                       @"imageName":@"cm_result_massory",
                                                       @"hm_imageName":@"hm_result_massory",
                                                       @"en":@"Mini Massager",
                                                       @"tag":@(1),
                                                       @"status":@YES}];
            
            
            NSDictionary *breast = [[NSMutableDictionary alloc]
                                    initWithDictionary:@{@"name":@"蓝牙丰胸仪",
                                                         @"en_name":@"breast",
                                                         @"imageName":@"cm_result_bar",
                                                         @"hm_imageName":@"fengxiong",
                                                         @"en":@"Bluetooth breast instrument",
                                                         @"tag":@(2),
                                                         @"status":@YES}];
            
//            NSDictionary *escale = [[NSMutableDictionary alloc]
//                                    initWithDictionary:@{@"name":@"E身松",
//                                                         @"en_name":@"e_massager",
//                                                         @"imageName":@"EMassaryIcon",
//                                                         @"hm_imageName":@"EMassaryIcon",
//                                                         @"en":@"E Massager",
//                                                         @"tag":@(3),
//                                                         @"status":@YES}];
           
            
//            NSDictionary *gprs = [[NSMutableDictionary alloc]
//                                  initWithDictionary:@{@"name":@"GPRS血压计",
//                                                       @"en_name":@"gprs_blood",
//                                                       @"imageName":@"gprs_blood",
//                                                       @"hm_imageName":@"gprs_blood",
//                                                       @"en":@"GPRS sphygmomanometer",
//                                                       @"tag":@(4),
//                                                       @"status":@NO}];

//            
//            NSDictionary *sleep = [[NSMutableDictionary alloc]
//                                   initWithDictionary:@{@"name":@"智能睡眠仪",
//                                                        @"en_name":@"blue_sleep",
//                                                        @"imageName":@"blue_sleep",
//                                                        @"hm_imageName":@"blue_sleep",
//                                                        @"en":@"Smart sleep instrument",
//                                                        @"tag":@(5),
//                                                        @"status":@NO}];
//            
////            NSDictionary *skin = [[NSMutableDictionary alloc]
//                                  initWithDictionary:@{@"name":@"智能皮肤检测仪",
//                                                       @"en_name":@"blue_skin",
//                                                       @"imageName":@"blue_skin",
//                                                       @"hm_imageName":@"blue_skin",
//                                                       @"en":@"Smart skin detector",
//                                                       @"tag":@(6),
//                                                       @"status":@NO}];
//            
////            NSDictionary *nutrition = [[NSMutableDictionary alloc]
//                                       initWithDictionary:@{@"name":@"蓝牙营养秤",
//                                                            @"en_name":@"blue_nutrition",
//                                                            @"imageName":@"blue_nutrition",
//                                                            @"hm_imageName":@"blue_nutrition",
//                                                             @"en":@"Bluetooth Nutrition Scales",
//                                                            @"tag":@(7),
//                                                            @"status":@NO}];
            
            
            array = [NSArray arrayWithObjects:scale, mini, breast, nil];

            self.selectArray = @[scale,mini,breast];
            [ud setObject:array forKey:@"use_device"];
            [ud synchronize];
           
        }  else {
            
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                
                NSMutableDictionary *m_dict = [NSMutableDictionary dictionaryWithDictionary:dic];
                [temp addObject:m_dict];
            }
            
            array = temp;
        }
         _devceArray = array;
       
    }
    
 
    return _devceArray;

}

-(NSArray *)cycleArray {
    
    if (!_cycleArray) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSArray *array = [ud objectForKey:@"use_cycle"];
       
        if (array.count == 0 || !array) {
            
        NSMutableDictionary *sport = [[NSMutableDictionary alloc]
             initWithDictionary:@{@"status":@"1",
                                  @"articleType":@{@"id":@(1),
                                                    @"name":@"运动圈",
                                                    @"content":@"一起运动，一起出汗！",
                                                    @"image":@"https://dn-jMICTiQq.qbox.me/71035b1ebd55a32d074b.png",
                                                    @"paixu":@(1)}
                                  }];
            
        NSMutableDictionary *sleep = [[NSMutableDictionary alloc]
                                      initWithDictionary:@{@"status":@"1",
                                                           @"articleType":@{@"id":@(2),
                                                                            @"name":@"塑身圈",
                                                                            @"content":@"一起运动，一起出汗！",
                                                                            @"image":@"https://dn-jMICTiQq.qbox.me/4e0f9556090d3c3e7a30.png",
                                                                            @"paixu":@(2)}
                                                           }];
            
        NSMutableDictionary *health = [[NSMutableDictionary alloc]
                                       initWithDictionary:@{@"status":@"1",
                                                            @"articleType":@{@"id":@(3),
                                                                             @"name":@"健身圈",
                                                                             @"content":@"一起运动，一起出汗！",
                                                                             @"image":@"https://dn-jMICTiQq.qbox.me/7bc8f565ab6968c3fbb9.png",
                                                                             @"paixu":@(3)}
                                                            }];
            NSMutableDictionary *diet = [[NSMutableDictionary alloc]
                                         initWithDictionary:@{@"status":@"0",
                                                              @"articleType":@{@"id":@(4),
                                                                               @"name":@"素食圈",
                                                                               @"content":@"一起运动，一起出汗！",
                                                                               @"image":@"https://dn-jMICTiQq.qbox.me/7a60b1b05d349fab3ce1.png",
                                                                               @"paixu":@(4)}
                                                              }];

            NSMutableDictionary *outDoor = [[NSMutableDictionary alloc]
                                            initWithDictionary:@{@"status":@"0",
                                                                 @"articleType":@{@"id":@(5),
                                                                                  @"name":@"户外圈",
                                                                                  @"content":@"一起运动，一起出汗！",
                                                                                  @"image":@"https://dn-jMICTiQq.qbox.me/8e9f6edd6d532d14cc59.png",
                                                                                  @"paixu":@(5)}
                                                                }];

            
            array = @[sport,sleep,health,diet,outDoor];
                      
            [ud setObject:array forKey:@"use_cycle"];
            [ud synchronize];
           
           
        } else {
            
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                
                NSMutableDictionary *m_dict = [NSMutableDictionary dictionaryWithDictionary:dic];
                [temp addObject:m_dict];
            }
            
            array = temp;
        }
         _cycleArray = array;
    }
    
    return _cycleArray;

}
-(NSString *)string {
    
    if (!_string) {
        
        
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"]];
        _string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return _string;
}

-(UIImagePickerController *)picker {
    
    if (!_picker) {
        
        _picker = [[UIImagePickerController alloc] init];
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.allowsEditing = YES;
    }
    return _picker;
}

-(BOOL)isFirstIn {
    
    static dispatch_once_t onceToken;
    static BOOL flag;
    dispatch_once(&onceToken, ^{
        
        NSUserDefaults *userDfaults = [NSUserDefaults standardUserDefaults];
        NSNumber *isfirst = [userDfaults objectForKey:@"app_firstIn"];
        if ([isfirst isEqual: @(1)]) {
            
            flag = NO;
            return;
        } else {
            
            flag = YES;
//            if ([UIDevice currentDevice].systemVersion.floatValue > 9.0) {
//                UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"完善个人信息秤量数据更准哦，亲。" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    
//                    [alertControl dismissViewControllerAnimated:YES completion:nil];
//                }];
//                [alertControl addAction:action];
//               // [self presentViewController:alertControl animated:YES completion:nil];
//                
//            } else {
//                
//                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"完善个人信息秤量数据更准哦，亲。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//                [alerView show];
//                
//            }

        }
        [userDfaults setObject:@(1) forKey:@"app_firstIn"];
        [userDfaults synchronize];
        
    });
    return flag;

}

#pragma mark --
#pragma mark QY


@end
