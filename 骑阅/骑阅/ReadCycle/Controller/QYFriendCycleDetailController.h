//
//  QYFriendCycleDetailController.h
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

typedef void(^refreshBlock)();
#import "QYTranslucentNoViewController.h"
#import "QYFriendCycleCellLayout.h"
#import "QYSendCommentView.h"

@interface QYFriendCycleDetailController :QYTranslucentNoViewController
@property (nonatomic, strong) QYFriendCycleCellLayout *layout;
@property (nonatomic, copy) refreshBlock refresh;
@property (nonatomic, assign) NSInteger type;
- (void)analyseData;
- (void)sendView:(QYSendCommentView *)view acitonSuccess:(NSMutableDictionary *)info;

@end
