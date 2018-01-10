//
//  DGBBookCoverCollectionViewCell.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 10..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBook;

@interface DGBBookCoverCollectionViewCell : UICollectionViewCell

#pragma mark - Public Methods

- (void)updateBookCoverWithBook:(DGBBook *)book;

@end
