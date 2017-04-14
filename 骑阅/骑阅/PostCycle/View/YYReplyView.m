//
//  YYReplyView.m
//  优悦一族
//
//  Created by 亮 on 2016/12/19.
//  Copyright © 2016年 umed. All rights reserved.
//

#import "YYReplyView.h"
#import "define.h"


@interface YYReplyTextView ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, copy, readwrite) NSString *lasteString;

@end
@implementation YYReplyTextView

#pragma mark - life cycle

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.maxLength = HUGE;
    [self addSubview:self.textView];
    [self addSubview:self.placeLabel];
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(cl_caculation_x(35));
        make.top.mas_equalTo(cl_caculation_y(15));
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.and.top.and.bottom.mas_equalTo(0);
    }];

}
-(instancetype)init {
    
    self = [super init];
    self.maxLength = HUGE;
    [self addSubview:self.textView];
    [self addSubview:self.placeLabel];
        [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(cl_caculation_x(5));
        make.top.mas_equalTo(cl_caculation_y(15));
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.and.top.and.bottom.mas_equalTo(0);
    }];
    
    return self;
}

#pragma mark - private method

-(void)updateLasteString {
    
    if (self.textView.text.length > 200) {
        
        self.textView.text = self.lasteString;
        if ([self.replyView.delegate respondsToSelector:@selector(replyView:moreThan:)])
            [self.replyView.delegate replyView:self.replyView moreThan:200];
        return;
    }
    self.lasteString = self.textView.text;
    if (self.lasteString.length > 0) {
        
        self.placeLabel.hidden = YES;
    } else {
        self.placeLabel.hidden = NO;
    }
   
}

#pragma mark - textView delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (text.length == 0) {
        
        return YES;
    }
    if (self.textView.text.length > self.maxLength) {
        
        if ([self.replyView.delegate respondsToSelector:@selector(replyView:moreThan:)]) {
            
            [self.replyView.delegate replyView:self.replyView moreThan:self.maxLength];
        }
        return NO;
    } else {
        
        return YES;
    }
}
-(void)textViewDidChange:(UITextView *)textView {
    
    [self updateLasteString];
}

#pragma mark - gettrs and setters
-(UILabel *)placeLabel {
    
    if (!_placeLabel) {
        
        _placeLabel = [[UILabel alloc] init];
        _placeLabel.textColor = [UIColor colorWithHexString:@"#555555"];
        _placeLabel.font = [UIFont systemFontOfSize:16 * SizeScale3x];
        _placeLabel.text = self.placeHolder;
    }
    return _placeLabel;
}
-(UITextView *)textView {
    
    if (!_textView) {
        
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:16 * SizeScale3x];
        _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        
    }
    return _textView;
}

-(void)setPlaceHolder:(NSString *)placeHolder {
    
    _placeHolder = placeHolder;
    //[self.placeLabel setNeedsDisplay];
    self.placeLabel.text = placeHolder;
}
@end
@implementation YYReplyView

#pragma mark - lifc cycle
-(instancetype)init {
    
    self = [super init];
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.96 blue:0.91 alpha:1.00];
    [self addSubview:self.replyTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    [self.replyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(491));
        
    }];
    
    return self;
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mari - target action
-(void)openKeyboard:(NSNotification *)sender{
    
   CGRect keyboardFrame = ((NSValue *)sender.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
   [self.replyTextView mas_updateConstraints:^(MASConstraintMaker *make) {
      
       make.top.and.left.and.right.mas_equalTo(0);
       make.height.mas_equalTo(kScreenHeight - keyboardFrame.size.height - 64);

   }];
}

-(void)closeKeyboard:(NSNotification *)sender{
    
    
   //CGRect keyboardFrame = ((NSValue *)sender.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
    [self.replyTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(491));
        
    }];
}

#pragma mark - getters and setters

-(YYReplyTextView *)replyTextView {
    
    if (!_replyTextView) {
        
        _replyTextView = [[YYReplyTextView alloc] init];
        _replyTextView.replyView = self;
        _replyTextView.maxLength = 200;
        _replyTextView.placeHolder = @"请输入评论内容";
    }
    return _replyTextView;
}
@end
