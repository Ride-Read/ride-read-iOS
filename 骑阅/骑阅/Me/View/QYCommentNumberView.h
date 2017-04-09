//
//  QYCommentNumberView.h
//  骑阅
//
//  Created by chen liang on 2017/4/9.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface QYCommentNumberView : UIView
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (nonatomic, weak) NSArray * data;


+ (instancetype)loadCommentNumberView;
@end
