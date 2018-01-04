//
//  DGBBookMainView.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookMainView.h"
#import "DGBBook.h"

@interface DGBBookMainView ()

@property (strong, nonatomic) UIStackView *labelStackView;

@end

#pragma mark -

@implementation DGBBookMainView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSubviews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setUpSubviews];
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)setContentsWithBook:(DGBBook *)book {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy년 MM월 dd일"];
    }
    
    if (book) {
        NSString *title = [NSString stringWithFormat:@"%@", book.title];
        NSString *author = [NSString stringWithFormat:@"%@ 지음", book.author];
        NSString *publisher = [NSString stringWithFormat:@"%@ 펴냄", book.publisher];
        NSString *pubDate = [NSString stringWithFormat:@"%@ 출판", [dateFormatter stringFromDate:book.pubDate]];
        
        [self.titleLabel setText:title];
        [self.authorLabel setText:author];
        [self.publisherLabel setText:publisher];
        [self.pubDateLabel setText:pubDate];
    }
}

#pragma mark - Private Methods

- (void)setUpSubviews {
    CGFloat standardSpace = 8.0;
    
    _coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _publisherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _pubDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [self setUpLabelConfigurations];
    
    _labelStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_titleLabel,
                                                                      _authorLabel,
                                                                      _publisherLabel,
                                                                      _pubDateLabel]];
    [self.labelStackView setAxis:UILayoutConstraintAxisVertical];
    [self.labelStackView setSpacing:standardSpace];
    [self.labelStackView setAlignment:UIStackViewAlignmentFill];
    [self.labelStackView setDistribution:UIStackViewDistributionFill];
    
    [self addSubview:self.coverImageView];
    [self addSubview:self.labelStackView];
    
    [self setUpConstraints];
}

- (void)setUpLabelConfigurations {
    UIColor *titleTextColor = UIColor.blackColor;
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle3];
    
    UIColor *subtitleTextColor = UIColor.darkGrayColor;
    UIFont *subtitleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    [self.titleLabel setTextColor:titleTextColor];
    [self.titleLabel setFont:titleFont];
    [self.titleLabel setAdjustsFontForContentSizeCategory:YES];
    [self.titleLabel setNumberOfLines:2];
    
    [self.authorLabel setTextColor:subtitleTextColor];
    [self.authorLabel setFont:subtitleFont];
    [self.authorLabel setAdjustsFontForContentSizeCategory:YES];
    [self.authorLabel setNumberOfLines:1];
    
    [self.publisherLabel setTextColor:subtitleTextColor];
    [self.publisherLabel setFont:subtitleFont];
    [self.publisherLabel setAdjustsFontForContentSizeCategory:YES];
    [self.publisherLabel setNumberOfLines:1];
    
    [self.pubDateLabel setTextColor:subtitleTextColor];
    [self.pubDateLabel setFont:subtitleFont];
    [self.pubDateLabel setAdjustsFontForContentSizeCategory:YES];
    [self.pubDateLabel setNumberOfLines:1];
}

- (void)setUpConstraints {
    CGFloat standardMargin = 8.0;
    
    UILayoutGuide *marginsGuide = self.layoutMarginsGuide;
    
    [self.coverImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *coverImageViewTopConstraint = [self.coverImageView.topAnchor constraintEqualToAnchor:marginsGuide.topAnchor];
    NSLayoutConstraint *coverImageViewBottomConstraint = [self.coverImageView.bottomAnchor constraintEqualToAnchor:marginsGuide.bottomAnchor];
    NSLayoutConstraint *coverImageViewLeadingConstraint = [self.coverImageView.leadingAnchor constraintEqualToAnchor:marginsGuide.leadingAnchor];
    NSLayoutConstraint *coverImageViewTrailingConstraint = [self.coverImageView.trailingAnchor constraintEqualToAnchor:self.labelStackView.leadingAnchor
                                                                                                              constant:standardMargin];
    
    NSLayoutConstraint *labelStackViewTopConstraint = [self.labelStackView.topAnchor constraintEqualToAnchor:marginsGuide.topAnchor];
    NSLayoutConstraint *labelStackViewBottomConstraint = [self.labelStackView.bottomAnchor constraintEqualToAnchor:marginsGuide.bottomAnchor];
    NSLayoutConstraint *labelStackViewTrailingConstraint = [self.labelStackView.trailingAnchor constraintLessThanOrEqualToAnchor:marginsGuide.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[coverImageViewTopConstraint,
                                              coverImageViewBottomConstraint,
                                              coverImageViewLeadingConstraint,
                                              coverImageViewTrailingConstraint]];
    [NSLayoutConstraint activateConstraints:@[labelStackViewTopConstraint,
                                              labelStackViewBottomConstraint,
                                              labelStackViewTrailingConstraint]];
}

@end
