//
//  define.h
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#ifndef define_h
#define define_h
#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIView+QYShowBottomLine.h"
#import "CTAppContext.h"
#import "NSString+QYUrlEncode.h"
#import "UIColor+QYHexStringColor.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIAlertController+QYQuickAlert.h"
#import "MBProgressHUD+LLHud.h"
#import "QYNotifationList.h"

static NSString *const kAttetionSuccess = @"AttetionSuccess";
static NSString *const kUnAtteionSuccess = @"UnAtteionSuccess";

#define RGB(R,G,B) [UIColor colorWithRed:R/255. green:G/255. blue:B/255. alpha:1.0]
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度

#ifdef MYDEBUG
#define MyLog(FORMAT,...) printf("%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__ ,[[NSString stringWithFormat:FORMAT,##__VA_ARGS__] UTF8String])
#else
#define MyLog(FORMAT,...)
#endif
#define WEAKSELF(weakSelf) __weak typeof(self) weakSelf = self


#define SizeScale ((kScreenHeight > 568) ? kScreenHeight/568 : 1)
#define SizeScale3x ((kScreenHeight > 667) ? kScreenHeight/667 : 1)

static float cl_caculation_y(float x) {
    
    return x/2.0/568 * kScreenHeight;
}

static float cl_caculation_x(float x)  {
    
    return x/2.0/320 * kScreenWidth;
}

static float cl_caculation_3x(float x)  {
    
    return x/2.0/375 * kScreenWidth;
}
static float cl_caculation_3y(float x)  {
    
    return x/2.0/667 * kScreenHeight;
}

#define Basic_Qiniu_URL @"http://om1ccbp21.bkt.clouddn.com/"

#pragma mark - custom keys
static NSString * const kdefault_icon = @"defalut_avatar";
static NSString * const kdata = @"data";
static NSString * const kusername = @"username";
static NSString * const kpassword = @"password";
static NSString * const klatitude = @"latitude";
static NSString * const klongitude = @"longitude";
static NSString * const knew_password = @"new_password";
static NSString * const kstatus = @"status";
static NSString * const kcode = @"code";
static NSString * const kavater = @"avater";
static NSString * const kuid = @"uid";
static NSString * const kuser_ids = @"user_ids";
static NSString * const kuser_id = @"user_id";
static NSString * const knickname = @"nickname";
static NSString * const kphonenumber = @"phonenumber";
static NSString * const kface_url = @"face_url";
static NSString * const ktoken = @"token";
static NSString * const kfilename = @"filename";
static NSString * const ksignature = @"signature";
static NSString * const ktime = @"time";
static NSString * const kmid = @"mid";
static NSString * const kreply_uid = @"reply_uid";
static NSString * const krand_code = @"rand_code";
static NSString * const kride_read_id = @"ride_read_id";
static NSString * const kmoment_location = @"moment_location";
static NSString * const kcount = @"count";

#pragma mark - cycl
static NSString * const kuser = @"user";
static NSString * const kmsg = @"msg";
static NSString * kshortname = @"shortname";
static NSString * const kcreated_at = @"created_at";
static NSString * const kupdated_at = @"updated_at";
static NSString * const kthumbs = @"thumbs";
static NSString * const kvideo_url = @"video_url";
static NSString * const ktype = @"type";
static NSString * const kpictures_url = @"pictures_url";
static NSString * const kcover = @"cover";
static NSString * const ksite = @"stie";
static NSString * const ksiteLength = @"siteLength";
static NSString * const kpraise = @"praise";
static NSString * const kcomment = @"comment";
static NSString * const kpages = @"pages";
static NSString * const kfrom = @"from";
static NSString * const kreply = @"reply";
static NSString * const kfolloweds = @"followeds";
static NSString * const kfollowers = @"followers";
static NSString * const kscaling_ratio = @"scaling_ratio";


#pragma - personal
static NSString * const khometown = @"hometown";
static NSString * const kbirthday = @"birthday";
static NSString * const kschool = @"school";
static NSString * const kcarre = @"carre";
static NSString * const ktags = @"tags";
static NSString * const ksex = @"sex";
static NSString * const kcareer = @"career";
static NSString * const klocation = @"location";
static NSString * const kfid = @"fid";

static NSString * const kversion = @"version";
static NSString * const klink = @"url";



#endif /* define_h */
