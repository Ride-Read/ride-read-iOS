//
//  UITableViewCell+LCCKCellIdentifier.h
//  LCCKChatBarExample
//
//  v0.8.5 Created by ElonChan (微信向我报BUG:chenyilong1010) ( https://github.com/leancloud/ChatKit-OC ) on 15/11/23.
//  Copyright © 2015年 https://LeanCloud.cn . All rights reserved.
//

#import "LCCKChatMessageCell.h"

@interface LCCKCellIdentifierFactory : NSObject

/**
 *  用来获取cellIdentifier
 */

+ (NSString *)cellIdentifierForMessageConfiguration:(id)message conversationType:(LCCKConversationType)conversationType;

+ (NSString *)cacheKeyForMessage:(id)message;

@end
