//
//  TwoWeatherCollectionViewCell.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/11.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "TwoWeatherCollectionViewCell.h"
#import "FDGraphScrollView.h"
#import "FDGraphView.h"
#import <AVFoundation/AVFoundation.h>

@interface TwoWeatherCollectionViewCell ()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) UILabel *timeData;
@property (nonatomic, strong) UIView *weather_1_back;
@property (nonatomic, strong) UIImageView *weather_zhuangkuang;
@property (nonatomic, strong) UILabel *liang;
@property (nonatomic, strong) UIView *weather_2_back;
@property (nonatomic, strong) UIImageView *weather_jinggao;
@property (nonatomic, strong) UILabel *yujing;
@property (nonatomic, strong) UILabel *fabuTime;
@property (nonatomic, strong) UILabel *tem;
@property (nonatomic, strong) UIImageView *wind_pic;
@property (nonatomic, strong) UILabel *wind_label;
@property (nonatomic, strong) UIImageView *wet_pic;
@property (nonatomic, strong) UILabel *wet_label;
@property (nonatomic, strong) UILabel *qing;
@property (nonatomic, strong) UIButton *speak;
@property (nonatomic, strong) UIView *xian_1;
@property (nonatomic, strong) UIView *xian_2;
@property (nonatomic, strong) UIView *xian_3;
@property (nonatomic, strong) UILabel *jintian;
@property (nonatomic, strong) UILabel *mingtian;
@property (nonatomic, strong) UILabel *jt_tem;
@property (nonatomic, strong) UILabel *mt_tem;
@property (nonatomic, strong) UILabel *jt_wea;
@property (nonatomic, strong) UILabel *mt_wea;
@property (nonatomic, strong) UIImageView *jt_image;
@property (nonatomic, strong) UIImageView *mt_image;
@property (nonatomic, strong) FDGraphScrollView *zhexianSV;
@property (nonatomic, strong) UILabel *av_tem_1;
@property (nonatomic, strong) UILabel *av_tem_2;
@property (nonatomic, strong) UILabel *av_tem_3;
@property (nonatomic, strong) FDGraphScrollView *five_day;
@property (nonatomic, strong) FDGraphScrollView *five_day_1;
@property (nonatomic, strong) UIView *back_two;
@property (nonatomic, strong) NSString *zhouji;
@property (nonatomic, strong) NSString *jidianfabu;
@property (nonatomic, assign) BOOL xuansha;
@property (nonatomic, strong) NSMutableArray *speak_dada;
@property (nonatomic, assign) NSInteger speak_num;
@end

@implementation TwoWeatherCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"//%@", self.dic);
        
        self.timeData = [[UILabel alloc] init];
//        [self.timeData setBackgroundColor:[UIColor yellowColor]];
//        self.timeData.text = @"6月10日";
        self.timeData.textAlignment = NSTextAlignmentCenter;
        [self.timeData setFont:[UIFont systemFontOfSize:16]];
        self.timeData.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.timeData];
        
        self.weather_1_back = [[UIView alloc] init];
        [self.weather_1_back setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
        [self.weather_1_back.layer setCornerRadius:20];
        [self.contentView addSubview:self.weather_1_back];
        
        self.weather_zhuangkuang = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_zhuangkuang"]];
        [self.weather_1_back addSubview:self.weather_zhuangkuang];
        
        self.liang = [[UILabel alloc] init];
//        self.liang.text = @"75 良";
        self.liang.textColor = [UIColor whiteColor];
        [self.liang setNumberOfLines:0];
//        [self.liang setTextAlignment:NSTextAlignmentCenter];
        [self.liang setFont:[UIFont systemFontOfSize:13]];
//        [self.liang setBackgroundColor:[UIColor blueColor]];
        [self.weather_1_back addSubview:self.liang];
        
        self.weather_2_back = [[UIView alloc] init];
        [self.weather_2_back setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
        self.weather_2_back.userInteractionEnabled = YES;
        UITapGestureRecognizer *yujing_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yujing_tap_tap)];
        [self.weather_2_back addGestureRecognizer:yujing_tap];
        self.weather_2_back.hidden = NO;
        [self.weather_2_back.layer setCornerRadius:20];
        [self.contentView addSubview:self.weather_2_back];
        
        self.weather_jinggao = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather_jinggao"]];
        [self.weather_2_back addSubview:self.weather_jinggao];
        
        self.yujing = [[UILabel alloc] init];
//        self.yujing.text = @"5个预警";
        self.yujing.textColor = [UIColor whiteColor];
        [self.yujing setFont:[UIFont systemFontOfSize:13]];
//        [self.yujing setBackgroundColor:[UIColor blueColor]];
        [self.weather_2_back addSubview:self.yujing];
        
        self.fabuTime = [[UILabel alloc] init];
//        self.fabuTime.text = @"今天11.50发布";
//        [self.fabuTime setBackgroundColor:[UIColor greenColor]];
        self.fabuTime.textColor = [UIColor whiteColor];
        [self.fabuTime setFont:[UIFont systemFontOfSize:16]];
        [self.contentView addSubview:self.fabuTime];
        
        self.tem = [[UILabel alloc] init];
        self.tem.textColor = [UIColor whiteColor];
        [self.tem setFont:[UIFont systemFontOfSize:90]];
        self.tem.userInteractionEnabled = YES;
        UITapGestureRecognizer *tem_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tem_taps)];
        [self.tem addGestureRecognizer:tem_tap];
//        [self.tem setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:self.tem];
        
        self.wind_pic = [[UIImageView alloc] init];
//        [self.wind_pic setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:self.wind_pic];
        
        self.wind_label = [[UILabel alloc] init];
        self.wind_label.textColor = [UIColor whiteColor];
//        [self.wind_label setBackgroundColor:[UIColor greenColor]];
        [self.contentView addSubview:self.wind_label];
        
        self.wet_pic = [[UIImageView alloc] init];
//        [self.wet_pic setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:self.wet_pic];
        
        self.wet_label = [[UILabel alloc] init];
//        self.wet_label.text = @"%75";
        self.wet_label.textColor = [UIColor whiteColor];
//        [self.wet_label setBackgroundColor:[UIColor greenColor]];
        [self.contentView addSubview:self.wet_label];
        
        self.qing = [[UILabel alloc] init];
        [self.qing setFont:[UIFont systemFontOfSize:20]];
        self.qing.textColor = [UIColor whiteColor];
//        [self.qing setBackgroundColor:[UIColor greenColor]];
        [self.contentView addSubview:self.qing];
        
        self.speak = [UIButton buttonWithType:UIButtonTypeSystem];
//        [self.speak setBackgroundColor:[UIColor greenColor]];
        self.speak.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap_speak = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(speak_tap)];
        [self.speak addGestureRecognizer:tap_speak];
        [self.speak setImage:[[UIImage imageNamed:@"speak"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.contentView addSubview:self.speak];
        
        self.xian_1 = [[UIView alloc] init];
        [self.xian_1 setBackgroundColor:[UIColor whiteColor]];
        self.xian_1.alpha = 0.3;
        [self.contentView addSubview:self.xian_1];
        
        self.xian_2 = [[UIView alloc] init];
        [self.xian_2 setBackgroundColor:[UIColor whiteColor]];
        self.xian_2.alpha = 0.3;
        [self.contentView addSubview:self.xian_2];
        
        self.xian_3 = [[UIView alloc] init];
        [self.xian_3 setBackgroundColor:[UIColor whiteColor]];
        self.xian_3.alpha = 0.3;
        [self.contentView addSubview:self.xian_3];
        
        self.jintian = [[UILabel alloc] init];
        self.jintian.text = @"今天";
        [self.jintian setFont:[UIFont systemFontOfSize:14]];
//        [self.jintian setBackgroundColor:[UIColor grayColor]];
        self.jintian.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.jintian];
        
        self.mingtian = [[UILabel alloc] init];
        self.mingtian.text = @"明天";
        [self.mingtian setFont:[UIFont systemFontOfSize:14]];
//        [self.mingtian setBackgroundColor:[UIColor grayColor]];
        self.mingtian.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.mingtian];
        
        self.jt_tem = [[UILabel alloc] init];
//        self.jt_tem.text = @"22/16°C";
        [self.jt_tem setFont:[UIFont systemFontOfSize:14]];
        [self.jt_tem setTextAlignment:NSTextAlignmentRight];
//        [self.jt_tem setBackgroundColor:[UIColor grayColor]];
        self.jt_tem.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.jt_tem];
        
        self.mt_tem = [[UILabel alloc] init];
//        self.mt_tem.text = @"100/-50°C";
        [self.mt_tem setFont:[UIFont systemFontOfSize:14]];
        [self.mt_tem setTextAlignment:NSTextAlignmentRight];
//        [self.mt_tem setBackgroundColor:[UIColor grayColor]];
        self.mt_tem.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.mt_tem];
        
        self.jt_wea = [[UILabel alloc] init];
//        self.jt_wea.text = @"中雨";
//        [self.jt_wea setBackgroundColor:[UIColor grayColor]];
        self.jt_wea.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.jt_wea];
        
        self.mt_wea = [[UILabel alloc] init];
//        self.mt_wea.text = @"大雨转暴雨";
//        [self.mt_wea setBackgroundColor:[UIColor grayColor]];
        self.mt_wea.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.mt_wea];
        
        self.jt_image = [[UIImageView alloc] init];
//        [self.jt_image setBackgroundColor:[UIColor greenColor]];
        [self.contentView addSubview:self.jt_image];
        
        self.mt_image = [[UIImageView alloc] init];
//        [self.mt_image setBackgroundColor:[UIColor greenColor]];
        [self.contentView addSubview:self.mt_image];
        
        //背景
        UIView *back_zhexian = [[UIView alloc] init];
        [back_zhexian setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
        [self.contentView addSubview:back_zhexian];
        
        self.zhexianSV = [[FDGraphScrollView alloc] initWithFrame:CGRectMake(30, Lehigh - 8 - 64, Lewidth - 30, 140)];
//        [self.zhexianSV setBackgroundColor:[UIColor grayColor]];
        [self.zhexianSV setShowsHorizontalScrollIndicator:NO];
        [self.contentView addSubview:self.zhexianSV];
        
        //背景位置
        [back_zhexian setFrame:CGRectMake(0, self.zhexianSV.frame.origin.y, Lewidth, 140)];

        UILabel *xianshishijian = [[UILabel alloc] init];
        xianshishijian.text = @"24小时";
        xianshishijian.textColor = [UIColor whiteColor];
        [xianshishijian setFont:[UIFont systemFontOfSize:15]];
        xianshishijian.alpha = 1;
        [xianshishijian setFrame:CGRectMake(10, self.zhexianSV.frame.origin.y + 5, 100, 20)];
        [self.contentView addSubview:xianshishijian];
        
        UIView *av_temview_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, Lewidth, 1)];
        [av_temview_1 setBackgroundColor:[UIColor whiteColor]];
        av_temview_1.alpha = 0.5;
        [back_zhexian addSubview:av_temview_1];
        
        UIView *av_temview_2 = [[UIView alloc] initWithFrame:CGRectMake(0, 49 + 60, Lewidth, 1)];
        [av_temview_2 setBackgroundColor:[UIColor whiteColor]];
        av_temview_2.alpha = 0.5;
        [back_zhexian addSubview:av_temview_2];
        
        UIView *av_temview_3 = [[UIView alloc] initWithFrame:CGRectMake(0, 49 + 30, Lewidth, 1)];
        [av_temview_3 setBackgroundColor:[UIColor whiteColor]];
        av_temview_3.alpha = 0.5;
        [back_zhexian addSubview:av_temview_3];
        
        self.av_tem_1 = [[UILabel alloc] init];
//        self.av_tem_1.text = @"32°";
        self.av_tem_1.textColor = [UIColor whiteColor];
        [self.av_tem_1 setFont:[UIFont systemFontOfSize:13]];
        self.av_tem_1.textAlignment = NSTextAlignmentCenter;
//        [self.av_tem_1 setBackgroundColor:[UIColor grayColor]];
        [back_zhexian addSubview:self.av_tem_1];
        
        self.av_tem_2 = [[UILabel alloc] init];
//        self.av_tem_2.text = @"28°";
        self.av_tem_2.textColor = [UIColor whiteColor];
        [self.av_tem_2 setFont:[UIFont systemFontOfSize:13]];
        self.av_tem_2.textAlignment = NSTextAlignmentCenter;
//        [self.av_tem_2 setBackgroundColor:[UIColor grayColor]];
        [back_zhexian addSubview:self.av_tem_2];
        
        self.av_tem_3 = [[UILabel alloc] init];
//        self.av_tem_3.text = @"24°";
        self.av_tem_3.textColor = [UIColor whiteColor];
        [self.av_tem_3 setFont:[UIFont systemFontOfSize:13]];
        self.av_tem_3.textAlignment = NSTextAlignmentCenter;
//        [self.av_tem_3 setBackgroundColor:[UIColor grayColor]];
        [back_zhexian addSubview:self.av_tem_3];
        
        self.back_two = [[UIView alloc] initWithFrame:CGRectMake(0, self.zhexianSV.frame.origin.y + 160, Lewidth, 320)];
        [self.back_two setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
        [self.contentView addSubview:self.back_two];
        
        UILabel *yubao_hehe = [[UILabel alloc] init];
        yubao_hehe.text = @"预报";
        yubao_hehe.textColor = [UIColor whiteColor];
        [yubao_hehe setFont:[UIFont systemFontOfSize:15]];
        yubao_hehe.alpha = 1;
        [yubao_hehe setFrame:CGRectMake(10, 5, 100, 20)];
        [self.back_two addSubview:yubao_hehe];
        
        UIView *days_line = [[UIView alloc] init];
        [days_line setBackgroundColor:[UIColor whiteColor]];
        days_line.alpha = 0.5;
        [days_line setFrame:CGRectMake(0, 30, Lewidth, 1)];
        [self.back_two addSubview:days_line];
        
        
        self.five_day = [[FDGraphScrollView alloc] initWithFrame:CGRectMake(0, 125, Lewidth, 50)];
//        [self.five_day setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        self.five_day.graphView.linesColor = [UIColor colorWithRed:248 / 255.0 green:183 / 255.0 blue:61 / 255.0 alpha:1];
        self.five_day.graphView.edgeInsets = UIEdgeInsetsMake(10, 30, 10, 30);
        self.five_day.graphView.dataPointsXoffset = (Lewidth - 60) / 5.0 - 1;
        self.five_day.graphView.autoresizeToFitData = YES;
        [self.five_day setBounces:NO];
        [self.five_day setShowsHorizontalScrollIndicator:NO];
        [self.back_two addSubview:self.five_day];
        
        self.five_day_1 = [[FDGraphScrollView alloc] initWithFrame:CGRectMake(0, self.five_day.frame.origin.y + 50, Lewidth, 50)];
//        [self.five_day_1 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        self.five_day_1.graphView.linesColor = [UIColor colorWithRed:40 / 255.0 green:172 / 255.0 blue:249 / 255.0 alpha:1];
        self.five_day_1.graphView.edgeInsets = UIEdgeInsetsMake(10, 30, 10, 30);
        self.five_day_1.graphView.dataPointsXoffset = (Lewidth - 60) / 5.0 - 1;
        self.five_day_1.graphView.autoresizeToFitData = YES;
        [self.five_day_1 setBounces:NO];
        [self.five_day_1 setShowsHorizontalScrollIndicator:NO];
        [self.back_two addSubview:self.five_day_1];

        
    }
    return self;
}

- (void)tem_taps
{
    NSLog(@"点击");
    [self.delegate get:@"0"];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [self.timeData setFrame:CGRectMake(Lewidth - 120, 2, 110, 20)];
    [self.weather_1_back setFrame:CGRectMake(Lewidth - 120, self.timeData.frame.origin.y + 20 + 5, 100, 40)];
    [self.weather_zhuangkuang setFrame:CGRectMake(5, 5, 30, 30)];
    [self.liang setFrame:CGRectMake(38, 1, 65, 40)];
    
    [self.weather_2_back setFrame:CGRectMake(Lewidth - 120, self.weather_1_back.frame.origin.y + 36 + 10, 100, 40)];
    [self.weather_jinggao setFrame:CGRectMake(6, 6, 28, 25)];
    [self.yujing setFrame:CGRectMake(36, 10, 70, 20)];
    
    [self.fabuTime setFrame:CGRectMake(10, Lehigh - 300, 150, 20)];
    [self.tem setFrame:CGRectMake(10, self.fabuTime.frame.origin.y + 20 + 10, 150, 90)];
    self.wind_pic.image = [UIImage imageNamed:@"weather_wind"];
    [self.wind_pic setFrame:CGRectMake(10, self.tem.frame.origin.y + 90, 20, 20)];
    [self.wind_label setFrame:CGRectMake(10 + 20, self.wind_pic.frame.origin.y, 35, 20)];
    
    self.wet_pic.image = [UIImage imageNamed:@"weather_wet"];
    [self.wet_pic setFrame:CGRectMake(10 + 55, self.tem.frame.origin.y + 90, 20, 20)];
    [self.wet_label setFrame:CGRectMake(10 + 20 + 55, self.wet_pic.frame.origin.y, 45, 20)];
    
    [self.qing setFrame:CGRectMake(130, self.tem.frame.origin.y + self.tem.frame.size.height - 28, 100, 22)];
    
    [self.speak setFrame:CGRectMake(Lewidth - 56, self.tem
                                    .frame.origin.y, 35, 35)];
    
    [self.xian_1 setFrame:CGRectMake(0, self.wind_pic.frame.origin.y + 30, Lewidth, 1)];
    [self.xian_2 setFrame:CGRectMake(0, Lehigh - 20 - 44 - 9, Lewidth, 1)];
    [self.xian_3 setFrame:CGRectMake(Lewidth / 2.0, self.xian_1.frame.origin.y, 1, self.xian_2.frame.origin.y - self.xian_1.frame.origin.y)];
    
    [self.jintian setFrame:CGRectMake(10, self.xian_1.frame.origin.y + 10, 40, 20)];
    [self.mingtian setFrame:CGRectMake(Lewidth / 2.0 + 10, self.xian_1.frame.origin.y + 10, 40, 20)];
    [self.jt_tem setFrame:CGRectMake(Lewidth / 2.0 - 100, self.xian_1.frame.origin.y + 10, 90, 20)];
    [self.mt_tem setFrame:CGRectMake(Lewidth - 100, self.xian_1.frame.origin.y + 10, 90, 20)];
    [self.jt_wea setFrame:CGRectMake(10, self.jintian.frame.origin.y + 30, 130, 20)];
    [self.mt_wea setFrame:CGRectMake(Lewidth / 2.0 + 10, self.jintian.frame.origin.y + 30, 130, 20)];
    [self.jt_image setFrame:CGRectMake(Lewidth / 2.0 - 40, self.jt_wea.frame.origin.y - 9, 30, 30)];
    [self.mt_image setFrame:CGRectMake(Lewidth - 40, self.jt_wea.frame.origin.y - 9, 30, 30)];
    
    [self.av_tem_1 setFrame:CGRectMake(10, 30, 25, 20)];
    [self.av_tem_2 setFrame:CGRectMake(10, 60, 25, 20)];
    [self.av_tem_3 setFrame:CGRectMake(10, 90, 25, 20)];
    
//    self.zhexianSV.dataPoints = @[@29, @30, @32, @32, @32, @32, @29, @28, @25, @23, @23, @32, @32, @32, @32, @32, @29, @27, @25, @23, @23, @11, @11, @11];
//    self.five_day.dataPoints = @[@22, @22, @25, @25, @26, @27];
//    self.five_day_1.dataPoints = @[@17, @18, @18, @18, @18, @19];
}

- (void)setModel:(WeatherModel *)model
{
    if (self.dic.allKeys.count < 2) {
        NSLog(@"无法获取数据");
        return;
    }
    
    [self.zhexianSV removeFromSuperview];
    
    self.zhexianSV = [[FDGraphScrollView alloc] initWithFrame:CGRectMake(30, Lehigh - 8 - 64, Lewidth - 30, 140)];
    //        [self.zhexianSV setBackgroundColor:[UIColor grayColor]];
    [self.zhexianSV setShowsHorizontalScrollIndicator:NO];
    
    NSLog(@"+++++++++++++++++++++");
    NSInteger max = - 100;
    NSInteger min = 100;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [[self.dic objectForKey:@"hourly_forecast"] count]; i++) {
        NSString *temmm = [NSString stringWithFormat:@"%@", [[[self.dic objectForKey:@"hourly_forecast"] objectAtIndex:i] objectForKey:@"temperature"]];
        [arr addObject:temmm];
        if ([temmm integerValue] <= min) {
            min = [temmm integerValue];
        }
        if ([temmm integerValue] >= max) {
            max = [temmm integerValue];
        }
    }
    self.zhexianSV.dataPoints = arr;
    [self.contentView addSubview:self.zhexianSV];
    
    self.av_tem_1.text = [NSString stringWithFormat:@"%ld", max];
    self.av_tem_3.text = [NSString stringWithFormat:@"%ld", min];
    self.av_tem_2.text = [NSString stringWithFormat:@"%ld", (max + min) / 2];
    
    NSInteger tttt = [[[[self.dic objectForKey:@"hourly_forecast"] objectAtIndex:0] objectForKey:@"hour"] integerValue];
    
    for (NSInteger i = 0; i < 24; i++) {
        UILabel *timetime = [[UILabel alloc] init];
        NSString *times = [NSString stringWithFormat:@"%ld:00", (tttt + i) % 24];
        if (times.length == 4) {
            times = [NSString stringWithFormat:@"0%@", times];
        }
        timetime.text = times;
        [timetime setFont:[UIFont systemFontOfSize:13]];
        timetime.textAlignment = NSTextAlignmentCenter;
        timetime.textColor = [UIColor whiteColor];
        //            [timetime setBackgroundColor:[UIColor grayColor]];
        [timetime setFrame:CGRectMake(i * 49.9, 120, 45, 20)];
        [self.zhexianSV addSubview:timetime];
    }
    
    
    
    //温度
    self.tem.text = [NSString stringWithFormat:@"%@°", [[[self.dic objectForKey:@"realtime"] objectForKey:@"weather"] objectForKey:@"temperature"]];
    //晴
    self.qing.text = [NSString stringWithFormat:@"%@", [[[self.dic objectForKey:@"realtime"] objectForKey:@"weather"] objectForKey:@"info"]];
    //几级风
    self.wind_label.text = [NSString stringWithFormat:@"%@", [[[self.dic objectForKey:@"realtime"] objectForKey:@"wind"] objectForKey:@"power"]];
    //湿度
    self.wet_label.text = [NSString stringWithFormat:@"%@%%", [[[self.dic objectForKey:@"realtime"] objectForKey:@"weather"] objectForKey:@"humidity"]];
    
    NSInteger gmt = [[[self.dic objectForKey:@"realtime"] objectForKey:@"dataUptime"] integerValue];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:gmt];
    NSLog(@"1434089463  = %@",confromTimesp);
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: confromTimesp];
//    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
//    NSLog(@"%@", localeDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@" HH:mm"];
    NSString *dateStr = [formatter stringFromDate:confromTimesp];
    self.jidianfabu = dateStr;
    NSLog(@"%@", dateStr);
//    self.fabuTime.text = [NSString stringWithFormat:@"%@%@发布", self.zhouji, dateStr];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dateStr = [formatter stringFromDate:confromTimesp];
    self.timeData.text = dateStr;
    
    [formatter setDateFormat:@"E"];
    dateStr = [formatter stringFromDate:confromTimesp];
    self.zhouji = dateStr;
    
    //今天温度
    NSString *baitian = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:2];
    NSString *wanshang = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"info"] objectForKey:@"night"] objectAtIndex:2];
    self.jt_tem.text = [NSString stringWithFormat:@"%@/%@°C", baitian, wanshang];
    //今天天气
    self.jt_wea.text = [NSString stringWithFormat:@"%@", [[[self.dic objectForKey:@"realtime"] objectForKey:@"weather"] objectForKey:@"info"]];
    //明天温度
    NSString *baitian_1 = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:1] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:2];
    NSString *wanshang_1 = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:1] objectForKey:@"info"] objectForKey:@"night"] objectAtIndex:2];
    self.mt_tem.text = [NSString stringWithFormat:@"%@/%@°C", baitian_1, wanshang_1];
    //今天天气图片
    NSString *jintian_img = [NSString stringWithFormat:@"%@", [[[self.dic objectForKey:@"realtime"] objectForKey:@"weather"] objectForKey:@"img"]];
    if (jintian_img.length == 2) {
        [self.jt_image setImage:[UIImage imageNamed:@"7"]];
    }
    else
    [self.jt_image setImage:[UIImage imageNamed:jintian_img]];
    //明天天气图片
    NSString *mingtian_img = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:1] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:0];
    [self.mt_image setImage:[UIImage imageNamed:mingtian_img]];
    //明天天气
    self.mt_wea.text = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:1] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:1];
    //五天风
//    days_wind.text = @"东北风\n3~4级";
    
    if (self.xuansha) {
        [self.back_two removeFromSuperview];
        self.back_two = [[UIView alloc] initWithFrame:CGRectMake(0, self.zhexianSV.frame.origin.y + 160, Lewidth, 320)];
        [self.back_two setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
        [self.contentView addSubview:self.back_two];
    }
    for (NSInteger j = 0; j < 6; j++) {
        self.xuansha = YES;
        
        if (j % 2 != 0) {
            UIView *days_back = [[UIView alloc] init];
            [days_back setBackgroundColor:[UIColor blackColor]];
            days_back.alpha = 0.05;
            [days_back setFrame:CGRectMake(Lewidth / 6.0 * j, 30, Lewidth / 6.0, self.back_two.frame.size.height - 30)];
            [self.back_two addSubview:days_back];
        }
        //周几
        NSArray *mon_tur = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
        NSInteger ppp = 0;
        for (NSInteger k = 0; k < 7; k++) {
            if ([self.zhouji isEqualToString:mon_tur[k]]) {
                ppp = k;
                break;
            }
        }
        UILabel *days = [[UILabel alloc] init];
        [days setFont:[UIFont systemFontOfSize:15]];
        switch (j) {
            case 0:
                days.text = @"昨天";
                break;
            case 1:
                days.text = @"今天";
                break;
            default:
                days.text = mon_tur[j + ppp - 1];
                break;
        }
        days.textAlignment = NSTextAlignmentCenter;
        days.textColor = [UIColor whiteColor];
        [days setFrame:CGRectMake(Lewidth / 6.0 * j + 10, 30, Lewidth / 6.0 - 20, 20)];
        //            [days setBackgroundColor:[UIColor blueColor]];
        [self.back_two addSubview:days];
        
        UILabel *days_time = [[UILabel alloc] init];
        [days_time setFont:[UIFont systemFontOfSize:11]];
        NSString *shijiana = [[[self.dic objectForKey:@"weather"] objectAtIndex:j] objectForKey:@"date"];
        NSString *jifenfena = [shijiana substringFromIndex:5];
        NSString *jiyuefen_a = [jifenfena substringToIndex:2];
        NSLog(@"%@", jiyuefen_a);
        NSString *duoshaohao_a = [jifenfena substringFromIndex:3];
        NSLog(@"%@", duoshaohao_a);
        days_time.text = [NSString stringWithFormat:@"%@/%@", jiyuefen_a, duoshaohao_a];
        days_time.textAlignment = NSTextAlignmentCenter;
        days_time.textColor = [UIColor whiteColor];
        [days_time setFrame:CGRectMake(Lewidth / 6.0 * (j + 1) + 10, 50, Lewidth / 6.0 - 20, 20)];
        //            [days_time setBackgroundColor:[UIColor blueColor]];
        [self.back_two addSubview:days_time];
        
        NSString *temp_day_img = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:j] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:0];
        NSString *temp = [NSString stringWithFormat:@"%@", temp_day_img];
        
        if (temp.length == 2) {
            temp = @"7";
        }
        UIImageView *days_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:temp]];
        [days_image setFrame:CGRectMake(Lewidth / 6.0 * (j + 1) + Lewidth / 6.0 / 2.0 - 15, 75, 30, 30)];
        [self.back_two addSubview:days_image];
        
        NSString *temp_night_img = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:j] objectForKey:@"info"] objectForKey:@"night"] objectAtIndex:0];
        NSString *temp_night = [NSString stringWithFormat:@"0_%@", temp_night_img];
        UIImageView *days_image_night = [[UIImageView alloc] initWithImage:[UIImage imageNamed:temp_night]];
        [days_image_night setFrame:CGRectMake(Lewidth / 6.0 * (j + 1) + Lewidth / 6.0 / 2.0 - 15, 240, 30, 30)];
        [self.back_two addSubview:days_image_night];
        
        //昨天
        if (j == 0) {
            NSString *temp_day_img_2 = [[[[[[self.dic objectForKey:@"historyWeather"] objectForKey:@"history"] objectForKey:@"1"] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:0];
            NSString *temp_2 = [NSString stringWithFormat:@"%@", temp_day_img_2];
            UIImageView *days_image_2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:temp_2]];
            [days_image_2 setFrame:CGRectMake(Lewidth / 6.0 * j + Lewidth / 6.0 / 2.0 - 15, 75, 30, 30)];
            [self.back_two addSubview:days_image_2];
            
            NSString *temp_night_img_2 = [[[[[[self.dic objectForKey:@"historyWeather"] objectForKey:@"history"] objectForKey:@"1"] objectForKey:@"info"] objectForKey:@"night"] objectAtIndex:0];
            NSString *temp_night_2 = [NSString stringWithFormat:@"0_%@", temp_night_img_2];
            UIImageView *days_image_night_2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:temp_night_2]];
            [days_image_night_2 setFrame:CGRectMake(Lewidth / 6.0 * j + Lewidth / 6.0 / 2.0 - 15, 240, 30, 30)];
            [self.back_two addSubview:days_image_night_2];
            
            UILabel *days_wind_5 = [[UILabel alloc] init];
            NSString *papapa_5 = [[[[[[self.dic objectForKey:@"historyWeather"] objectForKey:@"history"] objectForKey:@"1"] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:4];
            NSString *apapap_5 = [[[[[[self.dic objectForKey:@"historyWeather"] objectForKey:@"history"] objectForKey:@"1"] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:3];
            if ([apapap_5 isEqualToString:@"无持续风向"]) {
                apapap_5 = @"-";
            }
            days_wind_5.text = [NSString stringWithFormat:@"%@\n%@", apapap_5, papapa_5];
//            days_wind_1.tag = (j + 1) * 1000 + 5;
            days_wind_5.numberOfLines = 0;
            [days_wind_5 setFont:[UIFont systemFontOfSize:13]];
            days_wind_5.textAlignment = NSTextAlignmentCenter;
            days_wind_5.textColor = [UIColor whiteColor];
            //            [days_wind setBackgroundColor:[UIColor blueColor]];
            [days_wind_5 setFrame:CGRectMake(Lewidth / 6.0 * j + Lewidth / 6.0 / 2.0 - 20, 280, 40, 35)];
            [self.back_two addSubview:days_wind_5];
            
            
            UILabel *days_time = [[UILabel alloc] init];
            [days_time setFont:[UIFont systemFontOfSize:11]];
            NSString *shijiana = [[[[self.dic objectForKey:@"historyWeather"] objectForKey:@"history"] objectForKey:@"1"] objectForKey:@"date"];
            NSString *jifenfena = [shijiana substringFromIndex:5];
            NSString *jiyuefen_a = [jifenfena substringToIndex:2];
            NSLog(@"%@", jiyuefen_a);
            NSString *duoshaohao_a = [jifenfena substringFromIndex:3];
            NSLog(@"%@", duoshaohao_a);
            days_time.text = [NSString stringWithFormat:@"%@/%@", jiyuefen_a, duoshaohao_a];
            days_time.textAlignment = NSTextAlignmentCenter;
            days_time.textColor = [UIColor whiteColor];
            [days_time setFrame:CGRectMake(10, 50, Lewidth / 6.0 - 20, 20)];
            //            [days_time setBackgroundColor:[UIColor blueColor]];
            [self.back_two addSubview:days_time];
            
            
        }
        
        UILabel *days_wind = [[UILabel alloc] init];
        NSString *papapa = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:j] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:4];
        NSString *apapap = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:j] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:3];
        if ([apapap isEqualToString:@"无持续风向"]) {
            apapap = @"-";
        }
        days_wind.text = [NSString stringWithFormat:@"%@\n%@", apapap, papapa];
        days_wind.tag = (j + 1) * 1000 + 5;
        days_wind.numberOfLines = 0;
        [days_wind setFont:[UIFont systemFontOfSize:13]];
        days_wind.textAlignment = NSTextAlignmentCenter;
        days_wind.textColor = [UIColor whiteColor];
        //            [days_wind setBackgroundColor:[UIColor blueColor]];
        [days_wind setFrame:CGRectMake(Lewidth / 6.0 * (j + 1) + Lewidth / 6.0 / 2.0 - 20, 280, 40, 35)];
        [self.back_two addSubview:days_wind];
        
    }
    
//    [self.five_day removeFromSuperview];
//    [self.five_day_1 removeFromSuperview];
    
    self.five_day = [[FDGraphScrollView alloc] initWithFrame:CGRectMake(0, 125, Lewidth, 50)];
    //        [self.five_day setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    self.five_day.graphView.linesColor = [UIColor colorWithRed:248 / 255.0 green:183 / 255.0 blue:61 / 255.0 alpha:1];
    self.five_day.graphView.edgeInsets = UIEdgeInsetsMake(10, 30, 10, 30);
    self.five_day.graphView.dataPointsXoffset = (Lewidth - 60) / 5.0 - 1;
    self.five_day.graphView.autoresizeToFitData = YES;
    [self.five_day setBounces:NO];
    [self.five_day setShowsHorizontalScrollIndicator:NO];
    [self.back_two addSubview:self.five_day];
    
    self.five_day_1 = [[FDGraphScrollView alloc] initWithFrame:CGRectMake(0, self.five_day.frame.origin.y + 50, Lewidth, 50)];
    //        [self.five_day_1 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    self.five_day_1.graphView.linesColor = [UIColor colorWithRed:40 / 255.0 green:172 / 255.0 blue:249 / 255.0 alpha:1];
    self.five_day_1.graphView.edgeInsets = UIEdgeInsetsMake(10, 30, 10, 30);
    self.five_day_1.graphView.dataPointsXoffset = (Lewidth - 60) / 5.0 - 1;
    self.five_day_1.graphView.autoresizeToFitData = YES;
    [self.five_day_1 setBounces:NO];
    [self.five_day_1 setShowsHorizontalScrollIndicator:NO];
    [self.back_two addSubview:self.five_day_1];
    
    NSInteger haha_max = -100;
    NSInteger haha_min = 100;
    //5天白天温度
    NSMutableArray *arr_1 = [NSMutableArray array];
    [arr_1 addObject:[[[[[[self.dic objectForKey:@"historyWeather"] objectForKey:@"history"] objectForKey:@"1"] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:2]];
    for (NSInteger i = 0; i < [[self.dic objectForKey:@"weather"] count] - 2; i++) {
        NSString *temmm = [NSString stringWithFormat:@"%@", [[[[[self.dic objectForKey:@"weather"] objectAtIndex:i] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:2]];
        if ([temmm integerValue] <= haha_min) {
            haha_min = [temmm integerValue];
        }
        if ([temmm integerValue] >= haha_max) {
            haha_max = [temmm integerValue];
        }
        [arr_1 addObject:temmm];
    }
    
    NSInteger haha_max_ye = -100;
    NSInteger haha_min_ye = 100;
    
    //5天夜间温度
    NSMutableArray *arr_2 = [NSMutableArray array];
    [arr_2 addObject:[[[[[[self.dic objectForKey:@"historyWeather"] objectForKey:@"history"] objectForKey:@"1"] objectForKey:@"info"] objectForKey:@"night"] objectAtIndex:2]];
    for (NSInteger i = 0; i < [[self.dic objectForKey:@"weather"] count] - 2; i++) {
        NSString *temmm_2 = [NSString stringWithFormat:@"%@", [[[[[self.dic objectForKey:@"weather"] objectAtIndex:i] objectForKey:@"info"] objectForKey:@"night"] objectAtIndex:2]];
        if ([temmm_2 integerValue] <= haha_min_ye) {
            haha_min_ye = [temmm_2 integerValue];
        }
        if ([temmm_2 integerValue] >= haha_max_ye) {
            haha_max_ye = [temmm_2 integerValue];
        }
        [arr_2 addObject:temmm_2];
    }
    //数组赋值 (折线图)
    self.five_day.dataPoints = arr_1;
    self.five_day_1.dataPoints = arr_2;
    
    for (NSInteger jj = 0; jj < 6; jj++) {
        UILabel *one_haha = [[UILabel alloc] init];
        one_haha.frame = CGRectMake(Lewidth / 6.0 * jj + Lewidth / 6.0 / 2.0 - 20, 110, 40, 20);
//        [one_haha setBackgroundColor:[UIColor grayColor]];
        [one_haha setFont:[UIFont systemFontOfSize:14]];
        [one_haha setTextAlignment:NSTextAlignmentCenter];
        one_haha.text = [[arr_1 objectAtIndex:jj] stringByAppendingString:@"°"];
        one_haha.textColor = [UIColor whiteColor];
        [self.back_two addSubview:one_haha];
        
        UILabel *two_haha = [[UILabel alloc] init];
        two_haha.frame = CGRectMake(Lewidth / 6.0 * jj + Lewidth / 6.0 / 2.0 - 20, 220, 40, 20);
        //        [one_haha setBackgroundColor:[UIColor grayColor]];
        [two_haha setFont:[UIFont systemFontOfSize:14]];
        [two_haha setTextAlignment:NSTextAlignmentCenter];
        two_haha.text = [[arr_2 objectAtIndex:jj] stringByAppendingString:@"°"];
        two_haha.textColor = [UIColor whiteColor];
        [self.back_two addSubview:two_haha];
        
    }
    
    
    self.fabuTime.text = [NSString stringWithFormat:@"%@%@发布", self.zhouji, self.jidianfabu];
    
    if ([[[self.dic objectForKey:@"pm25"] allKeys] count] == 0) {
        self.weather_1_back.hidden = YES;
    }
    else
    {
        self.weather_1_back.hidden = NO;
        NSString *kongqi_shuzi = [[self.dic objectForKey:@"pm25"] objectForKey:@"aqi"];
        NSString *kongqi_liang = [[self.dic objectForKey:@"pm25"] objectForKey:@"quality"];
        self.liang.text = [NSString stringWithFormat:@"%@\n%@", kongqi_shuzi, kongqi_liang];
    }
    //75良
    
    //预警判断
    for (NSString *keysss in self.dic) {
        if ([keysss isEqualToString:@"alert"]) {
            self.weather_2_back.hidden = NO;
            self.yujing.text = [NSString stringWithFormat:@"%d个预警", [[self.dic objectForKey:@"alert"] count]];
//            NSLog(@"123");
            break;
        }
        else
        {
            self.weather_2_back.hidden = YES;
//            NSLog(@"456");
        }
    }
}

- (void)yujing_tap_tap
{
    NSLog(@"点击");
    [self.delegate get:@"88"];
}

- (void)speak_tap
{
    self.speak_dada = [NSMutableArray array];
    NSLog(@"开始说话");
    //今天天气
    NSString *t_qing = [NSString stringWithFormat:@"%@", [[[self.dic objectForKey:@"realtime"] objectForKey:@"weather"] objectForKey:@"img"]];
    
    //今天温度
    NSString *baitian = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:2];
    NSString *wanshang = [[[[[self.dic objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"info"] objectForKey:@"night"] objectAtIndex:2];
    NSLog(@"%ld %ld", baitian.length, wanshang.length);
    
    [self.speak_dada addObject:@"d_jintian"];
    [self.speak_dada addObject:[NSString stringWithFormat:@"d_%@", @"baitian"]];
    [self.speak_dada addObject:[NSString stringWithFormat:@"p_%@", @"dao"]];
    [self.speak_dada addObject:[NSString stringWithFormat:@"d_%@", @"yejian"]];
    if (baitian.length == 2) {
        NSString *baitian_1 = [baitian substringToIndex:1];
        NSString *baitian_2 = [baitian substringFromIndex:1];
        if ([baitian_1 isEqualToString:@"1"]) {
            [self.speak_dada addObject:[NSString stringWithFormat:@"n_%ld", 10]];
        }
        else
        {
            [self.speak_dada addObject:[NSString stringWithFormat:@"n_%@", baitian_1]];
            [self.speak_dada addObject:[NSString stringWithFormat:@"n_%ld", 10]];
        }
        [self.speak_dada addObject:[NSString stringWithFormat:@"n_%@", baitian_2]];
    }
    else
    {
        [self.speak_dada addObject:[NSString stringWithFormat:@"n_%@", @"dao"]];
    }
    [self.speak_dada addObject:[NSString stringWithFormat:@"%@", @"degree_du_0000"]];
    [self.speak_dada addObject:[NSString stringWithFormat:@"p_%@", @"dao"]];
    if (wanshang.length == 2) {
        NSString *wanshang_1 = [wanshang substringToIndex:1];
        NSString *wanshang_2 = [wanshang substringFromIndex:1];
        if ([wanshang_1 isEqualToString:@"1"]) {
            [self.speak_dada addObject:[NSString stringWithFormat:@"n_%ld", 10]];
        }
        else
        {
            [self.speak_dada addObject:[NSString stringWithFormat:@"n_%@", wanshang_1]];
            [self.speak_dada addObject:[NSString stringWithFormat:@"n_%ld", 10]];
        }
        [self.speak_dada addObject:[NSString stringWithFormat:@"n_%@", wanshang_2]];
    }
    else
    {
        [self.speak_dada addObject:[NSString stringWithFormat:@"n_%@", wanshang]];
    }
    [self.speak_dada addObject:[NSString stringWithFormat:@"%@", @"degree_du_0000"]];
    
    //什么风
    NSString *speak_wind = [NSString stringWithFormat:@"%@", [[[self.dic objectForKey:@"realtime"] objectForKey:@"wind"] objectForKey:@"direct"]];
    if ([speak_wind isEqualToString:@"北风"]) {
        speak_wind = @"wind_beifeng";
    }
    else if ([speak_wind isEqualToString:@"东北风"]) {
        speak_wind = @"wind_dongbeifeng";
    }
    else if ([speak_wind isEqualToString:@"东风"]) {
        speak_wind = @"wind_dongfeng";
    }
    else if ([speak_wind isEqualToString:@"东南风"]) {
        speak_wind = @"wind_dongnanfeng";
    }
    else if ([speak_wind isEqualToString:@"西北风"]) {
        speak_wind = @"wind_xibeifeng";
    }
    else if ([speak_wind isEqualToString:@"西风"]) {
        speak_wind = @"wind_xifeng";
    }
    else if ([speak_wind isEqualToString:@"西南风"]) {
        speak_wind = @"wind_xinanfeng";
    }
    else
        speak_wind  = @"wind_weifeng";
    [self.speak_dada addObject:speak_wind];
    //几级风
    NSString *speak_wind_num = [NSString stringWithFormat:@"%@", [[[self.dic objectForKey:@"realtime"] objectForKey:@"wind"] objectForKey:@"power"]];
    NSString *speak_wind_num_temp = [speak_wind_num substringToIndex:1];
    NSLog(@"%@", speak_wind_num_temp);
    NSString *speak_wind_ji = [NSString stringWithFormat:@"n_%@", speak_wind_num_temp];
    [self.speak_dada addObject:speak_wind_ji];
    [self.speak_dada addObject:@"p_ji"];
    
    
    
    
    
    
    [self play_av];
}

- (void)play_av
{
    if (self.speak_num == self.speak_dada.count) {
        [self.player stop];
        [self.speak_dada removeAllObjects];
        self.speak_num = 0;
        return;
    }
    NSString *av_path = [[NSBundle mainBundle] pathForResource:[self.speak_dada objectAtIndex:self.speak_num] ofType:@"wav"];
    NSURL *url_url = [[NSURL alloc] initFileURLWithPath:av_path];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url_url error:nil];
    self.player.delegate = self;
    [self.player play];
    self.speak_num++;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
//    播放结束时执行的动作
    [self play_av];
}

@end








