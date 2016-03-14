//
//  ViewController.m
//  qq聊天布局
//
//  Created by 黄宾宾 on 4/19/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "ViewController.h"
#import "HBMessage.h"
#import "HBMessageFrame.h"
#import "HBMessageCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *enterView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *messageframes;
@property (nonatomic,strong)NSDictionary *autoreply;
@end

@implementation ViewController

- (void)viewDidLoad {
    //cell的设置
    [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor colorWithRed:220/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    self.tableView.allowsSelection=NO;
    //监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //设置输入框输入文字之前有一点间距
    self.enterView.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.enterView.leftViewMode=UITextFieldViewModeAlways;
    self.enterView.delegate=self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
//当键盘改变了frame
-(void)keyboardWillChangeFrame:(NSNotification *)note{
    //NSLog(@"%@",note.userInfo);
    //取出键盘动画的时间
    CGFloat duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //取得键盘最后的frame
    CGRect keyboardFram=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算控制器的view需要平移的距离
    CGFloat transformY=keyboardFram.origin.y-self.view.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
            self.view.transform=CGAffineTransformMakeTranslation(0, transformY);
    }];
    
    
    
    //    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 480}, {320, 253}}";
    //    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 227}, {320, 253}}";

}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(NSMutableArray *)messageframes{
    if (_messageframes==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *messageframeArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HBMessage *message=[[HBMessage alloc]initWithDict:dict];
            HBMessageFrame *lastmessageframe=[messageframeArray lastObject];
            HBMessage *lastmessage=lastmessageframe.message;
            
            //这里拿到当前遍历的这个字典，与前一个模型字典的time，给hideTime赋值
            message.hideTime=[message.time isEqualToString:lastmessage.time];
            
            HBMessageFrame *frame=[[HBMessageFrame alloc]init];
            frame.message=message;
            [messageframeArray addObject:frame];
        }
        _messageframes=messageframeArray;
    }
    return _messageframes;
    
}
#pragma mark 发送一条消息
-(void)addMessage:(NSString *)text type:(HBMessageType)type{
    //数据模型转换传递的数据
    HBMessage *msg=[[HBMessage alloc]init];
    msg.text=text;
    msg.type=type;
    //设置数据模型的时间
    NSDate *now=[NSDate date];
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"HH:mm";
    msg.time=[fmt stringFromDate:now];
    //看是否需要隐藏时间
    HBMessageFrame *lastMF=[self.messageframes lastObject];
    HBMessage *lastMsg=lastMF.message;
    msg.hideTime=[msg.time isEqualToString:lastMsg.time];
    //frame模型
    HBMessageFrame *mf=[[HBMessageFrame alloc]init];
    mf.message=msg;
    [self.messageframes addObject:mf];
    //刷新表格
    [self.tableView reloadData];
    //自动滚动表格到最后一行
    NSIndexPath *lastpath=[NSIndexPath indexPathForRow:self.messageframes.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [UIView animateWithDuration:1 animations:^{
        [self.view endEditing:YES];
    }];

}
//自己发送的内容
-(NSString *)replyWithText:(NSString *)text{
    for (int i=0; i<text.length; i++) {
        NSString *word=[text substringWithRange:NSMakeRange(i, 1)];
        if (self.autoreply[word]) {
            return self.autoreply[word];
        }
    }
    return @"滚蛋";
}
-(NSDictionary *)autoreply{
    if (_autoreply==nil) {
        _autoreply=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoreply.plist" ofType:nil]];
    }
    return _autoreply;
}
#pragma mark 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageframes.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    HBMessageCell *cell=[HBMessageCell cellWithTableView:tableView];
    //给cell传递模型
    cell.messageFrame=self.messageframes[indexPath.row];
    //返回cell
    return cell;
}

#pragma mark 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBMessageFrame *frame=self.messageframes[indexPath.row];
    return frame.cellHeight;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
//文本框的代理方法
//点击了键盘下方的发送按钮就会调用
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //自己发送一条消息
    [self addMessage:textField.text type:HBMessageTypeMe];
    //自己回复一条消息
    NSString *reply=[self replyWithText:textField.text];
    [self addMessage:reply type:HBMessageTypeOther];
    //清空文字
    self.enterView.text=nil;
    
    return YES;
}












@end
