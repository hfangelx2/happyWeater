//
//  PanDuanCollectionViewCell.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/20.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "PanDuanCollectionViewCell.h"


@interface PanDuanCollectionViewCell ()
@property (nonatomic, strong) UILabel *city;
@end

@implementation PanDuanCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.city = [[UILabel alloc] init];
        [self.city setTextColor:[UIColor colorWithRed:60 / 255.0 green:184 / 255.0 blue:242 / 255.0 alpha:1]];
//        [self.city setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:self.city];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.city.frame = CGRectMake(0, 0, 90, 20);
    
}

- (void)setPanduan:(PanDuanModel *)panduan
{
    _panduan = panduan;
    self.city.text = self.panduan.city;
}


@end
