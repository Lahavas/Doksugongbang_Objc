//
//  UITableViewCell+DGBCellNameGenerator.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 5..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "UITableViewCell+DGBCellNameGenerator.h"

@implementation UITableViewCell (DGBCellNameGenerator)

#pragma mark - Class Methods

+ (NSString *)className {
    return NSStringFromClass([self class]);
}

@end
