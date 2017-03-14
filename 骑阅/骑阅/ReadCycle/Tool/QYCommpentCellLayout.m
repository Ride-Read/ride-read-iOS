//
//  QYCommpentCellLayout.m
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCommpentCellLayout.h"
#import "define.h"
#import "UIColor+QYHexStringColor.h"
#import "NSString+QYDateString.h"
#import "NSString+QYRegular.h"

@implementation QYCommpentCellLayout

+ (instancetype)commentLayout:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    self.status = dict;
    [self layout];
    return self;
}

- (void)layout {
    
    [self layoutNikeName];
    [self layoutTime];
    [self layoutComment];
    _height = kQYCommentCellTopMargin + _nickHeight + kQYCommentCellTimeToNike + _timeHeight + kQYCommentCellCommentToTim + _coommentHeight + kQYCommentCellBottomMargin;
}
- (void)updateDate {
    
    [self layoutTime];
}

- (void)layoutNikeName {
    
    NSString *nikeName = self.status[knickname];
    NSMutableAttributedString *nickNameText = [[NSMutableAttributedString alloc] initWithString:nikeName];
    nickNameText.yy_font = [UIFont systemFontOfSize:12];
    nickNameText.yy_color = [UIColor colorWithHexString:@"#555555"];
    
    YYTextContainer *nickContainer = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 56, 999)];
    _nikeNameLayout = [YYTextLayout layoutWithContainer:nickContainer text:nickNameText];
    _nickHeight = _nikeNameLayout.textBoundingSize.height;
}

- (void)layoutTime {
    
    
    NSNumber *time = self.status[kcreated_at];
    NSString *timeString = [NSString dateStringWithTime:time.doubleValue];
    NSMutableAttributedString *timeText = [[NSMutableAttributedString alloc] initWithString:timeString];
    timeText.yy_font = [UIFont systemFontOfSize:10];
    timeText.yy_color = [UIColor colorWithHexString:@"#555555"];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 56, 999)];
    _timeLayout = [YYTextLayout layoutWithContainer:container text:timeText];
    _timeHeight = _timeLayout.textBoundingSize.height;
}

- (void)layoutComment {
    
    NSString *comment = self.status[kmsg];
    NSMutableAttributedString *comentText = [[NSMutableAttributedString alloc] initWithString:comment];
    comentText.yy_color = [UIColor colorWithHexString:@"#555555"];
    comentText.yy_font = [UIFont systemFontOfSize:14];
    NSRange result = [comment regularReply:comment];
    if (result.location != NSNotFound) {
        
        [comentText yy_setColor:[UIColor colorWithHexString:@"#52CAC1"] range:result];
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithHexString:@"#52CAC1"]];
        [comentText yy_setTextHighlight:highlight range:result];
        
        //[comentText yy_setTextHighlightRange:result color:[UIColor colorWithHexString:@"#52CAC1"] backgroundColor:nil userInfo:@{kuser:self.status[kuser]}];
        
    }

        
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 56, 999)];
    _commentLayout = [YYTextLayout layoutWithContainer:container text:comentText];
    _coommentHeight = _commentLayout.textBoundingSize.height;
}

@end
