//
//  MessageCell.m
//  ChatDemo
//
//  Created by WingKit Tung on 17/03/2018.
//  Copyright © 2018 WingKit. All rights reserved.
//

#import "MessageCell.h"
#import "MessageFrame.h"
#import "Message.h"

@interface MessageCell ()

@property (nonatomic,weak)UILabel *timeView;
@property (nonatomic,weak)UIImageView *headView;
@property (nonatomic,weak)UIButton *textView;

@end

@implementation MessageCell

//重写方法 添加要用到的控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //时间label
        UILabel *timeView = [UILabel new];
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        timeView.textAlignment = NSTextAlignmentCenter;
        timeView.font = [UIFont systemFontOfSize:13];//设置字体大小
        //头像image
        UIImageView *headView = [UIImageView new];
        [self.contentView addSubview:headView];
        self.headView = headView;
        //设置圆形头像，由于这里的Frame使用了懒加载，所以不能用Frame的值
        self.headView.layer.cornerRadius = 20;//self.headView.frame.size.width * 0.5;
        self.headView.layer.masksToBounds = YES;
        self.headView.layer.borderWidth = 1.5f;
        self.headView.layer.borderColor = [UIColor whiteColor].CGColor;
        //正文，用UIButton
        UIButton *textView = [UIButton new];
        [self.contentView addSubview:textView];
        self.textView = textView;
        [self.textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//字体颜色
        textView.titleLabel.numberOfLines = 0;//设置换行
        textView.titleLabel.font = [UIFont systemFontOfSize:16];//设置字体大小
        textView.contentEdgeInsets = UIEdgeInsetsMake(30, 30, 30, 30);//设置正文边距
        //cell颜色置透明
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setMessageFrame:(MessageFrame *)messageFrame{
    _messageFrame = messageFrame;
    
    self.timeView.frame = messageFrame.timeF;
    self.timeView.text = messageFrame.message.date;
    
    self.headView.frame = messageFrame.headF;
    if (messageFrame.message.type == MessageTypeOther) {
        self.headView.image = [UIImage imageNamed:@"other"];
    }
    else{
        self.headView.image = [UIImage imageNamed:@"me"];
    }
    
    self.textView.frame = messageFrame.textF;
    [self.textView setTitle:messageFrame.message.text forState:UIControlStateNormal];
    //设置正文背景
    if (_messageFrame.message.type == MessageTypeOther) {
        [self.textView setBackgroundImage:[self resizeWithName:@"chat_other"] forState:UIControlStateNormal];
    }
    else{
        [self.textView setBackgroundImage:[self resizeWithName:@"chat_me"] forState:UIControlStateNormal];
    }
}
//拉伸图片模式
- (UIImage *)resizeWithName:(NSString *)img{
    UIImage *old = [UIImage imageNamed:img];
    CGFloat w = old.size.width * 0.5;
    CGFloat h = old.size.height * 0.5;
    return [old resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
}

@end
