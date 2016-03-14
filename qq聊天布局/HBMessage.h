//
//  HBMessage.h
//  qq聊天布局
//
//  Created by 黄宾宾 on 4/19/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    HBMessageTypeMe=0,//自己发的消息
    HBMessageTypeOther//别人发的消息
}HBMessageType;
@interface HBMessage : NSObject
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *text;
@property (nonatomic,assign)HBMessageType type;
@property (nonatomic,assign)BOOL hideTime;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)messageWithDict:(NSDictionary *)dict;
@end
