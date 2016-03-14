//
//  HBMessageCell.m
//  qq聊天布局
//
//  Created by 黄宾宾 on 4/19/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBMessageCell.h"
#import "HBMessageFrame.h"
#import "HBMessage.h"
#import "UIImage+Extension.h"
@interface HBMessageCell()
@property (nonatomic,weak) UILabel *timeView;
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UIButton *textView;
@end
@implementation HBMessageCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"message";
    HBMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[HBMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //子控件的创建和初始化
        //时间
        UILabel *timeView=[[UILabel alloc]init];
        timeView.textAlignment=NSTextAlignmentCenter;
        timeView.textColor=[UIColor grayColor];
        timeView.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:timeView];
        self.timeView=timeView;
        //头像
        UIImageView *iconView=[[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView=iconView;
        //内容
        UIButton *textView=[[UIButton alloc]init];
        textView.titleLabel.numberOfLines=0;//换行
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        textView.titleLabel.font=[UIFont systemFontOfSize:14];
        textView.contentEdgeInsets=UIEdgeInsetsMake(20, 20, 20, 20);
        [self.contentView addSubview:textView];
        self.textView=textView;
        
        //设置cell背景色
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
//设置cell内容和frame
-(void)setMessageFrame:(HBMessageFrame *)messageFrame{
    _messageFrame=messageFrame;
    HBMessage *message=messageFrame.message;
    //时间
    self.timeView.text=message.time;
    self.timeView.frame=messageFrame.timeF;
    //头像
//   计算imageName:  NSString *icon=(message.type==HBMessageTypeMe)?@"me":@"other";
    self.iconView.image=[UIImage imageNamed:(message.type==HBMessageTypeMe)?@"me":@"other"];
    self.iconView.frame=messageFrame.iconF;
    //内容
   //要用setTitle方法，不能用这个 self.textView.titleLabel.text=message.text;
    [self.textView setTitle:message.text forState:UIControlStateNormal];
    self.textView.frame=messageFrame.textF;
    //设置正文的背景
    if (message.type==HBMessageTypeMe) {
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_nor"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_press_pic"] forState:UIControlStateHighlighted];
    }else{
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_receive_nor"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_receive_press_pic"] forState:UIControlStateHighlighted];
    }
}
@end
