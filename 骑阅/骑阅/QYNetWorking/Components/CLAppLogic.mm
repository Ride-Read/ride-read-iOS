//
//  CLAppLogic.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/18.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "CLAppLogic.h"
#import <objc/runtime.h>

NSString *const kApiManagerNetWorkingError = @"ApiManagerNetWorkingError";
dispatch_queue_t url_session_manager_queue() {
    
    static dispatch_queue_t cl_url_session_manager_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        cl_url_session_manager_queue = dispatch_queue_create("com.youyue.networking.session.manager.processing", DISPATCH_QUEUE_SERIAL);
    });
    
    return cl_url_session_manager_queue;
}

dispatch_queue_t persistance_session_manager_queue() {
    
    static dispatch_queue_t persistance_session_manager_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        persistance_session_manager_queue = dispatch_queue_create("com.youyue.persistance.session.manager.processing", DISPATCH_QUEUE_SERIAL);
    });
    
    return persistance_session_manager_queue;
}

@interface CLAppLogic ()
@property (nonatomic, strong, readwrite) id data;
@property (nonatomic, weak, readwrite) id<CTAPIManagerInterceptor> interceptor;


@end

@implementation CLAppLogic

#pragma mark - life cycle

-(instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.data = nil;
        self.paramSource = nil;
        self.delegate = nil;
        self.interceptor = self;
        if ([self conformsToProtocol:@protocol(CLAppLogicDataSource) ]) {
            
            self.child = (id<CLAppLogicDataSource>)self;
        } else {
            NSException *exception = [[NSException alloc] initWithName:@"error" reason:@"子类必须遵守数据转换这个协议" userInfo:nil];
            @throw exception;
        }
        
    }
    
    return self;
}

-(void)dealloc {
    
#ifdef MYDEBUG
    NSLog(@"logic 销毁:%@", object_getClass(self));
#endif
    
}

-(void)loadData {
    
    dispatch_async(self.netQueue, ^{
        
        [self.apiManager loadData];
    });
}

#pragma mark - CTAPIManagerInterceptor

-(BOOL)manager:(CTAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *)parsms {
    if ([self.child respondsToSelector:@selector(logic:loadDataFromLocal:)]) {
        self.data = [self.child logic:self loadDataFromLocal:nil];
        if (self.data) {
            
            if ([manager.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                [manager.delegate managerCallAPIDidSuccess:manager];
            }
            return NO;
        } else {
            
            return YES;
        }
    }
    self.apiManager = manager;
    return YES;
    
}

-(BOOL)manager:(CTAPIBaseManager *)manager beforePerformFailWithResponse:(CLURLResponse *)response {
    
    if ([self.child respondsToSelector:@selector(logic:reformNetWorking:)]) {

        self.data = [self.child logic:self reformNetWorking:kApiManagerNetWorkingError];
        if (!self.data) {
            
            return YES;
            
        } else {
         
            if ([manager.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                [manager.delegate managerCallAPIDidSuccess:manager];
            }
            return NO;
        }
    }
    
    return NO;
}

-(BOOL)manager:(CTAPIBaseManager *)manager beforePerformSuccessWithResponse:(CLURLResponse *)response {
    
    if ([self.child respondsToSelector:@selector(logic:reformNetWorking:)]) {
        
        NSDictionary *dict = response.content;
        self.data = [self.child logic:self reformNetWorking:dict];
        if (!self.data) {
            if ([manager.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
                [manager.delegate managerCallAPIDidFailed:manager];
                return NO;
            }
        }
    }
    
    return YES;
    
}

#pragma mark - Public methods
-(id)fetchDataWithReformer:(id<CLAppLogicDataReform>)reformer {
    
    if ([reformer respondsToSelector:@selector(logic:withTheManager:reformData:)]) {
        
       __block id result;
        dispatch_sync(self.persistanceQueue, ^{
            
           result = [reformer logic:self withTheManager:self.apiManager reformData:self.data];
        });
        
        return result;
    }
    
    return nil;
}


#pragma mark - getters and setters

-(dispatch_queue_t)netQueue {
    
    return url_session_manager_queue();
}

-(dispatch_queue_t)persistanceQueue {
    
    return persistance_session_manager_queue();
}
-(CTAPIBaseManager *)apiManager {
    
    NSParameterAssert(@"subClass must rewrite the mehtod");
    return nil;
}

@end
