//
//  RootViewController.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/8.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "RootViewController.h"
#import <AMapSearchAPI.h>
#import "TFHpple.h"
#import "XMLModel.h"
#import "XMLModel_city.h"
#import "XMLModel_county.h"
#import "QCHttpHandler.h"
#import <UIViewController+MMDrawerController.h>
#import <MMDrawerVisualState.h>
#import <MMDrawerBarButtonItem.h>
#define RESULT @"result"
#import "WeatherCollectionViewCell.h"
#import "WeatherModel.h"
#import "TwoWeatherCollectionViewCell.h"

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import <AVFoundation/AVFoundation.h>
#import "YuJingViewController.h"
#import "UMSocial.h"
#import "UMSocialData.h"

#import "UMSocialScreenShoter.h"
#import <CoreLocation/CoreLocation.h>
#import "OtherViewController.h"



#import "Entity.h"

@interface RootViewController ()<AMapSearchDelegate, UICollectionViewDataSource, UICollectionViewDelegate, CHuanZhi_2, UIAlertViewDelegate, UMSocialUIDelegate, CLLocationManagerDelegate, KanKan>
{
    AMapSearchAPI *_search;
}
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *weather_1;
@property (nonatomic, copy) NSString *weather_2;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, strong) UIScrollView *sview;
@property (nonatomic, strong) UIView *black_img;
@property (nonatomic, strong) CoreDataManager *coreDataManager;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) UILabel *place_title;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, strong) NSMutableArray *zong_array;
@property (nonatomic, strong) NSDictionary *content_1;
@property (nonatomic, assign) NSInteger index_num;
@property (nonatomic, strong) WeatherCollectionViewCell *cell;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) UIAlertView *av;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, assign) CGFloat dingwei_1;
@property (nonatomic, assign) CGFloat dingwei_2;
@property (nonatomic, assign) NSInteger haole;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
    NSLog(@"+++++++++++");
    [self play_av];
    self.index_num = 1;
    self.zong_array = [NSMutableArray array];
    
    self.tabBarController.tabBar.hidden = YES;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kaishi) name:@"tongzhi_1" object:nil];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *image_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"48c9cad3_df97c副本.jpg"]];
    [image_view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:image_view];
    
    [self getdashiqing];
    NSLog(@"%f, %f", Lehigh, Lewidth);
}

- (void)getdashiqing
{
    self.array_data = [NSMutableArray array];
    self.coreDataManager = [CoreDataManager shareCoreDataManager];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error");
    }
    [self.array_data setArray:fetchedObjects];
    
    if (self.array_data.count == 0) {
        //创建
        self.manager = [[CLLocationManager alloc] init];
        //签订定位代理
        self.manager.delegate = self;
        
        //精度
        self.manager.distanceFilter = 1000.0f;
        //设置定位效率
        [self.manager setDesiredAccuracy:kCLLocationAccuracyBest];
        //8.0后加入 时时更新
        //        [self.manager requestAlwaysAuthorization];
        //开始更新位置
        [self.manager startUpdatingLocation];
        NSLog(@"-----------------------");
    }
    else
    {
        self.weather = [[self.array_data objectAtIndex:0] cityId];
        if (self.array.count <= 1) {
            [self getXML];
        }
        NSLog(@"%@, %@", [[self.array_data objectAtIndex:0] cityId], [[self.array_data objectAtIndex:0] city]);
        self.weather = [[self.array_data objectAtIndex:0] cityId];
        [self addShareAndMenu];
        [self getData];
    }
}

//状态改变时执行的方法
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.manager requestWhenInUseAuthorization];
            }
            break;
            
        default:
            break;
    }
}

//定位失败时执行的方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
    
    UIAlertView *shibai = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [shibai show];
    OtherViewController *other = [[OtherViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:other];
    other.ppp = 10;
    other.delegate = self;
    [navi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navi animated:YES completion:^{
        navi.navigationItem.leftBarButtonItem = nil;
    }];
    
}

- (void)get:(NSInteger)temp
{
    if (temp == 10) {
        [self getdashiqing];
    }
}

//定位成功时会执行的方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"%lf --- %lf", location.coordinate.latitude, location.coordinate.longitude);
    self.dingwei_1 = location.coordinate.latitude;
    self.dingwei_2 = location.coordinate.longitude;
    [self gaode];
}

- (void)kaishi
{
    NSLog(@"123");
    [self pan_duan];
}

- (void)play_av
{
//    NSString *av_path = [[NSBundle mainBundle] pathForResource:@"a_kongqitebieganzao" ofType:@"wav"];
//    NSURL *url_url = [[NSURL alloc] initFileURLWithPath:av_path];
//    NSError *error;
//    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url_url error:&error];
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }
////    [player prepareToPlay];
//    self.player.volume = 1.0;
//    [self.player play];
//    
}

- (void)shaqi
{
//    NSLog(@"%@",text.userInfo[@"textOne"]);
    
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error");
    }
    [self.array_data setArray:fetchedObjects];
    
    
    NSLog(@"%ld %ld", self.zong_array.count, self.array_data.count);
    
    if (self.array_data.count > self.zong_array.count) {
        NSLog(@"%ld %ld", self.zong_array.count, self.array_data.count);
        NSDate *now_date = [NSDate date];
        NSTimeInterval time_since = [now_date timeIntervalSince1970] * 1000 / 1;
        NSInteger ttttt = time_since;
        self.weather = [[self.array_data objectAtIndex:self.zong_array.count] cityId];
        [QCHttpHandler get:[NSString stringWithFormat:@"http://tqapi.mobile.360.cn/city/%@?pkg=net.qihoo.launcher.widget.clockweather&cver=44&ver=1&token=zMUEPV2fhB0HwdNDbAkOg&t=%ld", self.weather, ttttt] body:nil result:(QCHttp) success:^(id result) {
            NSString *aString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
            NSLog(@"%@", aString);
            if ([[NSString stringWithFormat:@"%@", [aString substringToIndex:4]] isEqualToString:@"http"]) {
                [QCHttpHandler get:aString body:nil result:QCHttp success:^(id result) {
                    self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
                    [self.zong_array addObject:self.content];
                    [self pan_duan];
                } failure:^(NSError *error) {
                    //
                }];
            }
            else
            {
                self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
                [self.zong_array addObject:self.content];
                [self pan_duan];
            }
        } failure:^(NSError *error) {
            NSLog(@"error");
        }];
    }
    
}

- (void)pan_duan
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error");
    }
    [self.array_data setArray:fetchedObjects];
    NSLog(@"%ld %ld", self.array_data.count, self.zong_array.count);
    if (self.array_data.count > self.zong_array.count) {
        NSLog(@"正在加载");
        if (!self.av) {
            self.av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"正在获取" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [self.av show];
        }
        [self shaqi];
    }
    else
    {
        NSLog(@"加载完成");
        if (self.zong_array.count != 0) {
            NSLog(@"%ld", self.array_data.count);
            [self.collectionView reloadData];
        }
        [self.av dismissWithClickedButtonIndex:0 animated:YES];
        [self.av removeFromSuperview];
    }
    
    NSLog(@"4");
    
}

- (void)tongzhi:(NSNotification *)text
{
    
    
    NSLog(@"%@",text.userInfo[@"textOne"]);
    NSLog(@"－－－－－接收到通知------");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSString *chose_num = [NSString stringWithFormat:@"%@", text.userInfo[@"textTwo"]];
    NSString *chose_num_num = [NSString stringWithFormat:@"%@", text.userInfo[@"textThree"]];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error");
    }
    [self.array_data setArray:fetchedObjects];
    
    if ([text.userInfo[@"textOne"] count] == 0) {
        NSLog(@"%ld", self.array_data.count);
        NSLog(@"%ld", self.zong_array.count);
        if (self.array_data.count != self.zong_array.count) {
//            NSDate *now_date = [NSDate date];
//            NSTimeInterval time_since = [now_date timeIntervalSince1970] * 1000 / 1;
//            NSInteger ttttt = time_since;
//            self.weather = [[self.array_data objectAtIndex:self.array_data.count] cityId];
//            [QCHttpHandler get:[NSString stringWithFormat:@"http://tqapi.mobile.360.cn/city/%@?pkg=net.qihoo.launcher.widget.clockweather&cver=44&ver=1&token=zMUEPV2fhB0HwdNDbAkOg&t=%ld", self.weather, ttttt] body:nil result:QCHttp success:^(id result) {
//                NSString *aString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
//                NSLog(@"%@", aString);
//                if ([[NSString stringWithFormat:@"%@", [aString substringToIndex:4]] isEqualToString:@"http"]) {
//                    [QCHttpHandler get:aString body:nil result:QCHttp success:^(id result) {
//                        self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
//                        [self.zong_array addObject:self.content];
//                        self.place_title.text = [[[[self.zong_array objectAtIndex:[chose_num_num integerValue]] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
//                        [self.collectionView reloadData];
//                    } failure:^(NSError *error) {
//                        //
//                    }];
//                }
//                else
//                {
//                    self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
//                    [self.zong_array addObject:self.content];
//                    self.place_title.text = [[[[self.zong_array objectAtIndex:[chose_num_num integerValue]] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
//                    [self.collectionView reloadData];
//                }
//                
//            } failure:^(NSError *error) {
//                //
//                NSLog(@"error");
//            }];
        }
    }
    else
    {
        for (NSInteger i = 0; i < [text.userInfo[@"textOne"] count]; i++) {
            NSInteger num = [[text.userInfo[@"textOne"] objectAtIndex:i] integerValue];
            NSManagedObject *manager = [self.array_data objectAtIndex:num];
            [self.coreDataManager.managedObjectContext deleteObject:manager];
            [self.array_data removeObjectAtIndex:num];
            [self.zong_array removeObjectAtIndex:num];
        }
        [self.coreDataManager saveContext];
        
        if (self.zong_array.count == 0) {
            //
        }
        else
        {
            
            NSFetchRequest *fetchRequest_1 = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity_1 = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
            [fetchRequest_1 setEntity:entity_1];
            NSError *error_1 = nil;
            NSArray *fetchedObjects_1 = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest_1 error:&error_1];
            if (fetchedObjects_1 == nil) {
                NSLog(@"error");
            }
            [self.array_data setArray:fetchedObjects_1];
            
            
            if (self.zong_array.count != 0) {
                NSLog(@"%ld", self.array_data.count);
                [self.collectionView reloadData];
            }
        }
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
        [fetchRequest setEntity:entity];
        NSError *error = nil;
        NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects == nil) {
            NSLog(@"error");
        }
        if (self.array_data.count == 0) {
            return;
        }
        if (self.zong_array.count == 0) {
            //
        }
        else
        {
            if (self.zong_array.count != 0) {
                NSLog(@"%ld", self.array_data.count);
                [self.collectionView reloadData];
            }
        }
        NSInteger ggg = self.collectionView.contentOffset.x;
        NSLog(@"%ld", ggg);
        if (ggg / Lewidth == self.zong_array.count) {
            self.place_title.text = [[[[self.zong_array objectAtIndex:ggg / Lewidth - 1] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
        }
        else
        self.place_title.text = [[[[self.zong_array objectAtIndex:ggg / Lewidth] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
        
    }
    NSLog(@"%@, %@", chose_num, chose_num_num);
    if ([chose_num isEqualToString:@"5"]) {
        self.collectionView.contentOffset = CGPointMake([chose_num_num integerValue] * Lewidth, 0);
        self.place_title.text = @"";
        self.place_title.text = [[[[self.zong_array objectAtIndex:[chose_num_num integerValue]] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
    }
    if (self.zong_array.count != 0) {
        NSLog(@"%ld", self.array_data.count);
        [self.collectionView reloadData];
    }
}

- (void)gaode
{
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] initWithSearchKey:@"196233259d24e7cd8e6dbc7d937262f2" Delegate:self];
    
    //构造AMapReGeocodeSearchRequest对象，location为必选项，radius为可选项
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:self.dingwei_1 longitude:self.dingwei_2];
    regeoRequest.radius = 10000;
    regeoRequest.requireExtension = YES;
    
    //发起逆地理编码
    [_search AMapReGoecodeSearch: regeoRequest];
    NSLog(@"123");
    [self getXML];
    [self addShareAndMenu];
}

- (void)creatCollect
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(Lewidth, Lehigh - 50 - 49);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, Lewidth, Lehigh - 50) collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[WeatherCollectionViewCell class] forCellWithReuseIdentifier:RESULT];
    [self creatImage];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:RESULT forIndexPath:indexPath];
    self.cell.dele = self;
    NSLog(@"*****%ld", self.zong_array.count);
    self.cell.dic = [NSMutableDictionary dictionary];
    self.index_num = indexPath.row;
    self.cell.haole = self.haole;
    NSLog(@"//////%ld", self.index_num);
    if (self.zong_array.count <= indexPath.row && indexPath.row != 0) {
        //
    }
    else
    {
        [self.cell.dic setValuesForKeysWithDictionary:[self.zong_array objectAtIndex:indexPath.row]];
        [self.content_1 setValuesForKeysWithDictionary:[self.zong_array objectAtIndex:indexPath.row]];
        [self.cell.collection reloadData];
        
        self.place_title.text = [[[[self.zong_array objectAtIndex:indexPath.row] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
        
    }
    return self.cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat fff = scrollView.contentOffset.x;
    NSLog(@"------%f", fff);
    self.index_num = fff / Lewidth;
    NSLog(@"%ld", self.index_num);
    if (self.zong_array.count == self.index_num) {
        NSLog(@"走了");
        NSDate *now_date = [NSDate date];
        NSTimeInterval time_since = [now_date timeIntervalSince1970] * 1000 / 1;
        NSInteger ttttt = time_since;
        self.weather = [[self.array_data objectAtIndex:self.index_num] cityId];
        NSInteger hhh = self.index_num;
        [QCHttpHandler get:[NSString stringWithFormat:@"http://tqapi.mobile.360.cn/city/%@?pkg=net.qihoo.launcher.widget.clockweather&cver=44&ver=1&token=zMUEPV2fhB0HwdNDbAkOg&t=%ld", self.weather, ttttt] body:nil result:QCHttp success:^(id result) {
            NSString *aString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
            if ([[NSString stringWithFormat:@"%@", [aString substringToIndex:4]] isEqualToString:@"http"]) {
                [QCHttpHandler get:aString body:nil result:QCHttp success:^(id result) {
                    self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
                    [self.zong_array addObject:self.content];
                    self.place_title.text = [[[[self.zong_array objectAtIndex:hhh] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
                    NSLog(@"%@", self.place_title.text);
                    [self.cell.dic setValuesForKeysWithDictionary:[self.zong_array objectAtIndex:self.index_num]];
                    [self.content_1 setValuesForKeysWithDictionary:[self.zong_array objectAtIndex:self.index_num]];
                    [self creatImage];
                    [self.cell.collection reloadData];
                } failure:^(NSError *error) {
                    //
                }];
            }
            else
            {
                self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
                [self.zong_array addObject:self.content];
                [self.cell.dic setValuesForKeysWithDictionary:[self.zong_array objectAtIndex:self.index_num]];
                [self.content_1 setValuesForKeysWithDictionary:[self.zong_array objectAtIndex:self.index_num]];
                [self creatImage];
                [self.cell.collection reloadData];
                self.place_title.text = [[[[self.zong_array objectAtIndex:hhh] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
            }
        } failure:^(NSError *error) {
            //
            NSLog(@"error");
        }];
    }
    else
    {
        self.place_title.text = [[[[self.zong_array objectAtIndex:self.index_num] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
    }
    [self creatImage];
    if (self.zong_array.count != 0) {
        NSLog(@"%ld", self.array_data.count);
        [self.collectionView reloadData];
    }
}

- (void)post:(NSString *)temoo
{
    //    [self.view bringSubviewToFront:self.black_img];
    
    if ([temoo isEqualToString:@"0"]) {
        [self.view bringSubviewToFront:self.black_img];
        self.black_img.hidden = NO;
    }
    if ([temoo isEqualToString:@"77"]) {
        NSDate *now_date = [NSDate date];
        NSTimeInterval time_since = [now_date timeIntervalSince1970] * 1000 / 1;
        NSInteger ttttt = time_since;
        self.weather = [[self.array_data objectAtIndex:self.index_num] cityId];
        NSInteger hhh = self.index_num;
        [QCHttpHandler get:[NSString stringWithFormat:@"http://tqapi.mobile.360.cn/city/%@?pkg=net.qihoo.launcher.widget.clockweather&cver=44&ver=1&token=zMUEPV2fhB0HwdNDbAkOg&t=%ld", self.weather, ttttt] body:nil result:QCHttp success:^(id result) {
            NSString *aString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
            if ([[NSString stringWithFormat:@"%@", [aString substringToIndex:4]] isEqualToString:@"http"]) {
                [QCHttpHandler get:aString body:nil result:QCHttp success:^(id result) {
                    self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
                    [self.zong_array replaceObjectAtIndex:self.index_num withObject:self.content];
                    self.haole = 99;
                    [self.collectionView reloadData];
                } failure:^(NSError *error) {
                    //
                }];
            }
            else
            {
                self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
                [self.zong_array replaceObjectAtIndex:self.index_num withObject:self.content];
                self.haole = 99;
                [self.collectionView reloadData];
            }
        } failure:^(NSError *error) {
            //
            NSLog(@"error");
        }];
        
    }
    if ([temoo isEqualToString:@"88"])
    {
        YuJingViewController *yujing_coll = [[YuJingViewController alloc] init];
        yujing_coll.array = [NSMutableDictionary dictionary];
        yujing_coll.array = [self.zong_array objectAtIndex:self.collectionView.contentOffset.x / Lewidth];
        NSLog(@"%ld", self.zong_array.count);
        [yujing_coll setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:yujing_coll animated:YES completion:^{
            //
        }];
    }
    NSLog(@"//%@", temoo);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array_data.count;
}

- (void)creatImage
{
    [self.black_img removeFromSuperview];
    
    self.black_img = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.black_img setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.85]];
    self.black_img.hidden = YES;
    self.black_img.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(view_tap)];
    [self.black_img addGestureRecognizer:tap];
    [self.view addSubview:self.black_img];
//     NSLog(@"%@", self.black_img);
    [self creat_message];
}

-(void)creat_message
{
    
    UILabel *temputer = [[UILabel alloc] initWithFrame:CGRectMake(Lewidth / 2.0 - 100, 100, 200, 100)];
//    [temputer setBackgroundColor:[UIColor yellowColor]];
    if (self.index_num >= self.zong_array.count) {
        self.index_num = self.zong_array.count - 1;
    }
    temputer.text = [NSString stringWithFormat:@" %@°", [[[[self.zong_array objectAtIndex:self.index_num] objectForKey:@"realtime"] objectForKey:@"weather"] objectForKey:@"temperature"]];
    [temputer setFont:[UIFont systemFontOfSize:95]];
    [temputer setTextColor:[UIColor whiteColor]];
    [temputer setTextAlignment:NSTextAlignmentCenter];
    [self.black_img addSubview:temputer];
    
    UILabel *qing = [[UILabel alloc] initWithFrame:CGRectMake(Lewidth / 2.0 - 50, temputer.frame.origin.y + 100, 100, 24)];
//    [qing setBackgroundColor:[UIColor greenColor]];
    qing.text = [NSString stringWithFormat:@"%@", [[[[self.zong_array objectAtIndex:self.index_num] objectForKey:@"realtime"] objectForKey:@"weather"] objectForKey:@"info"]];
    [qing setTextColor:[UIColor whiteColor]];
    [qing setTextAlignment:NSTextAlignmentCenter];
    [qing setFont:[UIFont systemFontOfSize:22]];
    [self.black_img addSubview:qing];
    
    UILabel *ziwaixian = [[UILabel alloc] initWithFrame:CGRectMake(Lewidth / 2.0 - 90, qing.frame.origin.y + 30, 180, 200)];
    [ziwaixian setNumberOfLines:0];
//    [ziwaixian setBackgroundColor:[UIColor grayColor]];
    [ziwaixian setText:@"紫外线\n\n气压\n\n风速\n\n日出\n\n日落"];
    [ziwaixian setTextColor:[UIColor whiteColor]];
    [self.black_img addSubview:ziwaixian];
    
    NSString *ziwai = [[[[[self.zong_array objectAtIndex:self.index_num] objectForKey:@"life"] objectForKey:@"info"] objectForKey:@"ziwaixian"] objectAtIndex:0];
    NSString *qiya = [[[self.zong_array objectAtIndex:self.index_num] objectForKey:@"realtime"] objectForKey:@"pressure"];
    NSString *fengsu = [[[[self.zong_array objectAtIndex:self.index_num] objectForKey:@"realtime"] objectForKey:@"wind"] objectForKey:@"windspeed"];
    NSString *richu = [[[[[[self.zong_array objectAtIndex:self.index_num] objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:5];
    NSString *riluo = [[[[[[self.zong_array objectAtIndex:self.index_num] objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"info"] objectForKey:@"night"] objectAtIndex:5];
    
    UILabel *xianshi = [[UILabel alloc] initWithFrame:CGRectMake(Lewidth / 2.0 - 90, qing.frame.origin.y + 30, 180, 200)];
    [xianshi setNumberOfLines:0];
//    [xianshi setBackgroundColor:[UIColor yellowColor]];
    [xianshi setTextAlignment:NSTextAlignmentRight];
    [xianshi setText:[NSString stringWithFormat:@"%@\n\n%@ hPa\n\n%@ km/h\n\n%@\n\n%@", ziwai, qiya, fengsu, richu, riluo]];
    [xianshi setTextColor:[UIColor whiteColor]];
    [self.black_img addSubview:xianshi];
    
    
}

- (void)view_tap
{
    NSLog(@"12");
    self.black_img.hidden = YES;
}

- (void)addShareAndMenu
{
    UIButton *share = [UIButton buttonWithType:UIButtonTypeSystem];
    [share setImage:[[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [share setFrame:CGRectMake(Lewidth - 40, 30, 25, 25)];
    [share addTarget:self action:@selector(shareTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
    
    UIButton *menu = [UIButton buttonWithType:UIButtonTypeSystem];
    [menu setImage:[[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [menu setFrame:CGRectMake(15, 30, 25, 25)];
    [menu addTarget:self action:@selector(menuTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menu];
    
    self.place_title = [[UILabel alloc] initWithFrame:CGRectMake(Lewidth / 2.0 - 50, 20, 100, 30)];
    [self.place_title setFont:[UIFont systemFontOfSize:20]];
    self.place_title.textColor = [UIColor whiteColor];
//    [self.place_title setBackgroundColor:[UIColor blueColor]];
    self.place_title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.place_title];
    
    
//    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    
}

- (void)shareTap
{
    NSLog(@"分享");
    
    UIImage *image_shoot = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    
    NSString *baitian = [[[[[[self.zong_array objectAtIndex:self.collectionView.contentOffset.x / Lewidth] objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"info"] objectForKey:@"day"] objectAtIndex:2];
    NSString *wanshang = [[[[[[self.zong_array objectAtIndex:self.collectionView.contentOffset.x / Lewidth] objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"info"] objectForKey:@"night"] objectAtIndex:2];
    NSString *zong_wendu = [NSString stringWithFormat:@"%@~%@°C", wanshang, baitian];
    
    NSString *share_name = [NSString stringWithFormat:@"今天%@, %@, %@, %@, %@ -- 来自xu", self.place_title.text = [[[[self.zong_array objectAtIndex:self.collectionView.contentOffset.x / Lewidth] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0], [[[[self.zong_array objectAtIndex:self.collectionView.contentOffset.x / Lewidth] objectForKey:@"realtime"] objectForKey:@"weather"] objectForKey:@"info"], zong_wendu, [[[[self.zong_array objectAtIndex:self.collectionView.contentOffset.x / Lewidth] objectForKey:@"realtime"] objectForKey:@"wind"] objectForKey:@"direct"], [[[[self.zong_array objectAtIndex:self.collectionView.contentOffset.x / Lewidth] objectForKey:@"realtime"] objectForKey:@"wind"] objectForKey:@"power"]];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"558393cf67e58e75ed001670"
                                      shareText:share_name
                                     shareImage:image_shoot
                                shareToSnsNames:@[UMShareToSina]
                                       delegate:self];
    
//    [[UMSocialControllerService defaultControllerService] setShareText:@"测试分享_1" shareImage:[UIImage imageNamed:@"0"] socialUIDelegate:self];        //设置分享内容和回调对象
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}

- (void)menuTap
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
//        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode];
        
        if (response.regeocode.addressComponent.province.length <= 1) {
            NSLog(@"error");
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前无法定位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [av show];
        }
        else
        {
            NSLog(@"%@", [response.regeocode.addressComponent.province substringToIndex:response.regeocode.addressComponent.province.length - 1]);
            self.province = [response.regeocode.addressComponent.province substringToIndex:response.regeocode.addressComponent.province.length - 1];
            NSLog(@"%@", [response.regeocode.addressComponent.city substringToIndex:response.regeocode.addressComponent.city.length - 1]);
            self.city = [response.regeocode.addressComponent.city substringToIndex:response.regeocode.addressComponent.city.length - 1];
            NSLog(@"%@", [response.regeocode.addressComponent.district substringToIndex:response.regeocode.addressComponent.district.length - 1]);
            self.county = [response.regeocode.addressComponent.district substringToIndex:response.regeocode.addressComponent.district.length - 1];
            [self chose];
            
        }
    }
}

//定位信息和xml比较 获取weathercode
- (void)chose
{
    while (self.array.count <= 1) {
        NSLog(@"没来");
    }
    NSLog(@"lailaile");
    
    Entity *time = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    
    for (NSInteger i = 0; i < self.array.count; i++) {
        if ([[self.array[i] name] isEqualToString:self.province]) {
            
            for (NSInteger j = 0; j < [[self.array[i] array] count]; j++) {
                if ([[[[self.array[i] array] objectAtIndex:j] name] isEqualToString:self.city]) {

                    for (NSInteger k = 0; k < [[[[self.array[i] array] objectAtIndex:j] array] count]; k++) {

                        if ([[[[[[self.array[i] array] objectAtIndex:j] array] objectAtIndex:k] name] isEqualToString:self.county]) {
                            NSLog(@"有");
                            self.weather_1 = [[[[[self.array[i] array] objectAtIndex:j] array] objectAtIndex:k] weatherCode];
                            time.city = self.county;
                        }
                        else
                        {
                            NSLog(@"没有");
                            self.weather_2 = [[[[[self.array[i] array] objectAtIndex:j] array] objectAtIndex:0] weatherCode];
                            time.city = self.city;
                        }
                    }
                }
            }
        }
    }
    if (self.weather_1.length <= 2) {
        self.weather = self.weather_2;
    }
    else
        self.weather = self.weather_1;
    NSLog(@"%@", self.weather);
    
    time.cityId = self.weather;
    //将对象插入到第0位
    [self.array_data insertObject:time atIndex:0];
    [self.coreDataManager saveContext];
    
    [self getData];
}

//获取数据
- (void)getData
{
    if (!self.av) {
        self.av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"正在获取" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [self.av show];
    }
    NSLog(@"获取数据");
    NSDate *now_date = [NSDate date];
    NSTimeInterval time_since = [now_date timeIntervalSince1970] * 1000 / 1;
    NSInteger ttttt = time_since;
    NSLog(@"%ld", ttttt);
    [QCHttpHandler get:[NSString stringWithFormat:@"http://tqapi.mobile.360.cn/city/%@?pkg=net.qihoo.launcher.widget.clockweather&cver=44&ver=1&token=zMUEPV2fhB0HwdNDbAkOg&t=%ld", self.weather, ttttt] body:nil result:QCHttp success:^(id result) {
        NSString *aString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        NSLog(@"%@", aString);
        if ([[NSString stringWithFormat:@"%@", [aString substringToIndex:4]] isEqualToString:@"http"]) {
            [QCHttpHandler get:aString body:nil result:QCHttp success:^(id result) {
                self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
                [self.zong_array addObject:self.content];
                self.place_title.text = [[[[self.zong_array objectAtIndex:0] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
                NSLog(@"data %ld", self.content.count);
                [self creatCollect];
                if (self.array_data.count == 1) {
                    [self.av dismissWithClickedButtonIndex:0 animated:YES];
                }
                else
                [self shaqi];
            } failure:^(NSError *error) {
                //
            }];
        }
        else
        {
            self.content = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];//转换数据格式
            [self.zong_array addObject:self.content];
            self.place_title.text = [[[[self.zong_array objectAtIndex:0] objectForKey:@"area"] objectAtIndex:2] objectAtIndex:0];
            NSLog(@"data %ld", self.content.count);
            [self creatCollect];
            if (self.array_data.count == 1) {
                [self.av dismissWithClickedButtonIndex:0 animated:YES];
            }
            else
            [self shaqi];
        }
        
    } failure:^(NSError *error) {
        //
        NSLog(@"error");
    }];
    
    
}

//xml转码
- (void)getXML
{
    self.array = [NSMutableArray array];
    NSLog(@"进来了");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityid" ofType:@"txt"];
//    NSData *xml = [[NSData alloc] initWithContentsOfFile:path];
    NSString *xml = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *TFXML = [[TFHpple alloc] initWithXMLData:data];
    NSArray *TFXMLArr = [TFXML searchWithXPathQuery:@"//China"];
    TFHppleElement *element = TFXMLArr.lastObject;
    
    //取子
    NSArray *pro = element.children;
//    NSLog(@"%@", pro);
    for (TFHppleElement *ele in pro) {
        //遍历子 找到节点
        if ([ele.tagName isEqualToString:@"province"]) {
            //找到name
            XMLModel *mede = [[XMLModel alloc] init];
            mede.ids = ele.attributes[@"id"];
            mede.name = ele.attributes[@"name"];
            
            for (TFHppleElement *ele_1 in ele.children) {
                if ([ele_1.tagName isEqualToString:@"city"]) {
                    XMLModel_city *mede_1 = [[XMLModel_city alloc] init];
                    mede_1.ids = ele_1.attributes[@"id"];
                    mede_1.name = ele_1.attributes[@"name"];
                    
                    for (TFHppleElement *ele_2 in ele_1.children) {
                        if ([ele_2.tagName isEqualToString:@"county"]) {
                            XMLModel_county *mede_2 = [[XMLModel_county alloc] init];
                            mede_2.ids = ele_2.attributes[@"id"];
                            mede_2.name = ele_2.attributes[@"name"];
                            mede_2.weatherCode = ele_2.attributes[@"weatherCode"];
                            [mede_1.array addObject:mede_2];
                        }
                    }
                    [mede.array addObject:mede_1];
                }
            }
            [self.array addObject:mede];
        }
    }
    NSLog(@"%ld", self.array.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
