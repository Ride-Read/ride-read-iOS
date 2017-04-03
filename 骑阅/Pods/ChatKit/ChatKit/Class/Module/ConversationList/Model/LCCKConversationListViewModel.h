//
//  LCCKConversationListViewModel.h
//  LeanCloudChatKit-iOS
//
//  v0.8.5 Created by ElonChan (微信向我报BUG:chenyilong1010) on 16/3/22.
//  Copyright © 2016年 LeanCloud. All rights reserved.
//

<<<<<<< HEAD
@import UIKit;
@import Foundation;
=======
>>>>>>> bf40f696574c7f06d8a1232e3f9594c56573ffde
@class LCCKConversationListViewController;
@class AVIMConversation;

@interface LCCKConversationListViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithConversationListViewController:(LCCKConversationListViewController *)conversationListViewController;

@property (nonatomic, strong) NSMutableArray<AVIMConversation *> *dataArray;

- (void)refresh;

@end
