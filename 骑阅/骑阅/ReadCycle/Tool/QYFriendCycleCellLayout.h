//
//  QYFriendCycleCellLayout.h
//  骑阅
//
//  Created by chen liang on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleBasicLayout.h"

@interface QYFriendCycleCellLayout : QYCycleBasicLayout

@property (nonatomic, assign) CGFloat toolHeight;
@property (nonatomic, strong) YYTextLayout *sizeLayout;
@property (nonatomic, strong) YYTextLayout *sizeLengthLayout;
@property (nonatomic, strong) YYTextLayout *praiseLayout;
@property (nonatomic, strong) YYTextLayout *commentLayout;

@end
@interface QYTextLinePositionModifier : NSObject<YYTextLinePositionModifier>
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) CGFloat paddingTop;
@property (nonatomic, assign) CGFloat paddingBottom;
@property (nonatomic, assign) CGFloat lineHeightMultiple;

- (CGFloat)heightForlineConut:(NSUInteger)lineCount;


@end
