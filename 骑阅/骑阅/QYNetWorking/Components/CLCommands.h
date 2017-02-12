//
//  CLCommands.h
//  优悦一族
//
//  Created by 亮 on 2016/11/22.
//  Copyright © 2016年 umed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAPIBaseManager.h"
#import "CLAppLogic.h"

@class CLCommands;
@protocol CLCommandDelegate <NSObject>

@required
//如果是做串行调用，两个方法中只会执行一次
-(void)command:(CLCommands *)commands didFaildWith:(CTAPIBaseManager *)apiManager;
-(void)command:(CLCommands *)commands didSuccess:(CTAPIBaseManager *)apiManager;

//如果一个recvier关心这次数据，则可以实现这个方法，在这个方法中取数据
@optional
-(void)command:(CLCommands *)commands successMessage:(CTAPIBaseManager *)apiManager;

@end

@protocol CLCommandDataDelegate <NSObject>

@optional

-(void)command:(CLCommands *)commands successMessage:(id)message;

@end

@protocol CLCommandDataSource <NSObject>

-(NSDictionary *)paramsForcommand:(CLCommands *)command;

@end
@interface CLCommands : NSObject<CTAPIManagerCallBackDelegate,CTAPIManagerParamSource>
@property (nonatomic, strong) CLCommands *next;
@property (nonatomic, strong) CTAPIBaseManager *apiManager;
//如果是通过Logic的可以重写execute方法，通过logic来执行
@property (nonatomic, strong) CLAppLogic *logic;
@property (nonatomic, weak) id <CLCommandDelegate> delegate;
@property (nonatomic, weak) id <CLCommandDataSource> dataSource;

//这个参数对于做串行调用的时候，如果有值怎直接拿这个做参数，而不是通过代理
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, weak) NSObject <CLCommandDataDelegate> *child;

-(void)execute;

//这个方法如果子类重载了，并且返回的不是Nil,怎command的参数将直接从这里取，
-(NSDictionary *)paramsFormNextCommand:(CTAPIBaseManager *)curentManager;
@end
