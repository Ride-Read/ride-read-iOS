//
//  YYReplyView.h
//  优悦一族
//
//  Created by 亮 on 2016/12/19.
//  Copyright © 2016年 umed. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYReplyView;
@protocol YYReplyViewDelegate <NSObject>

@optional
-(void)replyView:(YYReplyView *)replyView moreThan:(NSUInteger)maxLeght;

@end
@interface YYReplyTextView : UIView
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, copy, readonly) NSString *lasteString;
@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, weak) YYReplyView *replyView;

@end
@interface YYReplyView :UIView
@property (nonatomic, strong) YYReplyTextView *replyTextView;
@property (nonatomic, weak) id <YYReplyViewDelegate> delegate;

@end
