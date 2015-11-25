//
//  WeatherCollectionViewCell.h
//  LeTianQi
//
//  Created by POP-mac on 15/6/10.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@protocol CHuanZhi_2 <NSObject>

- (void)post:(NSString *)temoo;

@end

@interface WeatherCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, assign) id<CHuanZhi_2>dele;
@property (nonatomic, strong) NSString *uuu;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, assign) NSInteger haole;
@end
