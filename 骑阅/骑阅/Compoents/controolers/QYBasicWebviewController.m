//
//  QYBasicWebviewController.m
//  骑阅
//
//  Created by chen liang on 2017/4/29.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicWebviewController.h"

@interface QYBasicWebviewController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation QYBasicWebviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContetnView];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - priavte method

- (void)setContetnView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
}

- (void)loadData {
    
    NSURL *url = [NSURL URLWithString:@"https://ride-read.github.io"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
#pragma mark - webView

- (UIWebView *)webView {
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] init];
        _webView.frame = self.view.bounds;
    }
    return _webView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
