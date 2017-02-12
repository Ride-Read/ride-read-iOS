//
//  YYBaiscTableViewCell.m
//  优悦一族
//
//  Created by 亮 on 2016/12/20.
//  Copyright © 2016年 umed. All rights reserved.
//

#import "YYBaiscTableViewCell.h"

@interface YYBaiscTableViewCell ()
@property (nonatomic, strong) CAShapeLayer *topLine;
@property (nonatomic, strong) CAShapeLayer *bottomLine;

@end
@implementation YYBaiscTableViewCell

-(instancetype)init {
    self = [super init];
    [self setLineView];
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setLineView];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setLineView];
    }
    return self;
}
-(void)setLineView {
    
    [self.contentView.layer addSublayer:self.topLine];
    [self.contentView.layer addSublayer:self.bottomLine];
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    UIBezierPath *topPath = [[UIBezierPath alloc] init];
    [topPath moveToPoint:CGPointMake(0, 0)];
    [topPath addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    self.topLine.path = topPath.CGPath;
    
    UIBezierPath *bottom = [[UIBezierPath alloc] init];
    [bottom moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [bottom addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    self.bottomLine.path = bottom.CGPath;
}

#pragma mark - getters and setters
-(CAShapeLayer *)topLine {
    
    if (!_topLine) {
        
        _topLine = [CAShapeLayer layer];
        _topLine.lineWidth = 1.0;
        _topLine.strokeColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00].CGColor;
        _topLine.hidden = YES;
    }
    return _topLine;
}

-(CAShapeLayer *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [CAShapeLayer layer];
        _bottomLine.lineWidth = 1.0;
        _bottomLine.strokeColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00].CGColor;
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
    
}

-(void)setShowTopLine:(BOOL)showTopLine {
    
    _showTopLine = showTopLine;
    if (showTopLine) {
        self.topLine.hidden = NO;
    } else {
        self.topLine.hidden = YES;
    }
    
}

-(void)setShowBottomLine:(BOOL)showBottomLine {
    
    _showBottomLine = showBottomLine;
    if (showBottomLine) {
        
        self.bottomLine.hidden = NO;
    } else {
        
        self.bottomLine.hidden = YES;
    }
}

-(void)setLineColor:(UIColor *)lineColor {
    
    _lineColor = lineColor;
    self.bottomLine.strokeColor = lineColor.CGColor;
    self.topLine.strokeColor = lineColor.CGColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
