//
//  YuJingViewController.h
//  LeTianQi
//
//  Created by POP-mac on 15/6/18.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YuJingTableViewCell.h"

@interface YuJingViewController : UIViewController
@property (nonatomic, strong) NSMutableDictionary *array;

+ (CGFloat)hightWithText:(NSString *)temps;

@end
