//
//  HBMessageFrame.h
//  qq聊天布局
//
//  Created by 黄宾宾 on 4/19/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HBMessage;
@interface HBMessageFrame : NSObject
@property (nonatomic,assign,readonly)CGRect iconF;
@property (nonatomic,assign,readonly)CGRect timeF;
@property (nonatomic,assign,readonly)CGRect textF;
@property (nonatomic,assign,readonly)CGFloat cellHeight;
@property (nonatomic,strong)HBMessage *message;
@end
