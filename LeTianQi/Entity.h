//
//  Entity.h
//  LeTianQi
//
//  Created by POP-mac on 15/6/15.
//  Copyright (c) 2015年 LTXZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * cityId;

@end
