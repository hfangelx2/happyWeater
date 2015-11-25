//
//  XMLModel_county.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/9.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "XMLModel_county.h"

@implementation XMLModel_county
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ids = value;
    }
}
@end
