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
#import "QYFollowApiManager.h"
#import "QYUnfollowApiManager.h"
#import "QYFromIconLickViewController.h"
#import "QYPictureLookController.h"
#import "QYLookPictureTransionDelegate.h"
#import "QYThumbsViewController.h"

@interface QYCircleViewPeople ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYUnfollowApiManager *unApi;
@property (nonatomic, strong) QYFollowApiManager *followApi;
@property (nonatomic, copy) NSString *cuAttN;
@end
@implementation QYCircleViewPeople
-(instancetype)init {
    
    self = [super init];
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(attentionSuccess:) name:kAttetionSuccess object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unAttentionSuccess:) name:kUnAtteionSuccess object:nil];
    
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private method
-(void)setupUI {
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.attention];
}

#pragma mark - paramSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSDictionary *info = self.cell.layout.status;
    NSNumber *cuid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuser_id:info[kuid],kuid:cuid};
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    if ([self.cuAttN isEqualToString:@"attention"]) {
        
        [self attentionSuccess:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kAttetionSuccess object:nil userInfo:@{kuid:self.cell.layout.status[kuid]}];

        return;
    }
    
    [self unAttentionSuccess:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUnAtteionSuccess object:nil userInfo:@{kuid:self.cell.layout.status[kuid]}];

}

- (void)attentionSuccess:(NSNotification *)info {
    
    if (info) {
        
        NSDictionary *dic = info.userInfo;
        NSNumber *usid = dic[kuid];
        NSNumber *cuCyuid = self.cell.layout.status[kuid];
        if (usid.integerValue == cuCyuid.integerValue) {
            
            [self.attention setBackgroundImage:[UIImage imageNamed:@"attentioned"] forState:UIControlStateNormal];
            self.cell.layout.status[kstatus] = @"attentioned";
            self.attention.tag = 1;
            self.cuAttN = @"attentioned";

        }
        return;
    }
    [self.attention setBackgroundImage:[UIImage imageNamed:@"attentioned"] forState:UIControlStateNormal];
    self.cell.layout.status[kstatus] = @"attentioned";
    self.attention.tag = 1;
    self.cuAttN = @"attentioned";

    
}

- (void)unAttentionSuccess:(NSNotification *)info {
    
    if (info) {
        
        NSDictionary *dic = info.userInfo;
        NSNumber *usid = dic[kuid];
        NSNumber *cuCyuid = self.cell.layout.status[kuid];
        if (usid.integerValue == cuCyuid.integerValue) {
            
            [self.attention setBackgroundImage:[UIImage imageNamed:@"attention"] forState:UIControlStateNormal];
            self.cell.layout.status[kstatus] = @"attention";
            self.attention.tag = 0;
            self.cuAttN = @"attention";
            
        }
        return;
    }
    [self.attention setBackgroundImage:[UIImage imageNamed:@"attention"] forState:UIControlStateNormal];
    self.cell.layout.status[kstatus] = @"attention";
    self.attention.tag = 0;
    self.cuAttN = @"attention";
    
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    
}
#pragma mark - Setter and Getters

- (QYUnfollowApiManager *)unApi {
    
    if (!_unApi) {
        
        _unApi = [[QYUnfollowApiManager alloc] init];
        _unApi.delegate = self;
        _unApi.paramSource = self;
    }
    return _unApi;
}

- (QYFollowApiManager *)followApi {
    
    if (!_followApi) {
        
        _followApi = [[QYFollowApiManager alloc] init];
        _followApi.delegate = self;
        _followApi.paramSource = self;
    }
    return _followApi;
}

-(UIImageView *)icon {
    
    if (!_icon) {
        
        _icon = [[UIImageView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickIcon:)];
        [_icon addGestureRecognizer:tap];
        _icon.userInteractionEnabled = YES;
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
        [_attention addTarget:self action:@selector(clickAttent:) forControlEvents:UIControlEventTouchUpInside];
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
        [self layoutAttention];
        
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
    self.cuAttN = _cell.layout.status[kstatus];
    self.attention.tag = [_cell.layout.status[@"tag"] integerValue];
    [self.attention setBackgroundImage:[UIImage imageNamed:_cell.layout.status[kstatus]] forState:UIControlStateNormal];
}

- (void)clickAttent:(UIButton *)sender {
    
    if (sender.tag == 1) {
        
        [UIAlertController alertControler:@"提示" message:@"是否取消关注" leftTitle:@"取消" rightTitle:@"确认" from:self.cell.delegate action:^(NSUInteger index) {
            
            if (index == 1) {
                
                [self.unApi loadData];
                
            }
        }];
        
       
    }
    
    if (sender.tag == 0) {
        
        [UIAlertController alertControler:@"提示" message:@"关注该用户" leftTitle:@"取消" rightTitle:@"确认" from:self.cell.delegate action:^(NSUInteger index) {
            
            if (index == 1) {
                
                [self.followApi loadData];
                
            }
        }];

    }
}

- (void)clickIcon:(UIImageView *)sender {
    
    NSNumber *uid = _cell.layout.status[kuid];
    NSNumber *cuid = [CTAppContext sharedInstance].currentUser.uid;
    if (uid.integerValue == cuid.integerValue) {
        
        return;
    }
    UIViewController *ctr = (UIViewController *)self.cell.delegate;
    QYFromIconLickViewController *useCtr = [[QYFromIconLickViewController alloc] init];
    NSMutableDictionary *info = @{kusername:self.cell.layout.status[kusername]?:@"",kuid:_cell.layout.status[kuid]}.mutableCopy;
    useCtr.user = info;
    useCtr.hidesBottomBarWhenPushed = YES;
    useCtr.title = useCtr.user[kusername];
    [ctr.navigationController pushViewController:useCtr animated:YES];
    
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

@interface QYCircleViewImageView ()
@property (nonatomic, strong) QYLookPictureTransionDelegate *tranasion;

@end
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
                pic.contentMode = UIViewContentModeScaleAspectFill;
                pic.layer.masksToBounds = YES;
                [self addSubview:pic];
                [self addTapAction:pic];
            }
            [pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defalut_circle_icon"]];
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
        }
        for (UIImageView *imageView in set) {
            
            imageView.frame = CGRectZero;
        }
        
    } else {
        
        for (UIImageView *imageView in set) {
            
            imageView.frame = CGRectZero;
        }
    }
   
}

- (void)addTapAction:(UIImageView *)view {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPicture:)];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
}

- (void)clickPicture:(UITapGestureRecognizer *)tap {

    
    QYPictureLookController *look = [[QYPictureLookController alloc] init];
    self.tranasion = [[QYLookPictureTransionDelegate alloc] init];
    NSMutableArray *imageArray = @[].mutableCopy;
    NSMutableArray *rectArray = @[].mutableCopy;
    NSInteger index  = [self.subviews indexOfObject:tap.view];
    look.currentIndex = index;
    look.transitioningDelegate = self.tranasion;
    UIViewController *ctr = (UIViewController *)self.cell.delegate;
    for (UIImageView *imageView in self.subviews) {
        
        if ([imageView isKindOfClass:[UIImageView class]]) {
            
            CGRect rect = [self convertRect:imageView.frame toView:ctr.view];
            rect = CGRectOffset(rect, 0, 64);
            NSValue *value = [NSValue valueWithCGRect:rect];
            [rectArray addObject:value];

        }
    }
    NSValue *value = [rectArray objectAtIndex:index];
    self.tranasion.from = value.CGRectValue;
    MyLog(@"%@",value);
    self.tranasion.to = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    look.transitioningDelegate = self.tranasion;
    look.modalTransitionStyle = UIModalPresentationCustom;
    look.imageArray = self.cell.layout.status[kthumbs];
    look.rectFrame = rectArray;
    [ctr presentViewController:look animated:YES completion:nil];
    
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
    CGFloat margin = 16;
    if (self.site.frame.size.width < 5) {
        
        margin = 0;
    }
    self.siteLength.left = CGRectGetMaxX(self.site.frame) + margin;
    self.siteLength.size = _cell.layout.sizeLengthLayout.textBoundingSize;
    
}
- (void)layoutPraise {
    
   
    self.praiseButton.size = CGSizeMake(cl_caculation_3x(30), cl_caculation_3x(26));
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
     return self;
}

- (void)setCell:(QYCircleViewCell *)cell {
    
    _cell = cell;
    [self removeAllSubviews];
    self.praiseButton = nil;
    self.praiseNumber = nil;
    [self addSubview:self.praiseButton];
    [self addSubview:self.praiseNumber];
    NSArray *array = _cell.layout.status[kpraise];
    if (array.count > 0) {
        
        [_praiseNumber setTitle:[NSString stringWithFormat:@"%ld",array.count] forState:UIControlStateNormal];
        UIButton *pre;
        for (NSDictionary *dict in array) {
            
            UIButton *button = [UIButton new];
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
            NSString *url = dict[kface_url];
            [button sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:kdefault_icon]];
            [self addSubview:button];
            [button addTarget:self action:@selector(clickPraise:) forControlEvents:UIControlEventTouchUpInside];
            pre = button;
        }
    }
}
- (void)clickPraise:(UIButton *)send{
    
    UIViewController *ctr = (UIViewController *)self.cell.delegate;
    QYThumbsViewController *thumbs = [[QYThumbsViewController alloc] init];
    NSDictionary *info = self.cell.layout.status;
    thumbs.mid = info[kmid];
    [ctr.navigationController pushViewController:thumbs animated:YES];
    
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
    
    if (!layout) {
        
        return;
    }
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
