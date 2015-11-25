//
//  OtherViewController.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/15.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "OtherViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "Entity.h"
#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "RootViewController.h"
#import "TFHpple.h"
#import "XMLModel.h"
#import "XMLModel_city.h"
#import "XMLModel_county.h"
#import "PanDuanCollectionViewCell.h"
#import "PanDuanModel.h"

@interface OtherViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) CoreDataManager *coreDataManager;
@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger xx;
@property (nonatomic, assign) NSInteger yy;
@property (nonatomic, assign) NSInteger zz;
@property (nonatomic, assign) NSInteger xx_1;
@property (nonatomic, assign) NSInteger yy_1;
@property (nonatomic, strong) UIButton *done;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *weather_id;
@property (nonatomic, strong) UICollectionView *collection;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.coreDataManager = [CoreDataManager shareCoreDataManager];
    UILabel *yijing = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 150, 20)];
    yijing.text = @"已经添加的城市:";
    [self.view addSubview:yijing];
    if (self.ppp != 10) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(quxiao)];
    }
    
    if (self.array.count != 0) {
        [self.view addSubview:self.pickView];
        self.done = [UIButton buttonWithType:UIButtonTypeSystem];
        self.done.titleLabel.text = @"确定";
        [self.done setBackgroundColor:[UIColor yellowColor]];
        [self.done setFrame:CGRectMake(20, self.pickView.frame.origin.y + 200, Lewidth - 40, 50)];
        [self.view addSubview:self.done];
    }
    else
    {
        self.array = [NSMutableArray array];
        [self getXML];
    }
    
    [self creat_collet];
    
}

- (void)creat_collet
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(90, 20);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 115, Lewidth - 40, self.pickView.frame.origin.y - 115) collectionViewLayout:flow];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.collection];
    [self.collection registerClass:[PanDuanCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PanDuanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    PanDuanModel *mmm = [[PanDuanModel alloc] init];
    mmm.city = [self.array_data[indexPath.row] city];
    cell.panduan = mmm;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array_data.count;
}

- (void)quxiao
{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (UIPickerView *)pickView
{
    if (!_pickView) {
        self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(20, Lehigh - 270, Lewidth - 40, 200)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
//        [_pickView setBackgroundColor:[UIColor yellowColor]];
    }
    return _pickView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UIView *myView = [[UIView alloc] init];
//    myView.backgroundColor = [UIColor redColor];
//    return myView;
//}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.array.count;
    }
    else if (component == 1)  {
        return [[[self.array objectAtIndex:self.xx_1] array] count];
    }
    else
        return [[[[[self.array objectAtIndex:self.xx_1] array] objectAtIndex:self.yy_1] array] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.array[row] name];
    }
    else if (component == 1)
    {
        return [[[self.array[self.xx_1] array] objectAtIndex:row] name];
    }
    else
    {
        return [[[[[self.array[self.xx_1] array] objectAtIndex:self.yy_1] array] objectAtIndex:row] name];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.xx = row;
    self.zz = component;
    NSInteger qq = 0;
    if (self.zz == 0) {
        self.xx_1 = self.xx;
        self.yy_1 = 0;
        [self.pickView reloadAllComponents];
        [self.pickView selectRow:0 inComponent:1 animated:YES];
        [self.pickView selectRow:0 inComponent:2 animated:YES];
    }
    if (self.zz == 1) {
        self.yy_1 = self.xx;
        [self.pickView reloadAllComponents];
        [self.pickView selectRow:0 inComponent:2 animated:YES];
    }
    if (self.zz == 2) {
        qq = self.xx;
    }
//    NSLog(@"%ld %ld %ld", self.xx_1, self.yy_1, qq);
    NSLog(@"%@ %@", [[[[[self.array[self.xx_1] array] objectAtIndex:self.yy_1] array] objectAtIndex:qq] name], [[[[[self.array[self.xx_1] array] objectAtIndex:self.yy_1] array] objectAtIndex:qq] weatherCode]);
    self.city = [[[[[self.array[self.xx_1] array] objectAtIndex:self.yy_1] array] objectAtIndex:qq] name];
    self.weather_id = [[[[[self.array[self.xx_1] array] objectAtIndex:self.yy_1] array] objectAtIndex:qq] weatherCode];
}

- (void)bj_tap
{
//    self.array_data = [NSMutableArray array];
    Entity *time = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    time.city = self.city;
    time.cityId = self.weather_id;
    if (self.city == 0 && self.weather_id == 0) {
        time.city = @"北京";
        time.cityId = @"101010100";
    }
    [self.array_data insertObject:time atIndex:self.num];
    [self.coreDataManager saveContext];
    [self.delegate get:self.ppp];
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
    
}

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
    [self.view addSubview:self.pickView];
    self.done = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.done setTitle:@"确定" forState:UIControlStateNormal];
    [self.done addTarget:self action:@selector(done_tap) forControlEvents:UIControlEventTouchUpInside];
    [self.done.layer setCornerRadius:10];
    [self.done.layer setBorderWidth:1];
    [self.done.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.done setFrame:CGRectMake(20, self.pickView.frame.origin.y + 200, Lewidth - 40, 50)];
    [self.view addSubview:self.done];
}

- (void)done_tap
{
    [self bj_tap];
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
