//
//  CTServiceFactory.h
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTService.h"

@interface CTServiceFactory : NSObject

+(instancetype)sharedInstance;

-(CTService<CTServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier;

@end
