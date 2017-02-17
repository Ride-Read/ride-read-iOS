//
//  define.h
//  骑阅
//
//  Created by chen liang on 2017/2/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#ifndef define_h
#define define_h

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

static float cl_caculation_y(float x) {
    
    return x/2.0/568 * kScreenHeight;
}

static float cl_caculation_x(float x)  {
    
    return x/2.0/320 * kScreenWidth;
}
#endif /* define_h */
