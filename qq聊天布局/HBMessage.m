//
//  HBMessage.m
//  qq聊天布局
//
//  Created by 黄宾宾 on 4/19/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBMessage.h"

@implementation HBMessage
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)messageWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
