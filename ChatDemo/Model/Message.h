//
//  Message.h
//  ChatDemo
//
//  Created by WingKit Tung on 17/03/2018.
//  Copyright © 2018 WingKit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    MessageTypeMe,
    MessageTypeOther
} MessageType;

@interface Message : NSObject

@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *date;
@property (nonatomic, assign)MessageType type;
@property (nonatomic, assign, getter=isHiddenTime)BOOL hiddenTime;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end
