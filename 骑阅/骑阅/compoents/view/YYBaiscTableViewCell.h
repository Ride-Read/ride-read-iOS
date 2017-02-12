//
//  YYBaiscTableViewCell.h
//  优悦一族
//
//  Created by 亮 on 2016/12/20.
//  Copyright © 2016年 umed. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 this cell is basic for all cell view 
 to show the basic message for all cell 
 eg:the bottom line show or hide default is Hiden
 */
@interface YYBaiscTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL showBottomLine;
@property (nonatomic, assign) BOOL showTopLine;
@property (nonatomic, strong) UIColor *lineColor;

@end
