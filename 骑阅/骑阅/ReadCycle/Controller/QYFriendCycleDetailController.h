//
//  QYFriendCycleDetailController.h
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

typedef void(^refreshBlock)();
#import "QYBasicNeedLocationController.h"
#import "QYDetailCycleLayout.h"
#import "QYSendCommentView.h"
#import "QYCircleViewCell.h"
#include "YYBasicTableView.h"


@interface QYFriendCycleDetailController :QYBasicNeedLocationController<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYFriendCycleCellLayout *layout;
@property (nonatomic, strong) QYCircleViewCell *cell;
@property (nonatomic, copy) refreshBlock refresh;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) QYSendCommentView *sendView;


- (void)analyseData;
- (void)sendView:(QYSendCommentView *)view acitonSuccess:(NSMutableDictionary *)info;

@end
