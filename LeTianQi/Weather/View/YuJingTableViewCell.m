//
//  YuJingTableViewCell.m
//  LeTianQi
//
//  Created by POP-mac on 15/6/18.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import "YuJingTableViewCell.h"



@interface YuJingTableViewCell ()
@property (nonatomic, strong) UILabel *head;
@property (nonatomic, strong) UILabel *neirong;
@end

@implementation YuJingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        self.head = [[UILabel alloc] init];
        self.head.text = @"黄色预警";
        self.head.textColor = [UIColor whiteColor];
        [self.head setFont:[UIFont systemFontOfSize:20]];
//        [self.head setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:self.head];
        
        self.neirong = [[UILabel alloc] init];
        self.neirong.textColor = [UIColor whiteColor];
        [self.neirong setFont:[UIFont systemFontOfSize:15]];
        self.neirong.numberOfLines = 0;
        [self.contentView addSubview:self.neirong];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.head setFrame:CGRectMake(20, 10, 200, 30)];
    CGFloat f = [[self class] highWithText:self.model.content];
    [self.neirong setFrame:CGRectMake(20, 40, Lewidth - 40, f)];
}

- (void)setModel:(YuJing *)model
{
    _model = model;
    self.head.text = [NSString stringWithFormat:@"%@%@预警", model.alarmTp1, model.alarmTp2];
    self.neirong.text = model.content;
}

+ (CGFloat)highWithText:(NSString *)text
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil];
    CGSize size = CGSizeMake(Lewidth - 40, 2000);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
