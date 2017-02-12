//
//  YYBasicTableView.m
//  优悦一族
//
//  Created by 亮 on 2016/11/25.
//  Copyright © 2016年 umed. All rights reserved.
//

#import "YYBasicTableView.h"


@interface YYBasicTableView ()
@property (nonatomic, strong) MJRefreshFooter *cl_footer;

@end
@implementation YYBasicTableView

-(instancetype)initWithRefeshSytle:(YYTableViewRefeshStyle)style {
    
    self.refeshStyle = style;
    if (self = [super init]) {
     
        if (self.refeshStyle == YYTableViewRefeshStyleHeader) {
            
            self.mj_header = [self setRefeshHeader];
        } else if (self.refeshStyle == YYTableViewRefeshStyleFooter) {
            
            
            self.cl_footer = [self setRefeshFooter];
        } else if (self.refeshStyle == YYTableViewRefeshStyleAll){
            
            self.mj_header = [self setRefeshHeader];
            self.cl_footer = [self setRefeshFooter];
        } 
    }
    return self;
}

-(MJRefreshHeader *)setRefeshHeader {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([self.refesh respondsToSelector:@selector(tableViewHeaderRefesh:)]) {
            
            [self.refesh tableViewHeaderRefesh:self];
        }
    }];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    return header;
}

-(MJRefreshFooter *)setRefeshFooter {
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if ([self.refesh respondsToSelector:@selector(tableViewFooterRefesh:)]) {
            
            [self.refesh tableViewFooterRefesh:self];
        }
    }];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    footer.automaticallyChangeAlpha = YES;
    return footer;
    
}
-(instancetype)init {
    
    self = [self initWithRefeshSytle:YYTableViewRefeshStyleFooter];
    return self;
}

-(void)setStartFooter:(BOOL)startFooter {
    
    _startFooter = startFooter;
    self.mj_footer = self.cl_footer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
