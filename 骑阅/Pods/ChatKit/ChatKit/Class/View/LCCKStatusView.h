//
//  LCCKStatusView.h
//  LeanCloudChatKit-iOS
//
//  v0.8.5 Created by ElonChan (微信向我报BUG:chenyilong1010) on 16/3/11.
//  Copyright © 2016年 LeanCloud. All rights reserved.
//

<<<<<<< HEAD
@import UIKit;
@import Foundation;

=======
>>>>>>> bf40f696574c7f06d8a1232e3f9594c56573ffde
@protocol LCCKStatusViewDelegate <NSObject>

@optional
- (void)statusViewClicked:(id)sender;
@end

static CGFloat LCCKStatusViewHight = 44;

@interface LCCKStatusView : UIView

@property (nonatomic, weak) id<LCCKStatusViewDelegate> delegate;

@end
