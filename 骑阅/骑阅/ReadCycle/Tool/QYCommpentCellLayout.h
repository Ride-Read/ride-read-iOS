//
//  QYCommpentCellLayout.h
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYText.h"

#define kQYCommentCellTopMargin 13
#define kQYCommentCellNikeNameToTop 13
#define kQYCommentCellTimeToNike 5
#define kQYCommentCellCommentToTim 14.5
#define kQYCommentCellBottomMargin 12
@interface QYCommpentCellLayout : NSObject
@property (nonatomic, strong) NSDictionary *status;
@property (nonatomic, strong) YYTextLayout *nikeNameLayout;
@property (nonatomic, assign) CGFloat nickHeight;
@property (nonatomic, strong) YYTextLayout *timeLayout;
@property (nonatomic, assign) CGFloat timeHeight;
@property (nonatomic, strong) YYTextLayout *commentLayout;
@property (nonatomic, assign) CGFloat coommentHeight;
@property (nonatomic, assign) CGFloat height;

+ (instancetype)commentLayout:(NSDictionary *)dict;
- (void)updateDate;

@end
