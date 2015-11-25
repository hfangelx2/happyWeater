//
//  XMLModel.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/9.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "XMLModel.h"

@implementation XMLModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ids = value;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.array = [NSMutableArray array];
    }
    return self;
}

@end
