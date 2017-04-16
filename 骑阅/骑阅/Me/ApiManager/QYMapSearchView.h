//
//  QYMapSearchView.h
//  骑阅
//
//  Created by chen liang on 2017/4/17.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYMapSearchView;
@protocol QYMapSearchViewDelegate <NSObject>

- (void)mapSearchView:(QYMapSearchView *)view start:(NSString *)text;

@end
@interface QYMapSearchView : UIView
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (nonatomic, weak) id <QYMapSearchViewDelegate> delegate;


+ (instancetype)mapSearchView;
@end
