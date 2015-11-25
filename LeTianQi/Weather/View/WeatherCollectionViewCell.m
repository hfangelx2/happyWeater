//
//  WeatherCollectionViewCell.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/10.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "WeatherCollectionViewCell.h"
#import "TwoWeatherCollectionViewCell.h"
#import "RootViewController.h"
#import <MJRefresh.h>

#import <MJRefreshComponent.h>

#import <UIScrollView+MJRefresh.h>

@interface WeatherCollectionViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate, ChuanZHi>
@end

@implementation WeatherCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(Lewidth, Lehigh * 2 - 100);
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.minimumLineSpacing = 0;
        self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Lewidth, Lehigh - 20 - 44) collectionViewLayout:flow];
        [self.collection setBackgroundColor:[UIColor clearColor]];
        self.collection.delegate = self;
        self.collection.dataSource = self;
        self.collection.showsVerticalScrollIndicator = NO;
        [self.collection addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(kaishishuaxin)];
        [self.contentView addSubview:self.collection];
        [self.collection registerClass:[TwoWeatherCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.dic = [NSMutableDictionary dictionary];
        
        
    }
    return self;
}

- (void)kaishishuaxin
{
    NSLog(@"hah ");
    [self.dele post:@"77"];
}

-(void)get:(NSString *)temp
{
    [self.dele post:temp];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TwoWeatherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
//    NSLog(@"%@", cell.dic);
    cell.dic = [NSMutableDictionary dictionary];
    if (self.haole == 99) {
        
        [self.collection.header endRefreshing];
        
        self.haole = 1;
    }
    [cell.dic setValuesForKeysWithDictionary:self.dic];
    WeatherModel *mod = [[WeatherModel alloc] init];
    cell.model = mod;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    //
}

@end
