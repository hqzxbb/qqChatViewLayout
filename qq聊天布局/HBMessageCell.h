//
//  HBMessageCell.h
//  qq聊天布局
//
//  Created by 黄宾宾 on 4/19/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBMessageFrame;
@interface HBMessageCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)HBMessageFrame *messageFrame;
@end
