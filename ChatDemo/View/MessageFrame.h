//
//  MessageFrame.h
//  ChatDemo
//
//  Created by WingKit Tung on 17/03/2018.
//  Copyright © 2018 WingKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Message;

@interface MessageFrame : NSObject

@property (nonatomic,assign,readonly)CGRect timeF;
@property (nonatomic,assign,readonly)CGRect headF;
@property (nonatomic,assign,readonly)CGRect textF;

@property (nonatomic,assign,readonly)CGFloat cellHeight;
@property (nonatomic,strong)Message *message;

@end
