//
//  UIColor+QYHexStringColor.m
//  骑阅
//
//  Created by 亮 on 2017/2/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "UIColor+QYHexStringColor.h"

@implementation UIColor (QYHexStringColor)

CGFloat colorComponentFrom(NSString * string,NSUInteger start,NSUInteger length) {
    
    NSString *subString = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ?subString:[NSString stringWithFormat:@"%@%@",subString,subString];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
    
}

+(UIColor *)colorWithHexString:(NSString *)hexString {
    
    CGFloat alpha,red,blue,green;
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3://#RGB
        {
            alpha = 1.0f;
            red = colorComponentFrom(colorString, 0, 1);
            green = colorComponentFrom(colorString, 1, 1);
            blue = colorComponentFrom(colorString, 2, 1);
            
        } break;
        case 4://#ARGB
        {
            alpha = colorComponentFrom(colorString, 0, 1);
            red = colorComponentFrom(colorString, 1, 1);
            green = colorComponentFrom(colorString, 2, 1);
            blue = colorComponentFrom(colorString, 3, 1);
            
        }break;
            
        case 6://#RRGGBB
        {
            alpha = 1.0f;
            red = colorComponentFrom(colorString, 0, 2);
            green = colorComponentFrom(colorString, 2, 2);
            blue = colorComponentFrom(colorString, 4, 2);
            
        }break;
            
        case 8://#AARRGGBB
        {
            alpha = colorComponentFrom(colorString, 0, 2);
            red = colorComponentFrom(colorString, 2, 2);
            green = colorComponentFrom(colorString, 4, 2);
            blue = colorComponentFrom(colorString, 6, 2);
            
        }
            
        default:
            return nil;
            break;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];

}
@end
