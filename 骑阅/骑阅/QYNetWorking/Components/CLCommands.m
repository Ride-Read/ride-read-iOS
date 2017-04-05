//
//  CLCommands.m
//  优悦一族
//
//  Created by 亮 on 2016/11/22.
//  Copyright © 2016年 umed. All rights reserved.
//

#import "CLCommands.h"

@interface CLCommands ()

@end
@implementation CLCommands

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.apiManager = nil;
        self.next = nil;
        if ([self conformsToProtocol:@protocol(CLCommandDataDelegate) ]) {
            
            self.child = (id<CLCommandDataDelegate>)self;
        }
    }
    return self;
    
}

#pragma mark publick method
-(void)execute {
    
    [self.apiManager loadData];
}

-(NSDictionary *)paramsFormNextCommand:(CTAPIBaseManager *)curentManager {
    
    return nil;
}
#pragma mark - CTAPIManagerParamSource

-(NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (self.params) {
        
        return self.params;
    }
    if ([self.dataSource respondsToSelector:@selector(paramsForcommand:)]) {
        
       return [self.dataSource paramsForcommand:self];
    }
    return nil;
}
#pragma mark - CTAPIManagerCallbackDelegate

-(void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if ([self.delegate respondsToSelector:@selector(command:didFaildWith:)]) {
        
        [self.delegate command:self didFaildWith:manager];
    }
    
}

-(void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if (self.next) {
        
        
        if ([self.delegate respondsToSelector:@selector(command:successMessage:)]) {
            
            [self.delegate command:self successMessage:manager];
        }
        self.next.params = [self paramsFormNextCommand:manager];
        [self.next execute];
        
    } else {
        
        if ([self.delegate respondsToSelector:@selector(command:didSuccess:)]) {
            
            [self.delegate command:self didSuccess:manager];
        }
    }
    
}

-(CTAPIBaseManager *)apiManager {
    
    NSParameterAssert(@"subclass must reuse this method");
    return nil;
}
@end
