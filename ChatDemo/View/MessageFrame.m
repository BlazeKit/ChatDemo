//
//  MessageFrame.m
//  ChatDemo
//
//  Created by WingKit Tung on 17/03/2018.
//  Copyright © 2018 WingKit. All rights reserved.
//

#import "MessageFrame.h"
#import "Message.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message{
    _message = message;
    //屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //间隔
    CGFloat padding = 10;
    //计算timeF
    if (message.isHiddenTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = screenW;
        CGFloat timeH = 30;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    //计算headF
    CGFloat headY = CGRectGetMaxY(_timeF);
    CGFloat headW = 40;
    CGFloat headH = headW;
    CGFloat headX = 0;
    if (message.type == MessageTypeOther) {
        headX = padding;
    }
    else{
        headX = screenW - padding - headW;
    }
    _headF = CGRectMake(headX, headY, headW, headH);
    //计算textF
    CGFloat textY = headY;
    CGSize textMaxSize = CGSizeMake(160, MAXFLOAT);
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize textSize = [message.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGFloat textX = 0;
    if (message.type == MessageTypeOther) {
        textX = CGRectGetMaxX(_headF) + padding;
    }
    else{
        textX = headX - padding - textSize.width - 60;
    }
    _textF = CGRectMake(textX, textY, textSize.width + 60, textSize.height + 60);
    //计算cellHeight
    CGFloat maxHeadY = CGRectGetMaxY(_headF);
    CGFloat maxTextY = CGRectGetMaxY(_textF);
    if(maxHeadY > maxTextY){
        _cellHeight = maxHeadY + padding;
    }
    else{
        _cellHeight = maxTextY + padding;
    }
}

@end
