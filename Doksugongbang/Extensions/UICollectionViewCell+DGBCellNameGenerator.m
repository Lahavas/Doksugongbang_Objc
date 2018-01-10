//
//  UICollectionViewCell+DGBCellNameGenerator.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 10..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "UICollectionViewCell+DGBCellNameGenerator.h"

@implementation UICollectionViewCell (DGBCellNameGenerator)

#pragma mark - Class Methods

+ (NSString *)className {
    return NSStringFromClass([self class]);
}

@end
