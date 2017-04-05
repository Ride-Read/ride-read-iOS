//
//  QYSelectView.h
//  骑阅
//
//  Created by 谢升阳 on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSelectView.h"
#import "QYTableViewCell.h"

#define QY_SCREEN_BOUDS [UIScreen mainScreen].bounds

#define TABLE_CELL_HEIGHT 44
#define CANCEL_BUTTON_HEIGHT TABLE_CELL_HEIGHT
#define TITLE_VIEW_HEIGHT 50
#define MAX_CELL_COUNT 4
#define TITLE_HEIGHT 40
#define SPACE_HEIGHT 5
#define FONT_DEFAULT_SIZE 14

#define CONTENT_COLOR [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f]

@interface QYSelectView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *cancelTitle;
@property (nonatomic,strong) NSArray *actionContents;
@property (nonatomic,copy) QYSelectViewBlock selectBlock;
@property (nonatomic,strong) UITableView *contentTableView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,assign) CGFloat contentHeight;// count < 4 : rowHeight * count else *4
@property (nonatomic,assign) CGFloat viewHeight;
@end

@implementation QYSelectView

+ (void)QY_showSelectViewWithTitle:(NSString *)title cancelButttonTitle:(NSString *)cancelButtonTitle actionContent:(NSArray<QYSelectModel *> *)actionContent selectBlock:(QYSelectViewBlock)selectBlock{
    
    [[[[self class] alloc] initWithTitle:title
                      cancelButtonTitle:cancelButtonTitle
                           actonContent:actionContent
                            selectBlock:selectBlock] show];
    
}

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle actonContent:(NSArray<QYSelectModel *> *)actionContent selectBlock:(QYSelectViewBlock)selectBlock{
    
    if (self = [super initWithFrame:QY_SCREEN_BOUDS]){
        
        _title = title;
        _cancelTitle = cancelButtonTitle;
        _actionContents = actionContent;
        _selectBlock = selectBlock;

        
        _contentHeight = (actionContent.count >= MAX_CELL_COUNT ? MAX_CELL_COUNT : actionContent.count) * TABLE_CELL_HEIGHT;
        _viewHeight += _contentHeight;
        _viewHeight += _title ? TITLE_HEIGHT : 0;
        _viewHeight += CANCEL_BUTTON_HEIGHT;
        _viewHeight +=SPACE_HEIGHT;
        
        [self setSubView];
        
    }
    return self;
}

- (void)show{
    
    
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         _coverView.alpha = 1.0;
                         
                         _contentView.transform = CGAffineTransformMakeTranslation(0,  -_contentView.frame.size.height);
                         
                     } completion:nil];
}

- (void)close{

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.coverView.alpha = 0;
                         self.contentView.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
    
}

- (void)setSubView{
    
    //设置背景
    [self addSubview:({
        
        UIView *coverView = [[UIView alloc] initWithFrame:self.bounds];
        coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        coverView.alpha = 0;
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [coverView addGestureRecognizer:tapGR];
        
        _coverView = coverView;
        
    })];
    
    
    //设置内容view(内容部分)
    [self addSubview:({
        
        UIView *contentView = [[UIView alloc] init];
        contentView.frame   = CGRectMake(0, self.frame.size.height, self.frame.size.width, _viewHeight);
        contentView.backgroundColor = CONTENT_COLOR;
        
        _contentView = contentView;
        
    })];
    
    
    //设置标题
    if (_title){
        
        [_contentView addSubview:({
            
            UILabel *titleLab = [[UILabel alloc] init];
            titleLab.frame    = CGRectMake(0, 0, self.frame.size.width, TITLE_HEIGHT);
            titleLab = titleLab;
            titleLab.font = [UIFont systemFontOfSize:FONT_DEFAULT_SIZE];
            titleLab.text = _title;
            titleLab.backgroundColor = [UIColor whiteColor];
            titleLab.textColor = [UIColor grayColor];
            [titleLab setTextAlignment:NSTextAlignmentCenter];
            
            _titleLabel = titleLab;
            
        })];
    }
    
    //设置view subivew
    [_contentView addSubview:({
        
        UITableView *contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), self.frame.size.width, _contentHeight) style:UITableViewStyleGrouped];
        
        contentTableView.showsVerticalScrollIndicator = NO;
        contentTableView.showsHorizontalScrollIndicator = NO;
        contentTableView.dataSource  = self;
        contentTableView.delegate    = self;
        contentTableView.scrollEnabled = _actionContents.count > MAX_CELL_COUNT;
        contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        contentTableView.bounces = NO;
        _contentTableView = contentTableView;
        
    })];
    
    //取消按键
    [_contentView addSubview:({
        
        UIButton *cancelBtn = [[UIButton alloc] init];
        
        cancelBtn.frame     = CGRectMake(0, _contentView.frame.size.height - CANCEL_BUTTON_HEIGHT, self.frame.size.width, CANCEL_BUTTON_HEIGHT);
        
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_DEFAULT_SIZE]];
        [cancelBtn setTitle:_cancelTitle ? _cancelTitle : @"取消"  forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        _cancelBtn = cancelBtn;
        
    })];
    
    
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _actionContents.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QYTableViewCell *cell = [QYTableViewCell dequeueReusableWithTableView:tableView];
   
    QYSelectModel *model = _actionContents[indexPath.row];
    
    cell.model = model;
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QYTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (_selectBlock){
        __weak typeof(self) weakSelf = self;
        _selectBlock(weakSelf,indexPath.row,cell.model.title);
    }
    
    [self close];

}


@end
