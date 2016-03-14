//
//  HBMessageFrame.m
//  qq聊天布局
//
//  Created by 黄宾宾 on 4/19/15.
//  Copyright (c) 2015 HB. All rights reserved.
//
#define HBTextFont [UIFont systemFontOfSize:15]
#import "HBMessageFrame.h"
#import "HBMessage.h"
#import "NSString+Extension.h"
@implementation HBMessageFrame

-(void)setMessage:(HBMessage *)message{
    _message=message;
    CGFloat padding=10;//间距
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;//屏幕宽度
    //时间
    if (message.hideTime==NO) {
        CGFloat timeX=0;
        CGFloat timeY=0;
        CGFloat timeW=screenW;
        CGFloat timeH=40;
        _timeF=CGRectMake(timeX, timeY, timeW, timeH);
    }
   
    //头像
    CGFloat iconY=CGRectGetMaxY(_timeF)+padding;
    CGFloat iconW=40;
    CGFloat iconH=40;
    CGFloat iconX;
    if (message.type==HBMessageTypeOther) {
        iconX=padding;
    }else {
        iconX=screenW-padding-iconW;
    }
    _iconF=CGRectMake(iconX, iconY, iconW, iconH);
    //内容
    //文字的最大尺寸
    CGSize textMaxSize=CGSizeMake(150, MAXFLOAT);
    //文字计算出来的真实尺寸(按钮内部的lable属性）
    CGSize textSize=[message.text sizeWithFont:HBTextFont maxSize:textMaxSize];
    //按钮计算出来的真实尺寸
    CGSize textBtnSize=CGSizeMake(textSize.width+40, textSize.height+40);
    CGFloat textX;
    if (message.type==HBMessageTypeOther) {
        textX=padding+iconW+padding;
    }else{
        textX=iconX-padding-textBtnSize.width;
    }
    _textF=CGRectMake(textX, iconY, textBtnSize.width, textBtnSize.height);
    //cell的高度
    CGFloat textMaxY=CGRectGetMaxY(_textF);
    CGFloat iconMaxY=CGRectGetMaxY(_iconF);
    _cellHeight=MAX(textMaxY,iconMaxY)+padding;
}
@end
