//
//  YYBasicTableView.h
//  优悦一族
//
//  Created by 亮 on 2016/11/25.
//  Copyright © 2016年 umed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
<<<<<<< HEAD
=======

>>>>>>> bf40f696574c7f06d8a1232e3f9594c56573ffde

@class YYBasicTableView;
typedef NS_ENUM(NSUInteger,YYTableViewRefeshStyle) {
    
    YYTableViewRefeshStyleDefault,//默认状态不进行添加
    YYTableViewRefeshStyleHeader,
    YYTableViewRefeshStyleFooter,
    YYTableViewRefeshStyleAll
};
@protocol YYBaseicTableViewRefeshDelegate <NSObject>
@optional
-(void)tableViewHeaderRefesh:(YYBasicTableView *)tableView;
-(void)tableViewFooterRefesh:(YYBasicTableView *)tableView;

@end
@interface YYBasicTableView : UITableView
@property (nonatomic, assign) YYTableViewRefeshStyle refeshStyle;
@property (nonatomic, weak) id <YYBaseicTableViewRefeshDelegate> refesh;
@property (nonatomic, assign) BOOL startFooter;

-(instancetype)initWithRefeshSytle:(YYTableViewRefeshStyle)style;
@end
