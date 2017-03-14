//
//  CLAppLogic.h
//  CLNetWorking
//
//  Created by 亮 on 16/9/18.
//  Copyright © 2016年 亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAPIBaseManager.h"
extern dispatch_queue_t url_session_manager_queue();
extern dispatch_queue_t persistance_session_manager_queue();
FOUNDATION_EXPORT  NSString *const kApiManagerNetWorkingError;

typedef NS_ENUM(NSUInteger,CLAppLogicDataPolicy) {
    
    CLAppLogicDataPolicyDefault,
    CLAppLogicDataPolicyNetWork,
    CLAppLogicDataPolicyDisk,
};
@class CLAppLogic;
//经过AppLogic这一层的协调数据将是从同步后的本地数据库中获得

@protocol CLAppLogicDelegate <NSObject>

@required
//实现这个协议，可以获得子类数据同步后返回的数据
-(id)logic:(CLAppLogic *)logic withTheManager:(CTAPIBaseManager *)manager reformData:(id)data;

@end

@protocol CLAppLogicDataSource <NSObject>

@required

/**
 子类实现这个协议，把网络数据同步到本地数据库，同步完成把同步结果返回，或者当请求失败的时候拉取本地数据，把本地数去返回

 @param logic self
 @param data  网络请求的数据，当请求失败的时候无数据

 @return data经过处理后得到的数据
 */
-(id)logic:(CLAppLogic *)logic reformNetWorking:(id)data;

@optional
//已经同步的数据，每个子类中如果已经存在同步标记，可以实现这个方法，把数据返回
-(id)logic:(CLAppLogic *)logic loadDataFromLocal:(id)data;
@end

@interface CLAppLogic : NSObject<CTAPIManagerInterceptor>
/**
 *  用来转接这些代理给网络层。
 */
@property (nonatomic, weak) id<CTAPIManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<CTAPIManagerParamSource> paramSource;
@property (nonatomic, weak, readonly) id<CTAPIManagerInterceptor> interceptor;
@property (nonatomic, assign) CLAppLogicDataPolicy policy;
@property (nonatomic, assign, readonly) dispatch_queue_t netQueue;
@property (nonatomic, assign, readonly) dispatch_queue_t persistanceQueue;
@property (nonatomic, strong, readonly) id data;
@property (nonatomic, weak) NSObject <CLAppLogicDataSource> *child;
@property (nonatomic, strong) CTAPIBaseManager *apiManager;


-(void)loadData;
-(id)fetchDataWithReformer:(id<CLAppLogicDelegate>)reformer;



@end
