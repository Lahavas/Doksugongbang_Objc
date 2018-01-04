//
//  DGBBookListTableViewCell.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookListTableViewCell.h"
#import "DGBBookMainView.h"

@implementation DGBBookListTableViewCell

#pragma mark - Class Methods

+ (NSString *)className {
    return NSStringFromClass([self class]);
}

#pragma mark - Cell Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.bookMainView updateBookCoverWithImage:nil];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.bookMainView updateBookCoverWithImage:nil];
}

@end
