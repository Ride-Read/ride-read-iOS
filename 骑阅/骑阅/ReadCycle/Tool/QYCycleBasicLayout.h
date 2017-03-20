//
//  QYCycleBasicLayout.h
//  骑阅
//
//  Created by chen liang on 2017/3/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYText.h"
#import "QYFrIendStatusMessage.h"
#import "YYText.h"
#import "define.h"

// 宽高
#define kQYCellTopMargin 15      // cell 顶部灰色留白
#define kQYCellTitleHeight 36   // cell 标题高度 (例如"仅自己可见")
#define kQYCellPadding 12       // cell 内边距
#define kQYCellPaddingText 10   // cell 文本与其他元素间留白
#define kQYCellPaddingPic 4     // cell 多张图片中间留白
#define kQYCellProfileHeight 56 // cell 名片高度
#define kQYCellCardHeight 70    // cell card 视图高度
#define kQYCellNamePaddingLeft 14 // cell 名字和 avatar 之间留白
#define kQYCellContentWidth (kScreenWidth - 2 * kQYCellPadding) // cell 内容宽度
#define kQYCellNameWidth (kScreenWidth - 110) // cell 名字最宽限制
#define kQYCellContentTextWidth (kScreenWidth - 63 - 30)

#define kQYCellTagPadding 8         // tag 上下留白
#define kQYCellTagNormalHeight 16   // 一般 tag 高度
#define kQYCellTagPlaceHeight 24    // 地理位置 tag 高度

#define kQYCellToolbarHeight 35     // cell 下方工具栏高度
#define kQYCellToolbarBottomMargin 24 // cell 下方灰色留白

// 字体 应该做成动态的，这里只是 Demo，临时写死了。
#define kQYCellNameFontSize 16      // 名字字体大小
#define kQYCellSourceFontSize 12    // 来源字体大小
#define kQYCellTextFontSize 16      // 文本字体大小
#define kQYCellTextFontRetweetSize 16 // 转发字体大小
#define kQYCellCardTitleFontSize 16 // 卡片标题文本字体大小
#define kQYCellCardDescFontSize 12 // 卡片描述文本字体大小
#define kQYCellTitlebarFontSize 14 // 标题栏字体大小
#define kQYCellToolbarFontSize 14 // 工具栏字体大小

// 颜色
#define kQYCellNameNormalColor UIColorHex(333333) // 名字颜色
#define kQYCellNameOrangeColor UIColorHex(f26220) // 橙名颜色 (VIP)
#define kQYCellTimeNormalColor UIColorHex(828282) // 时间颜色
#define kQYCellTimeOrangeColor UIColorHex(f28824) // 橙色时间 (最新刷出)

#define kQYCellTextNormalColor UIColorHex(333333) // 一般文本色
#define kQYCellTextSubTitleColor UIColorHex(5d5d5d) // 次要文本色
#define kQYCellTextHighlightColor UIColorHex(527ead) // Link 文本色
#define kQYCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kQYCellToolbarTitleColor UIColorHex(929292) // 工具栏文本色
#define kQYCellToolbarTitleHighlightColor UIColorHex(df422d) // 工具栏文本高亮色

#define kQYCellBackgroundColor UIColorHex(f2f2f2)    // Cell背景灰色
#define kQYCellHighlightColor UIColorHex(f0f0f0)     // Cell高亮时灰色
#define kQYCellInnerViewColor UIColorHex(f7f7f7)   // Cell内部卡片灰色
#define kQYCellInnerViewHighlightColor  UIColorHex(f0f0f0) // Cell内部卡片高亮时灰色
#define kQYCellLineColor [UIColor colorWithWhite:0.000 alpha:0.09] //线条颜色

#define kQYLinkHrefName @"href" //NSString
#define kQYLinkURLName @"url" //QYURL
#define kQYLinkTagName @"tag" //QYTag
#define kQYLinkTopicName @"topic" //QYTopic
#define kQYLinkAtName @"at" //NSString


@interface QYCycleBasicLayout : NSObject

@property (nonatomic, assign) CGFloat contentLayoutWidth;
@property (nonatomic, assign) CGFloat pictureLayoutOneWidth;
@property (nonatomic, assign) CGFloat pictureLayoutTwoWidth;
@property (nonatomic, assign) CGFloat pictureLayoutMoreThanThreeWidth;
@property (nonatomic, assign) CGFloat contentViewMarginTop;


@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSDictionary *status;

@property (nonatomic, assign) CGFloat marginTop;
//个人信息
@property (nonatomic, assign) CGFloat profileHeight;
@property (nonatomic, strong) YYTextLayout *nameLayout;
@property (nonatomic, strong) YYTextLayout *timeLayout;

//内容
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) YYTextLayout *contentLayout;

//图片
@property (nonatomic, assign) CGFloat picHeight;
@property (nonatomic, assign) CGSize picSize;
@property (nonatomic, strong) NSArray *picFrames;

- (void)layout;
- (void)updateDate;
- (void)layoutProfile;
- (void)layoutContent;
- (void)layoutTime;
- (void)layoutPicture;
- (void)layoutPraiseAndCommpent;
- (void)layoutTool;

+ (instancetype)friendStatusCellLayout:(NSDictionary *)status;

@end
