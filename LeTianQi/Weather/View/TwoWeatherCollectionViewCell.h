//
//  TwoWeatherCollectionViewCell.h
//  LeTianQi
//
//  Created by POP-mac on 15/6/11.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"


@protocol ChuanZHi <NSObject>

- (void)get:(NSString *)temp;

@end

@interface TwoWeatherCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign) id<ChuanZHi>delegate;
@property (nonatomic, strong) NSString *tempp;
@property (nonatomic, strong) WeatherModel *model;
@property (nonatomic, strong) NSMutableDictionary *dic;
@end
