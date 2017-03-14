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
    [self layout];
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
    [self layoutPicture];
    [self layoutPraiseAndCommpent];
    [self layoutTool];
    _height = _profileHeight +  _contentHeight+ _picHeight+_toolHeight ;
}
- (void)layoutProfile {
    
    NSString *userName = _status[kusername];
    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc] initWithString:userName];
    nameText.yy_font = [UIFont systemFontOfSize:15];
    nameText.yy_color = [UIColor colorWithHexString:@"#000000"];
    nameText.yy_lineBreakMode = NSLineBreakByCharWrapping;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kQYCellNameWidth, 999)];
    _nameLayout = [YYTextLayout layoutWithContainer:container text:nameText];
    _profileHeight = 35 + kQYCellTopMargin;
}

- (void)layoutTime {
    
    NSString *create = _status[kcreated_at];
    NSMutableAttributedString *createText = [[NSMutableAttributedString alloc] initWithString:create];
    createText.yy_font = [UIFont systemFontOfSize:10];
    createText.yy_color = [UIColor colorWithHexString:@"#555555"];
    createText.yy_lineBreakMode = NSLineBreakByCharWrapping;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kQYCellNameWidth, 999)];
    _timeLayout = [YYTextLayout layoutWithContainer:container text:createText];

}

- (void)layoutContent {
    
    NSString *conent = _status[kmsg];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:conent];
    text.yy_color = [UIColor colorWithHexString:@"#000000"];
    text.yy_font = [UIFont systemFontOfSize:16];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(self.contentLayoutWidth, 999)];
    //container.size = CGSizeMake(kQYCellContentTextWidth, 999);
    
    _contentLayout = [YYTextLayout layoutWithContainer:container text:text];
    _contentHeight = _contentLayout.textBoundingSize.height + self.contentViewMarginTop;
}
- (void)layoutPicture {
    
   // CGFloat linePdding = 0.f;
    NSArray *picturs = _status[kthumbs];
    switch (picturs.count) {
        case 1:
        {
            _picSize = CGSizeMake(self.pictureLayoutOneWidth, self.pictureLayoutOneWidth);
            _picHeight = self.pictureLayoutOneWidth;
            break;
        }
        case 2:{
            
            _picSize = CGSizeMake(self.pictureLayoutTwoWidth, self.pictureLayoutTwoWidth);
            _picHeight = self.pictureLayoutTwoWidth;
            break;
        }
        case 3:{
            
            _picSize = CGSizeMake(self.pictureLayoutMoreThanThreeWidth,self.pictureLayoutMoreThanThreeWidth);
            _picHeight = self.pictureLayoutMoreThanThreeWidth;
            break;
        }
        case 4:case 5:case 6:{
            
            _picSize = CGSizeMake(self.pictureLayoutMoreThanThreeWidth,self.pictureLayoutMoreThanThreeWidth);
            _picHeight =self.pictureLayoutMoreThanThreeWidth * 2 + 3.5;
            break;
        }
            
        default:{
            _picSize = CGSizeMake(self.pictureLayoutMoreThanThreeWidth,self.pictureLayoutMoreThanThreeWidth);
            _picHeight = self.pictureLayoutMoreThanThreeWidth * 3 + 7;
        }
            break;
    }
    _picHeight = _picHeight + 14.5;
}

- (void)layoutTool {
    
    NSString *site = _status[ksite];
    NSString *sizeLeght = _status[ksiteLength];
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
    _toolHeight = 75;
    
}

- (void)layoutPraiseAndCommpent {
    
    NSArray *praiseArray = _status[kpraise];
    NSArray *commentArray = _status[kcomment];
    NSString *praise = [NSString stringWithFormat:@"%ld",praiseArray.count];
    NSString *comment = [NSString stringWithFormat:@"%ld",commentArray.count];
    if ([praise isEqualToString:@"0"]) {
        
        praise = @" ";
    }
    if ([comment isEqualToString:@"0"]) {
        
        comment = @" ";
    }
    
    NSMutableAttributedString *prasiseText = [[NSMutableAttributedString alloc] initWithString:praise];
    NSMutableAttributedString *commentText = [[NSMutableAttributedString alloc] initWithString:comment];
    prasiseText.yy_font = [UIFont systemFontOfSize:12];
    prasiseText.yy_color = [UIColor colorWithHexString:@"#555555"];
    
    commentText.yy_font = [UIFont systemFontOfSize:12];
    commentText.yy_color = [UIColor colorWithHexString:@"#555555"];
    
    YYTextContainer *praiseContainer = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, 9999)];
    YYTextContainer *commentContainer = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, 9999)];
    
    _praiseLayout = [YYTextLayout layoutWithContainer:praiseContainer text:prasiseText];
    
    _commentLayout = [YYTextLayout layoutWithContainer:commentContainer text:commentText];
    
}

#pragma mark - Public method
- (void)updateDate {
    
    [self layoutTime];
}

#pragma mark - setter and getter

- (CGFloat)contentViewMarginTop {
    
    return 12.5;
}
- (CGFloat)contentLayoutWidth {
    
    return kScreenWidth - 63 - 30;
}

- (CGFloat)pictureLayoutOneWidth {
    
    return 131;
}

- (CGFloat)pictureLayoutTwoWidth {
    
    return 105;
}

- (CGFloat)pictureLayoutMoreThanThreeWidth {
    
    return cl_caculation_3x(180);
}
@end
