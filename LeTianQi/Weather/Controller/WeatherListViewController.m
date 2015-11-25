//
//  WeatherListViewController.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/10.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "WeatherListViewController.h"

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>

#import "Entity.h"
#import "OtherViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "RootViewController.h"

@interface WeatherListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CoreDataManager *coreDataManager;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSMutableArray *del_arr;
@property (nonatomic, assign) NSInteger city_num;
@property (nonatomic, assign) NSInteger chose_city;
@end

@implementation WeatherListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buxinga) name:@"buxing" object:nil];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.del_arr = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Lewidth - 60, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [add setFrame:CGRectMake(Lewidth - 100, 5, 30, 30)];
//    [add setBackgroundColor:[UIColor grayColor]];
    [add addTarget:self action:@selector(add_tao) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:add];
    
    self.array_data = [NSMutableArray array];
    self.coreDataManager = [CoreDataManager shareCoreDataManager];
    
    self.city_num = 0;
    
}

- (void)buxinga
{
    NSLog(@"///");
}

- (void)getData_xcb
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
}

- (void)add_tao
{
    NSLog(@"tao");
    OtherViewController *other = [[OtherViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:other];
    other.array_data = [NSMutableArray array];
    other.array_data = self.array_data;
    other.num = self.array_data.count;
    [other setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navi animated:YES completion:^{
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.city_num = indexPath.row;
    self.chose_city = 5;
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

//重写编辑方法
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    //调用父类的编辑方法
    [super setEditing:editing animated:animated];
    
    //利用系统的编辑按钮控制tableView编辑状态
    [_tableView setEditing:editing animated:animated];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        return NO;
//    }
//    else
        return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"()()()()%ld", indexPath.row);
        [self.array_data removeObjectAtIndex:indexPath.row];
        NSInteger num_arr = indexPath.row;
        NSString *num_nss = [NSString stringWithFormat:@"%ld", num_arr];
        [self.del_arr addObject:num_nss];
        [self.coreDataManager saveContext];
        NSArray *del = @[indexPath];
        [self.tableView deleteRowsAtIndexPaths:del withRowAnimation:UITableViewRowAnimationRight];
        
        if (self.array_data.count == 0) {
            OtherViewController *other = [[OtherViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:other];
            [navi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            other.ppp = 10;
            [tableView setEditing:NO animated:YES];
            [self presentViewController:navi animated:YES completion:^{
                //
            }];
        }
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.array_data[indexPath.row] city];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    self.number = self.array_data.count;
    return self.array_data.count;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Left will appear");
    self.number = self.array_data.count;
    self.tabBarController.tabBar.hidden = YES;
//    self.tabBarController.tabBar.alpha = 0.5;
    self.number = self.array_data.count;
    [self getData_xcb];
    [self.tableView reloadData];
    self.del_arr = [NSMutableArray array];
    
    NSDictionary *dict_1 =[[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"textOne", nil];
    //创建通知
    NSNotification *notification_1 =[NSNotification notificationWithName:@"tongzhi_1" object:nil userInfo:dict_1];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification_1];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"Left did appear");
    self.chose_city = 1;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"Left will disappear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"Left did disappear");
    self.tabBarController.tabBar.hidden = YES;
    NSString *xu_1 = [NSString stringWithFormat:@"%ld", self.chose_city];
    NSString *xu_2 = [NSString stringWithFormat:@"%ld", self.city_num];
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.del_arr,@"textOne",xu_1,@"textTwo",xu_2,@"textThree", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
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
