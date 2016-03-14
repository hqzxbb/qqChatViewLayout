//
//  NSString+Extension.m
//  qq聊天布局
//
//  Created by 黄宾宾 on 4/20/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs=@{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
