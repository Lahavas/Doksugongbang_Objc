//
//  DGBBookCoverCollectionViewCell.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 10..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBookCoverView;

@interface DGBBookCoverCollectionViewCell : UICollectionViewCell

#pragma mark - Public IBOutlet

@property (strong, nonatomic) DGBBookCoverView *bookCoverView;
@property (strong, nonatomic) UILabel *titleLabel;

@end
