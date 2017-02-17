//
//  QYViewClickProtocol.h
//  骑阅
//
//  Created by chen liang on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol QYViewClickProtocol <NSObject>
@optional;
-(void)clickCustomView:(UIView *)customView index:(NSInteger)index;
@end
