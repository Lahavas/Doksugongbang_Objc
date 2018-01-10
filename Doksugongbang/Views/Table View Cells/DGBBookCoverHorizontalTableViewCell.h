//
//  DGBBookCoverHorizontalTableViewCell.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 10..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AladinAPI.h"

typedef NS_ENUM(NSUInteger, DGBBookCoverCollectionType) {
    DGBBookCoverCollectionItemNew = 0,
    DGBBookCoverCollectionBestseller = 1,
    DGBBookCoverCollectionReadingBook = 2,
    DGBBookCoverCollectionReadBook = 3,
    DGBBookCoverCollectionFavoriteBook = 4
};

@interface DGBBookCoverHorizontalTableViewCell : UITableViewCell

#pragma mark - Public Methods

- (void)setUpBookCoverCollectionType:(NSString *)bookCoverCollectionType;

@end
