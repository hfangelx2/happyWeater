//
//  YuJingTableViewCell.h
//  LeTianQi
//
//  Created by POP-mac on 15/6/18.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YuJing.h"

@interface YuJingTableViewCell : UITableViewCell
@property (nonatomic, strong) YuJing *model;

+ (CGFloat)highWithText:(NSString *)text;

@end
