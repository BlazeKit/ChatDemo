//
//  Message.m
//  ChatDemo
//
//  Created by WingKit Tung on 17/03/2018.
//  Copyright © 2018 WingKit. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
