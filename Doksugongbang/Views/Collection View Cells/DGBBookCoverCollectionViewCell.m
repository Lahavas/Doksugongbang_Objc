//
//  DGBBookCoverCollectionViewCell.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 10..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookCoverCollectionViewCell.h"
#import "DGBBookCoverView.h"

@implementation DGBBookCoverCollectionViewCell

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setUpSubviews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSubviews];
    }
    
    return self;
}

#pragma mark - Set Up Methods

- (void)setUpSubviews {
    [self setUpBookCoverView];
    [self setUpTitleLabel];
    
    [self setUpConstraints];
}

- (void)setUpBookCoverView {
    _bookCoverView = [[DGBBookCoverView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:self.bookCoverView];
}

- (void)setUpTitleLabel {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    UIColor *titleTextColor = [UIColor blackColor];
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    
    [self.titleLabel setTextColor:titleTextColor];
    [self.titleLabel setFont:titleFont];
    [self.titleLabel setAdjustsFontForContentSizeCategory:YES];
    [self.titleLabel setNumberOfLines:2];
    
    [self addSubview:self.titleLabel];
}

- (void)setUpConstraints {
    [self.bookCoverView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[[self.bookCoverView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.bookCoverView.bottomAnchor constraintEqualToSystemSpacingBelowAnchor:self.titleLabel.topAnchor
                                                                                                              multiplier:1.0],
                                              [self.bookCoverView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.bookCoverView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]]];
    
    [NSLayoutConstraint activateConstraints:@[[self.titleLabel.bottomAnchor constraintLessThanOrEqualToSystemSpacingBelowAnchor:self.bottomAnchor
                                                                                                                     multiplier:1.0],
                                              [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]]];
}

@end
