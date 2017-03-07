//
//  QYFriendCycleCellLayout.m
//  骑阅
//
//  Created by chen liang on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYFriendCycleCellLayout.h"
#import "define.h"
#import "UIColor+QYHexStringColor.h"

@implementation QYTextLinePositionModifier

- (instancetype)init {
    
    self = [super init];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
      
        _lineHeightMultiple = 1.34;
    } else {
        _lineHeightMultiple = 1.3125;
    }
    return self;
}

- (void)modifyLines:(NSArray<YYTextLine *> *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}
- (id)copyWithZone:(NSZone *)zone {
    QYTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForlineConut:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end
@implementation QYFriendCycleCellLayout

+ (instancetype)friendStatusCellLayout:(NSDictionary *)status {
    
    return [[self alloc] initWithStatus:status];
}
- (instancetype)initWithStatus:(NSDictionary *)status {
    
    self = [super init];
    _status = status;
    return self;
}
- (void)layout {
    
    _marginTop = kQYCellTopMargin;
    _profileHeight = 0;
    _contentHeight = 0;
    _picHeight = 0;
    [self layoutProfile];
    [self layoutContent];
    [self layoutTime];
    [self layoutTool];
    
}
- (void)layoutProfile {
    
    NSString *userName = _status[kuser][kusername];
    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc] initWithString:userName];
    nameText.yy_font = [UIFont systemFontOfSize:15];
    nameText.yy_color = [UIColor colorWithHexString:@"#000000"];
    nameText.yy_lineBreakMode = NSLineBreakByCharWrapping;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kQYCellNameWidth, 999)];
    _nameLayout = [YYTextLayout layoutWithContainer:container text:nameText];
    _profileHeight = 35;
}

- (void)layoutTime {
    
    NSString *create = _status[kuser][kcreated_at];
    NSMutableAttributedString *createText = [[NSMutableAttributedString alloc] initWithString:create];
    createText.yy_font = [UIFont systemFontOfSize:15];
    createText.yy_color = [UIColor colorWithHexString:@"#000000"];
    createText.yy_lineBreakMode = NSLineBreakByCharWrapping;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kQYCellNameWidth, 999)];
    _nameLayout = [YYTextLayout layoutWithContainer:container text:createText];
    _profileHeight = 35;

}

- (void)layoutContent {
    
    NSString *time = _status[kstatus][kcreated_at];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:time];
    text.yy_color = [UIColor colorWithHexString:@"#555555"];
    text.yy_font = [UIFont systemFontOfSize:10];
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kQYCellContentTextWidth, 999);
    
    _timeLayout = [YYTextLayout layoutWithContainer:container text:text];
}
- (void)layoutPicture {
    
    NSArray *picturs = _status[kstatus][kthumbs];
    switch (picturs.count) {
        case 1:
        {
            _picSize = CGSizeMake(131, 131);
            _picHeight = 131;
            break;
        }
        case 2:{
            
            _picSize = CGSizeMake(105, 105);
            _picHeight = 105;
        }
        case 3:{
            
             _picSize = CGSizeMake(95, 95);
            _picHeight = 95;
        }
        case 4:case 5:case 6:{
            
            _picSize = CGSizeMake(95, 95);
            _picHeight = 190;
        }
            
        default:{
            _picSize = CGSizeMake(95, 95);
            _picHeight = 95 * 3;
        }
            break;
    }
}

- (void)layoutTool {
    
    NSString *site = _status[kstatus][ksite];
    NSString *sizeLeght = _status[kstatus][ksiteLength];
    NSMutableAttributedString *siteText = [[NSMutableAttributedString alloc] initWithString:site];
    NSMutableAttributedString *sizeLegthText = [[NSMutableAttributedString alloc] initWithString:sizeLeght];
    siteText.yy_font = [UIFont systemFontOfSize:11];
    siteText.yy_color = [UIColor colorWithHexString:@"#555555"];
    
    sizeLegthText.yy_font = [UIFont systemFontOfSize:11];
    sizeLegthText.yy_color = [UIColor colorWithHexString:@"#555555"];
    
    YYTextContainer *siteContainer = [YYTextContainer containerWithSize:CGSizeMake(95, 999)];
    YYTextContainer *siteLengthContainer = [YYTextContainer containerWithSize:CGSizeMake(95, 999)];
    _sizeLayout = [YYTextLayout layoutWithContainer:siteContainer text:siteText];
    _sizeLengthLayout = [YYTextLayout layoutWithContainer:siteLengthContainer text:sizeLegthText];
    
}

#pragma mark - Public method
- (void)updateDate {
    
    [self layoutTime];
}
@end
