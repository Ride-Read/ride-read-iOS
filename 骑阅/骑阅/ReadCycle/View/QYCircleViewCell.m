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
#import "UIView+YYAdd.h"
#import "define.h"
#import "UIButton+QYTitleButton.h"
#import "UIButton+QYTitleButton.h"
@implementation QYCircleViewPeople
-(instancetype)init {
    
    self = [super init];
    [self setupUI];
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
        _icon.backgroundColor = [UIColor blueColor];
    }
    return _icon;
}

-(YYLabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[YYLabel alloc] init];
        _nameLabel.displaysAsynchronously = YES;
    }
    return _nameLabel;
}

-(YYLabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[YYLabel alloc] init];
        _timeLabel.displaysAsynchronously = YES;
    }
    return _timeLabel;
}
-(UIButton *)attention {
    
    if (!_attention) {
        
        _attention = [[UIButton alloc] init];
    }
    return _attention;
}

- (void)setCell:(QYCircleViewCell *)cell {
    
    _cell = cell;
    if (cell.type == QYFriendCycleTypeUser) {
     
        [self layoutTime];
        return;
    }
    if (cell.type == QYFriendCycleTypedetail) {
        
        [self layoutIcon];
        [self layoutNikeName];
        [self layoutTime];
        return;
    }
    
    [self layoutIcon];
    [self layoutAttention];
    [self layoutNikeName];
    [self layoutTime];
}

- (void)layoutNikeName {
    
    self.nameLabel.textLayout = _cell.layout.nameLayout;
    self.nameLabel.left = 63;
    self.nameLabel.top = 18;
    self.nameLabel.width = _cell.layout.nameLayout.textBoundingSize.width;
    self.nameLabel.height = _cell.layout.nameLayout.textBoundingSize.height;
}

- (void)layoutTime {
    
    if (_cell.type == QYFriendCycleTypeUser) {
        
        self.timeLabel.textLayout = _cell.layout.timeLayout;
        self.timeLabel.left = 15;
        self.timeLabel.top = 8.5;
        self.timeLabel.width = _cell.layout.timeLayout.textBoundingSize.width;
        self.timeLabel.height = _cell.layout.timeLayout.textBoundingSize.height;
        return;
    }
    self.timeLabel.textLayout = _cell.layout.timeLayout;
    self.timeLabel.left = 63;
    self.timeLabel.top = 38;
    self.timeLabel.width = _cell.layout.timeLayout.textBoundingSize.width;
    self.timeLabel.height = _cell.layout.timeLayout.textBoundingSize.height;
}
- (void)layoutIcon {
    
    self.icon.left = 15;
    self.icon.top = 16;
    self.icon.width = 35;
    self.icon.height = 35;
    [self.icon sd_setImageWithURL:_cell.layout.status[kface_url] placeholderImage:[UIImage imageNamed:@"defalut_avatar"]];
}

- (void)layoutAttention {
    
    self.attention.left = kScreenWidth - 16 - 41;
    self.attention.top = 20;
    self.attention.width = 41;
    self.attention.height = 28.6;
    [self.attention setBackgroundImage:[UIImage imageNamed:_cell.layout.status[kstatus]] forState:UIControlStateNormal];
}

@end

@implementation QYCircleViewContent

- (instancetype)init {
    
    self = [super init];
    [self addSubview:self.content];
    return self;
}

- (YYLabel *)content {
    
    if (!_content) {
        
        _content = [[YYLabel alloc] init];
        _content.displaysAsynchronously = YES;
    }
    return _content;
}

- (void)setCell:(QYCircleViewCell *)cell {
    
    _cell = cell;
    [self layoutContent];
}

- (void)layoutContent {
    
    self.content.textLayout = _cell.layout.contentLayout;
    
    if (_cell.type == QYFriendCycleTypedetail) {
        
        self.content.left = 16;
        self.content.top = 15;
    } else {
        
        if (_cell.type == QYFriendCycleTypeUser) {
            
            self.content.left = 16;
            self.content.top = kQYCellPaddingText;
            
        } else {
            self.content.left = 63;
            self.content.top = kQYCellPaddingText;
        }
    }
    self.content.width = _cell.layout.contentLayout.textBoundingSize.width;
    self.content.height = _cell.layout.contentLayout.textBoundingSize.height;
    
}
@end

#pragma mark -
@implementation QYCircleViewImageView

- (instancetype)init {
    
    self = [super init];
    return self;
}
- (void)setCell:(QYCircleViewCell *)cell {
    
    _cell = cell;
    [self initializeView];
}

- (void)initializeView {
    
    NSArray *array = _cell.layout.status[kthumbs];
    CGSize picSize = _cell.layout.picSize;
    CGFloat leftMargin;
    if (_cell.type == QYFriendCycleTypedetail || _cell.type == QYFriendCycleTypeUser) {
        
        leftMargin = 16;
    } else {
        
        leftMargin = 50;
        
    }
    NSMutableSet *set = [NSMutableSet setWithArray:self.subviews];
    if (array.count > 0) {
        
        UIImageView *pre;
        for (int i = 0; i < array.count; i++) {
            
            NSString *url = array[i];
            UIImageView *pic = [set anyObject];
            if (!pic) {
                pic = [UIImageView new];
                [self addSubview:pic];
                [self addTapAction:pic];
            }
            
            [pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            [set removeObject:pic];
            if (!pre) {
                
                pic.frame = CGRectMake(leftMargin, 14.5, picSize.width, picSize.height);
            } else {
                
            
                pic.frame = CGRectOffset(pre.frame, picSize.width +3.5, 0);
                if (i == 3) {
                    
                    pic.frame = CGRectMake(leftMargin, pic.frame.origin.y + picSize.height + 3.5, picSize.width, picSize.height);
                }
                if (i == 6) {
                    
                    pic.frame = CGRectMake(leftMargin, pic.frame.origin.y + picSize.height + 3.5, picSize.width, picSize.height);
                }
            }
            pre = pic;
            pic.backgroundColor = [UIColor blueColor];

        }
               for (UIImageView *imageView in set) {
            
            imageView.frame = CGRectZero;
        }
        
    } else {
        
        
        UIImageView *pic = [set anyObject];
        pic.frame = CGRectZero;
    }
   
}

- (void)addTapAction:(UIImageView *)view {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPicture:)];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
}

- (void)clickPicture:(UITapGestureRecognizer *)tap {
    
    if ([self.cell.delegate respondsToSelector:@selector(clickPictureView:imageView:)]) {
        
        UIImageView *view = (UIImageView *)tap.view;
        [self.cell.delegate clickPictureView:self.cell imageView:view];
    }
    
}

@end
@implementation QYCircleViewBottomView

- (instancetype)init {
    
    self = [super init];
    [self setUpUI];
    return self;
}

- (void)setUpUI {
    
    [self addSubview:self.site];
    [self addSubview:self.siteLength];
    [self addSubview:self.praiseButton];
    [self addSubview:self.commentButton];
    [self addSubview:self.praiseNumber];
    [self addSubview:self.commentNumber];
}

- (void)layoutSite {
    
    self.site.textLayout = _cell.layout.sizeLayout;
    self.site.top = 11.5;
    if (_cell.type == QYFriendCycleTypeUser) {
        
        self.site.left = 15;
    } else
        self.site.left = 51;
    self.site.size = _cell.layout.sizeLayout.textBoundingSize;
}

- (void)layoutSiteLength {
    
    self.siteLength.textLayout = _cell.layout.sizeLengthLayout;
    self.siteLength.top = 11.5;
    self.siteLength.left = CGRectGetMaxX(self.site.frame) + 16;
    self.siteLength.size = _cell.layout.sizeLengthLayout.textBoundingSize;
    
}
- (void)layoutPraise {
    
   
    self.praiseButton.size = CGSizeMake(cl_caculation_3x(29), cl_caculation_3x(26));
    self.praiseButton.top = 44;
    self.praiseButton.right = self.praiseNumber.left - 5;
}

- (void)layoutComment {
    
   
    self.commentButton.size = CGSizeMake(cl_caculation_3x(29), cl_caculation_3x(29));
    self.commentButton.top = 44;
    self.commentButton.right = self.commentNumber.left - 4.5;
}

- (void)layoutPraiseNumber {
    
   
    self.praiseNumber.textLayout = _cell.layout.praiseLayout;
    self.praiseNumber.size = _cell.layout.praiseLayout.textBoundingSize;
    self.praiseNumber.right = self.commentButton.left - 22;
    self.praiseNumber.top = 44;
    
}

- (void)layoutCommentNumber {
    
    
    self.commentNumber.textLayout = _cell.layout.commentLayout;
    self.commentNumber.size = _cell.layout.commentLayout.textBoundingSize;
    self.commentNumber.top = 44;
    self.commentNumber.left = kScreenWidth - 16 - self.commentNumber.size.width;
   
}

- (YYLabel *)site {
    
    if (!_site) {
        
        _site = [[YYLabel alloc] init];
        _site.displaysAsynchronously = YES;
    }
    return _site;
}

- (YYLabel *)siteLength {
    
    if (!_siteLength) {
        
        _siteLength = [[YYLabel alloc] init];
        _siteLength.displaysAsynchronously = YES;
    }
    return _siteLength;
}
- (UIButton *)praiseButton {
    
    if (!_praiseButton) {
        _praiseButton = [UIButton new];
         [_praiseButton addTarget:self action:@selector(clickCellBottom:) forControlEvents:UIControlEventTouchUpInside];
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"click_up_normal"] forState:UIControlStateNormal];
    }
    return _praiseButton;
}

- (UIButton *)commentButton {
    
    if (!_commentButton) {
        
        _commentButton = [UIButton new];
        _commentButton.tag = 1;
        [_commentButton addTarget:self action:@selector(clickCellBottom:) forControlEvents:UIControlEventTouchUpInside];
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"read_circle_comment"] forState:UIControlStateNormal];
    }
    return _commentButton;
}
- (YYLabel *)praiseNumber {
    
    if (!_praiseNumber) {
        
        _praiseNumber = [[YYLabel alloc] init];
        _praiseNumber.displaysAsynchronously = YES;
    }
    return _praiseNumber;
}

- (YYLabel *)commentNumber {
    
    if (!_commentNumber) {
        
        _commentNumber = [[YYLabel alloc] init];
        _commentNumber.displaysAsynchronously = YES;
    }
    return _commentNumber;
}

- (void)setCell:(QYCircleViewCell *)cell {
    
    _cell = cell;
    [self layoutSite];
    [self layoutSiteLength];
    [self layoutCommentNumber];
    [self layoutComment];
    [self layoutPraiseNumber];
    [self layoutPraise];
}

- (void)clickCellBottom:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        if ([self.cell.delegate respondsToSelector:@selector(clickPraiseButton:dict:)]) {
            
            [self.cell.delegate clickPraiseButton:self.cell dict:self.cell.layout.status];
        }
    } else {
        
        if ([self.cell.delegate respondsToSelector:@selector(clickCommpentButton:dict:)]) {
            
            [self.cell.delegate clickCommpentButton:self.cell dict:self.cell.layout.status];
        }
    }
    
}
@end

#pragma mark -
@implementation QYCircleViewCellContent

- (instancetype)init {
    
    self = [super init];
    [self setupUI];
    return self;
}

#pragma mark - private method

- (void)setupUI {
    
    [self addSubview:self.profileView];
    [self addSubview:self.contentView];
    [self addSubview:self.pictureView];
    [self addSubview:self.toolView];
}

#pragma mark - setter and getter
- (QYCircleViewPeople *)profileView {
    
    if (!_profileView) {
        
        _profileView = [[QYCircleViewPeople alloc] init];
    }
    return _profileView;
}

- (QYCircleViewContent *)contentView {
    
    if (!_contentView) {
        
        _contentView = [[QYCircleViewContent alloc] init];
    }
    return _contentView;
}

- (QYCircleViewImageView *)pictureView {
    
    if (!_pictureView) {
        
        _pictureView = [[QYCircleViewImageView alloc] init];
    }
    return _pictureView;
}

- (QYCircleViewBottomView *)toolView {
    
    if (!_toolView) {
        
        _toolView = [[QYCircleViewBottomView alloc] init];
    }
    return _toolView;
}

- (void)setCell:(QYCircleViewCell *)cell {
    
    _cell = cell;
    _profileView.frame = CGRectMake(0, 0, kScreenWidth, _cell.layout.profileHeight);
    _profileView.cell = cell;
    _contentView.frame = CGRectMake(0, _cell.layout.profileHeight, kScreenWidth, _cell.layout.contentHeight);
    _contentView.cell = cell;
    _pictureView.frame = CGRectMake(0, CGRectGetMaxY(_contentView.frame), kScreenWidth, _cell.layout.picHeight);
    _pictureView.cell = cell;
    _toolView.frame = CGRectMake(0, CGRectGetMaxY(_pictureView.frame), kScreenWidth, _cell.layout.toolHeight);
    _toolView.cell = cell;
    
}

@end

@implementation QYCircleViewCellPraiseView

- (instancetype)init {
    
    self = [super init];
    [self addSubview:self.praiseButton];
    [self addSubview:self.praiseNumber];
    return self;
}

- (void)setCell:(QYCircleViewCell *)cell {
    
    _cell = cell;
    NSArray *array = _cell.layout.status[kpraise];
    if (array.count > 0) {
        
        [_praiseNumber setTitle:[NSString stringWithFormat:@"%ld",array.count] forState:UIControlStateNormal];
        UIButton *pre;
        for (NSDictionary *dict in array) {
            
            UIButton *button = [UIButton new];
            button.backgroundColor = [UIColor greenColor];
            if (!pre) {
                
                button.frame = CGRectOffset(self.praiseNumber.frame, -34, 0);
            } else {
                
                button.frame = CGRectOffset(pre.frame, -36, 0);
                if (button.frame.origin.x <= (42 + 10)) {
                    button.frame = CGRectZero;
                    self.praiseButton.frame = CGRectMake(16, 12.5, 26, 26);
                } else {
                    
                    self.praiseButton.frame = CGRectOffset(button.frame, -36, 0);
                }
            }
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 13;
            [self addSubview:button];
            pre = button;
        }
    }
}
- (UIButton *)praiseButton {
    
    if (!_praiseButton) {
        _praiseButton = [UIButton new];
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"heart_selected"] forState:UIControlStateNormal];
    
    }
    return _praiseButton;
}

- (UIButton *)praiseNumber {
    
    if (!_praiseNumber) {
        
        _praiseNumber = [UIButton buttonTitle:nil font:11 colco:[UIColor whiteColor]];
        [_praiseNumber setBackgroundColor:[UIColor colorWithRed:0.32 green:0.79 blue:0.76 alpha:1.00]];
        _praiseNumber.frame = CGRectMake(kScreenWidth - 32, 16, 26, 26);
        _praiseNumber.layer.cornerRadius = 13;
    }
    return _praiseNumber;
}

@end
@implementation QYCircleViewCellContentDetail

- (instancetype)init {
    
    self = [super init];
    [self setupUI];
    return self;
}

#pragma mark - private method

- (void)setupUI {
    
    [self addSubview:self.profileView];
    [self addSubview:self.contentView];
    [self addSubview:self.pictureView];
    [self addSubview:self.praiseView];

}

#pragma mark - setter and getter
- (QYCircleViewPeople *)profileView {
    
    if (!_profileView) {
        
        _profileView = [[QYCircleViewPeople alloc] init];
    }
    return _profileView;
}

- (QYCircleViewContent *)contentView {
    
    if (!_contentView) {
        
        _contentView = [[QYCircleViewContent alloc] init];
    }
    return _contentView;
}

- (QYCircleViewImageView *)pictureView {
    
    if (!_pictureView) {
        
        _pictureView = [[QYCircleViewImageView alloc] init];
    }
    return _pictureView;
}
- (QYCircleViewCellPraiseView *)praiseView {
    
    if (!_praiseView) {
        
        _praiseView = [[QYCircleViewCellPraiseView alloc] init];
    }
    return _praiseView;
}

- (void)setCell:(QYCircleViewCell *)cell {
    
    _cell = cell;
    _profileView.frame = CGRectMake(0, 0, kScreenWidth, _cell.layout.profileHeight);
    _profileView.cell = cell;
    _contentView.frame = CGRectMake(0, _cell.layout.profileHeight, kScreenWidth, _cell.layout.contentHeight);
    _contentView.cell = cell;
    _pictureView.frame = CGRectMake(0, CGRectGetMaxY(_contentView.frame), kScreenWidth, _cell.layout.picHeight);
    _pictureView.cell = cell;
    _praiseView.frame = CGRectMake(0, CGRectGetMaxY(_pictureView.frame), kScreenWidth, 60);
    _praiseView.cell = cell;
    
}


@end
@implementation QYCircleViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.type = QYFriendCycleTypelist;
    [self.contentView addSubview:self.statuView];
    [self.statuView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.and.bottom.mas_equalTo(0);
    }];
    return self;
}

- (instancetype)init {
    
    self = [self initWithCycleType:QYFriendCycleTypelist];
    return self;
}

- (instancetype)initWithCycleType:(QYFriendCycleType)type {
    
    self = [super init];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.type = type;
    if (self.type == QYFriendCycleTypelist || self.type == QYFriendCycleTypeUser) {
        self.showBottomLine = YES;
        [self.contentView addSubview:self.statuView];
        [self.statuView mas_makeConstraints:^(MASConstraintMaker *make) {
            
             make.top.and.left.and.right.and.bottom.mas_equalTo(0);
        }];
    } else {
        
        self.showBottomLine = YES;
        [self.contentView addSubview:self.detailView];
        [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.and.left.and.right.and.bottom.mas_equalTo(0);
        }];
    }
    return self;
}
- (void)setLayout:(QYFriendCycleCellLayout *)layout {
    
    _layout = layout;
    if (self.type == QYFriendCycleTypelist || self.type == QYFriendCycleTypeUser) {
        
        _statuView.cell = self;
        
        
    } else {
        
        self.detailView.cell = self;
    }
    
}
- (QYCircleViewCellContent *)statuView {
    
    if (!_statuView) {
        
        _statuView = [[QYCircleViewCellContent alloc] init];
    }
    return _statuView;
}
- (QYCircleViewCellContentDetail *)detailView {
    
    if (!_detailView) {
        
        _detailView = [[QYCircleViewCellContentDetail alloc] init];
    }
    return _detailView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
