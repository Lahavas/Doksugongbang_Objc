//
//  DGBBookCoverCollectionViewCell.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 10..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookCoverCollectionViewCell.h"
#import "DGBBookCoverView.h"
#import "DGBBook.h"

@interface DGBBookCoverCollectionViewCell ()

#pragma mark - Private Properties

@property (strong, nonatomic) DGBBookCoverView *bookCoverView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

#pragma mark -

@implementation DGBBookCoverCollectionViewCell

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setUpSubviews];
        
        [self setUpConstraints];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSubviews];
        
        [self setUpConstraints];
    }
    
    return self;
}

#pragma mark - Cell Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.bookCoverView resetBookCoverImage];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.bookCoverView resetBookCoverImage];
}


#pragma mark - Set Up Methods

- (void)setUpSubviews {
    [self setUpBookCoverView];
    [self setUpTitleLabel];
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
                                              [self.bookCoverView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.bookCoverView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]]];
    
    [NSLayoutConstraint activateConstraints:@[[self.titleLabel.topAnchor constraintEqualToSystemSpacingBelowAnchor:self.bookCoverView.bottomAnchor
                                                                                                              multiplier:1.0],
                                              [self.titleLabel.bottomAnchor constraintLessThanOrEqualToSystemSpacingBelowAnchor:self.bottomAnchor
                                                                                                                     multiplier:1.0],
                                              [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]]];
}

- (void)updateBookCoverWithBook:(DGBBook *)book {
    NSURL *coverURL = [NSURL URLWithString:book.coverURL];
    NSString *title = book.title;
    NSString *isbn = book.isbn;
    
    [self.bookCoverView updateImageWithURL:coverURL
                                      isbn:isbn];
    [self.titleLabel setText:title];
}

@end
