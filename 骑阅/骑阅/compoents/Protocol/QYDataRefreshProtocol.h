//
//  QYDataRefreshProtocol.h
//  骑阅
//
//  Created by chen liang on 2017/4/9.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol QYDataRefreshProtocol <NSObject>

@optional;
-(void)customView:(UIView *)customView refresh:(id)data;

@end
