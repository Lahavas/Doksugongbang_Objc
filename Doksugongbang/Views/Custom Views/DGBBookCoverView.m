//
//  DGBBookCoverView.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookCoverView.h"

@interface DGBBookCoverView ()

#pragma mark - Private Properties

@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIImageView *bookCoverImageView;

@end

#pragma mark -

@implementation DGBBookCoverView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSubviews];
    }
    
    return self;
}

#pragma mark - Accessor Methods

- (void)setBookCoverImage:(UIImage *)bookCoverImage {
    if (bookCoverImage == nil) {
        [self.spinner startAnimating];
    } else {
        [self.spinner stopAnimating];
    }
    
    _bookCoverImage = bookCoverImage;
    [self.bookCoverImageView setImage:bookCoverImage];
}

#pragma mark - Auto Layout Methods

- (CGSize)intrinsicContentSize {
    CGFloat intrinsicCoverViewWidth = 100.0;
    CGFloat intrinsicCoverViewHeight = 140.0;
    CGSize intrinsicCoverViewSize = CGSizeMake(intrinsicCoverViewWidth,
                                               intrinsicCoverViewHeight);
    
    return intrinsicCoverViewSize;
}

#pragma mark - Private Methods

- (void)setUpSubviews {
    _bookCoverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.bookCoverImageView setContentMode:UIViewContentModeScaleToFill];
    [self.spinner setHidesWhenStopped:YES];
    
    [self setUpBookCoverImageShadow];
    
    [self addSubview:self.bookCoverImageView];
    [self addSubview:self.spinner];
    
    [self setUpConstraints];
}

- (void)setUpBookCoverImageShadow {
    CALayer *bookCoverImageViewLayer = self.bookCoverImageView.layer;
    
    CGColorRef shadowColor = [UIColor grayColor].CGColor;
    CGFloat shadowOffsetWidth = 5.0;
    CGFloat shadowOffsetHeight = 5.0;
    CGSize shadowOffsetSize = CGSizeMake(shadowOffsetWidth,
                                         shadowOffsetHeight);
    
    [bookCoverImageViewLayer setShadowColor:shadowColor];
    [bookCoverImageViewLayer setShadowOffset:shadowOffsetSize];
    [bookCoverImageViewLayer setShadowOpacity:1.0];
    [bookCoverImageViewLayer setShadowRadius:1.0];
}

- (void)setUpConstraints {
    CGFloat standardMargin = 5.0;
    
    [self.bookCoverImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.spinner setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *bookCoverImageViewTopConstraint = [self.bookCoverImageView.topAnchor constraintEqualToAnchor:self.topAnchor];
    NSLayoutConstraint *bookCoverImageViewBottomConstraint = [self.bottomAnchor constraintEqualToAnchor:self.bookCoverImageView.bottomAnchor
                                                                                               constant:standardMargin];
    NSLayoutConstraint *bookCoverImageViewLeadingConstraint = [self.bookCoverImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    NSLayoutConstraint *bookCoverImageViewTrailingConstraint = [self.trailingAnchor constraintEqualToAnchor:self.bookCoverImageView.trailingAnchor
                                                                                                   constant:standardMargin];
    
    NSLayoutConstraint *spinnerCenterXConstraint = [self.spinner.centerXAnchor constraintEqualToAnchor:self.centerXAnchor];
    NSLayoutConstraint *spinnerCenterYConstraint = [self.spinner.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
    
    [NSLayoutConstraint activateConstraints:@[bookCoverImageViewTopConstraint,
                                              bookCoverImageViewBottomConstraint,
                                              bookCoverImageViewLeadingConstraint,
                                              bookCoverImageViewTrailingConstraint]];
    [NSLayoutConstraint activateConstraints:@[spinnerCenterXConstraint,
                                              spinnerCenterYConstraint]];
}

@end
