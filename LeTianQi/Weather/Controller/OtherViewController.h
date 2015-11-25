//
//  OtherViewController.h
//  LeTianQi
//
//  Created by POP-mac on 15/6/15.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KanKan <NSObject>

- (void)get:(NSInteger)temp;

@end

@interface OtherViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger ppp;
@property (nonatomic, assign) id<KanKan>delegate;
@end
