//
//  UIImage+Extension.m
//  qq聊天布局
//
//  Created by 黄宾宾 on 4/20/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+(UIImage *)resizableImage:(NSString *)name{
    UIImage *image=[UIImage imageNamed:name];
    CGFloat width=image.size.width*0.5;
    CGFloat height=image.size.width*0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(height, width,height, width) resizingMode:UIImageResizingModeStretch];
}
@end
