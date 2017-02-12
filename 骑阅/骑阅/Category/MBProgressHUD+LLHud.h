//
//  MBProgressHUD+LLHud.h
//  LsjVideo
//
//  Created by 亮 on 2017/2/12.
//  Copyright © 2017年 LSJ. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (LLHud)

+(instancetype )showMessage:(NSString *)message toView:(UIView *)view;
+(void)showMessageAutoHid:(NSString *)text view:(UIView *)view;
@end
