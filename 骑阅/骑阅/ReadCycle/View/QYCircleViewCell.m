//
//  QYCircleViewCell.m
//  骑阅
//
//  Created by chen liang on 2017/3/2.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCircleViewCell.h"
#import "Masonry.h"
#import "UIColor+QYHexStringColor.h"
#import "UIImageView+WebCache.h"

@implementation QYCircleViewPeople
-(instancetype)init {
    
    self = [super init];
    return self;
}

#pragma mark - Private method
-(void)setupUI {
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.attention];
}

#pragma mark - Setter and Getters
-(UIImageView *)icon {
    
    if (!_icon) {
        
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

-(UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}

-(UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"555555"];
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _timeLabel;
}
-(UIButton *)attention {
    
    if (!_attention) {
        
        _attention = [[UIButton alloc] init];
    }
    return _attention;
}

@end

@implementation QYCircleViewContent



@end
@implementation QYCircleViewImageView

- (instancetype)init {
    
    self = [super init];
    return self;
}

- (void)initializeView {
    
    NSArray *array = _cell.layout.status[kstatus][kthumbs];
    CGSize picSize = _cell.layout.picSize;
    NSMutableSet *set = [NSMutableSet setWithArray:self.subviews];
    if (array.count > 0) {
        
        UIImageView *pre;
        for (int i = 0; i < array.count; i++) {
            
            NSString *url = array[i];
            UIImageView *pic = [set anyObject];
            if (!pic) {
                pic = [UIImageView new];
                [self addSubview:pic];
            }
            
            [pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            [set removeObject:pic];
            if (!pre) {
                
                pic.frame = CGRectMake(0, 0, picSize.width, picSize.height);
            } else {
                
            
                pic.frame = CGRectOffset(pre.frame, picSize.width + 5, 0);
                if (i == 3) {
                    
                    pic.frame = CGRectMake(0, pic.frame.origin.y + picSize.height + 5, picSize.width, picSize.height);
                }
                if (i == 5) {
                    
                    pic.frame = CGRectMake(0, pic.frame.origin.y + picSize.height + 5, picSize.width, picSize.height);
                }
            }
            pre = pic;

        }
               for (UIImageView *imageView in set) {
            
            imageView.frame = CGRectZero;
        }
        
    } else {
        
        
        UIImageView *pic = [set anyObject];
        pic.frame = CGRectZero;
    }
   
}

@end
@implementation QYCircleViewCellContent



@end
@implementation QYCircleViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
