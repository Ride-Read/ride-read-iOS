
#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setQY_height:(CGFloat)QY_height
{
    CGRect rect = self.frame;
    rect.size.height = QY_height;
    self.frame = rect;
}

- (CGFloat)QY_height
{
    return self.frame.size.height;
}

- (CGFloat)QY_width
{
    return self.frame.size.width;
}
- (void)setQY_width:(CGFloat)QY_width
{
    CGRect rect = self.frame;
    rect.size.width = QY_width;
    self.frame = rect;
}

- (CGFloat)QY_x
{
    return self.frame.origin.x;
    
}

- (void)setQY_x:(CGFloat)QY_x
{
    CGRect rect = self.frame;
    rect.origin.x = QY_x;
    self.frame = rect;
}

- (void)setQY_y:(CGFloat)QY_y
{
    CGRect rect = self.frame;
    rect.origin.y = QY_y;
    self.frame = rect;
}

- (CGFloat)QY_y
{

    return self.frame.origin.y;
}

- (void)setQY_centerX:(CGFloat)QY_centerX
{
    CGPoint center = self.center;
    center.x = QY_centerX;
    self.center = center;
}

- (CGFloat)QY_centerX
{
    return self.center.x;
}

- (void)setQY_centerY:(CGFloat)QY_centerY
{
    CGPoint center = self.center;
    center.y = QY_centerY;
    self.center = center;
}

- (CGFloat)QY_centerY
{
    return self.center.y;
}
@end
