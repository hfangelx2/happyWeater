//
//  YuJingViewController.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/18.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "YuJingViewController.h"
#import "YuJing.h"
#import "UMSocialScreenShoter.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"

@interface YuJingViewController ()<UITableViewDataSource, UITableViewDelegate, UMSocialUIDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation YuJingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *image_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blur_bg0_fine_night.jpg"]];
    [image_view setFrame:self.view.bounds];
    [self.view addSubview:image_view];
    [self creat_table];
    UILabel *tianqi = [[UILabel alloc] initWithFrame:CGRectMake(Lewidth / 2.0 - 100, 50, 200, 30)];
    tianqi.text = @"预警和警告";
    tianqi.textAlignment = NSTextAlignmentCenter;
    tianqi.textColor = [UIColor yellowColor];
    [tianqi setFont:[UIFont systemFontOfSize:23]];
    [self.view addSubview:tianqi];
    
    UIButton *guanbi = [UIButton buttonWithType:UIButtonTypeSystem];
    [guanbi setFrame:CGRectMake(Lewidth - 130, Lehigh - 65, 70, 30)];
//    [guanbi setBackgroundColor:[UIColor grayColor]];
    [guanbi setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [guanbi addTarget:self action:@selector(guanbi_tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guanbi];
    
    UILabel *guanbi_text = [[UILabel alloc] initWithFrame:CGRectMake(guanbi.frame.size.width / 2.0 - 30, 5, 60, 20)];
    [guanbi_text setText:@"关闭"];
    [guanbi_text setTextAlignment:NSTextAlignmentCenter];
    [guanbi_text setTextColor:[UIColor whiteColor]];
    [guanbi addSubview:guanbi_text];
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeSystem];
    [share setFrame:CGRectMake(50, Lehigh - 65, 70, 30)];
    //    [guanbi setBackgroundColor:[UIColor grayColor]];
    [share setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(share_tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
    
    UILabel *share_text = [[UILabel alloc] initWithFrame:CGRectMake(share.frame.size.width / 2.0 - 30, 5, 60, 20)];
    [share_text setText:@"分享"];
    [share_text setTextAlignment:NSTextAlignmentCenter];
    [share_text setTextColor:[UIColor whiteColor]];
    [share addSubview:share_text];
    
}


- (void)share_tap
{
    NSString *neirong = [[[self.array objectForKey:@"alert"] objectAtIndex:0] objectForKey:@"content"];
    
    UIImage *image_shoot = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"558393cf67e58e75ed001670"
                                      shareText:neirong
                                     shareImage:image_shoot
                                shareToSnsNames:@[UMShareToSina]
                                       delegate:self];
    
    
}

- (void)guanbi_tap
{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)creat_table
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, Lewidth, Lehigh - 170) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YuJingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[YuJingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    cell.backgroundColor = [UIColor clearColor];
    YuJing *mm = [[YuJing alloc] init];
    [mm setValuesForKeysWithDictionary:[[self.array objectForKey:@"alert"] objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = mm;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.array objectForKey:@"alert"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat ff = [[self class] hightWithText:[[[self.array objectForKey:@"alert"] objectAtIndex:indexPath.row] objectForKey:@"content"]];
    return ff + 50;
}

+ (CGFloat)hightWithText:(NSString *)temps
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil];
    CGSize size = CGSizeMake(Lewidth - 40, 2000);
    CGRect rect = [temps boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
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
