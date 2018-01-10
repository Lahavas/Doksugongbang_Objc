//
//  DGBBookTitleTableViewCell.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookTitleTableViewCell.h"

@implementation DGBBookTitleTableViewCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
         reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUpTitleLabel];
        
        [self setUpConstraints];
    }
    
    return self;
}

#pragma mark - Set Up Methods

- (void)setUpTitleLabel {
    _bookTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    UIColor *titleTextColor = [UIColor blackColor];
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    [self.bookTitleLabel setTextColor:titleTextColor];
    [self.bookTitleLabel setFont:titleFont];
    [self.bookTitleLabel setAdjustsFontForContentSizeCategory:YES];
    [self.bookTitleLabel setNumberOfLines:2];
    
    [self.contentView addSubview:self.bookTitleLabel];
}

- (void)setUpConstraints {
    [self.bookTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILayoutGuide *marginsGuide = self.contentView.layoutMarginsGuide;
    
    [NSLayoutConstraint activateConstraints:@[[self.bookTitleLabel.topAnchor constraintEqualToAnchor:marginsGuide.topAnchor],
                                              [self.bookTitleLabel.bottomAnchor constraintEqualToAnchor:marginsGuide.bottomAnchor],
                                              [self.bookTitleLabel.leadingAnchor constraintEqualToAnchor:marginsGuide.leadingAnchor],
                                              [self.bookTitleLabel.trailingAnchor constraintEqualToAnchor:marginsGuide.trailingAnchor]]];
}

@end
