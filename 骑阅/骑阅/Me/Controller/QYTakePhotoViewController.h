//
//  QYTakePhotoViewController.h
//  骑阅
//
//  Created by 谢升阳 on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicViewController.h"
#import "QYUser.h"

@interface QYTakePhotoViewController : QYBasicViewController

/** User */
@property (nonatomic,strong) QYUser * user;
@property (nonatomic, copy) void(^callBackIcon)(UIImage *image,NSString *url);

@end
