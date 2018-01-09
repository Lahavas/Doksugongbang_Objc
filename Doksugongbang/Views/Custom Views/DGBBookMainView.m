//
//  DGBBookMainView.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookMainView.h"
#import "DGBBook.h"
#import "DGBBookCoverView.h"

@interface DGBBookMainView ()

#pragma mark - Private Properties

@property (strong, nonatomic) DGBBookCoverView *bookCoverView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *publisherLabel;
@property (strong, nonatomic) UILabel *pubDateLabel;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *bookButton;

@property (strong, nonatomic) UIStackView *labelStackView;
@property (strong, nonatomic) UIStackView *buttonStackView;

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

#pragma mark - Intrinsic Content Size

- (CGSize)intrinsicContentSize {
    CGFloat topLayoutMargins = self.layoutMargins.top;
    CGFloat bottomLayoutMargins = self.layoutMargins.bottom;
    CGFloat bookCoverViewHeight = self.bookCoverView.intrinsicContentSize.height;
    
    CGFloat intrinsicMainViewWidth = UIViewNoIntrinsicMetric;
    CGFloat intrinsicMainViewHeight = topLayoutMargins + bottomLayoutMargins + bookCoverViewHeight;
    
    CGSize intrinsicMainViewSize = CGSizeMake(intrinsicMainViewWidth,
                                              intrinsicMainViewHeight);
    
    return intrinsicMainViewSize;
}

#pragma mark - Set Up Methods

- (void)setUpSubviews {
    [self setUpBookCoverView];
    [self setUpLabelsConfigurations];
    [self setUpButtonsConfigurations];
    [self setUpLabelStackViewConfigurations];
    [self setUpButtonStackViewConfigurations];
    
    [self setUpConstraints];
}

- (void)setUpBookCoverView {
    _bookCoverView = [[DGBBookCoverView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:self.bookCoverView];
}

- (void)setUpLabelsConfigurations {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _publisherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _pubDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
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

- (void)setUpButtonsConfigurations {
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *emptyLikeImage = [UIImage imageNamed:@"EmptyLike"];
    UIImage *selectedLikeImage = [UIImage imageNamed:@"SelectedLike"];
    
    UIImage *emptyBookImage = [UIImage imageNamed:@"EmptyBook"];
    UIImage *selectedBookImage = [UIImage imageNamed:@"SelectedBook"];
    
    [self.likeButton setImage:emptyLikeImage
                     forState:UIControlStateNormal];
    [self.likeButton setImage:selectedLikeImage
                     forState:UIControlStateSelected];
    
    [self.bookButton setImage:emptyBookImage
                     forState:UIControlStateNormal];
    [self.bookButton setImage:selectedBookImage
                     forState:UIControlStateSelected];
}

- (void)setUpLabelStackViewConfigurations {
    CGFloat standardSpace = 4.0;
    
    _labelStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.titleLabel,
                                                                      self.authorLabel,
                                                                      self.publisherLabel,
                                                                      self.pubDateLabel]];
    
    [self.labelStackView setAxis:UILayoutConstraintAxisVertical];
    [self.labelStackView setSpacing:standardSpace];
    [self.labelStackView setAlignment:UIStackViewAlignmentFill];
    [self.labelStackView setDistribution:UIStackViewDistributionFill];
    
    [self.labelStackView setCustomSpacing:standardSpace * 2.0
                                afterView:self.titleLabel];
    
    [self addSubview:self.labelStackView];
}

- (void)setUpButtonStackViewConfigurations {
    CGFloat standardSpace = 8.0;
    
    _buttonStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.likeButton,
                                                                       self.bookButton]];
    
    [self.buttonStackView setAxis:UILayoutConstraintAxisHorizontal];
    [self.buttonStackView setSpacing:standardSpace];
    [self.buttonStackView setAlignment:UIStackViewAlignmentFill];
    [self.buttonStackView setDistribution:UIStackViewDistributionFillEqually];
    
    [self addSubview:self.buttonStackView];
}

- (void)setUpConstraints {
    CGFloat standardMargin = 8.0;
    
    UILayoutGuide *marginsGuide = self.layoutMarginsGuide;
    
    [self.bookCoverView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.buttonStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.bookCoverView setContentCompressionResistancePriority:999.0
                                                        forAxis:UILayoutConstraintAxisHorizontal];
    [self.bookCoverView setContentCompressionResistancePriority:999.0
                                                        forAxis:UILayoutConstraintAxisVertical];
    [self.bookCoverView setContentHuggingPriority:999.0
                                          forAxis:UILayoutConstraintAxisHorizontal];
    [self.bookCoverView setContentHuggingPriority:999.0
                                          forAxis:UILayoutConstraintAxisVertical];
    
    [self.titleLabel setContentCompressionResistancePriority:749.0
                                                     forAxis:UILayoutConstraintAxisVertical];
    [self.titleLabel setContentHuggingPriority:252.0
                                       forAxis:UILayoutConstraintAxisVertical];
    
    NSLayoutConstraint *bookCoverViewTopConstraint = [self.bookCoverView.topAnchor constraintEqualToAnchor:marginsGuide.topAnchor];
    NSLayoutConstraint *bookCoverViewBottomConstraint = [self.bookCoverView.bottomAnchor constraintEqualToAnchor:marginsGuide.bottomAnchor];
    NSLayoutConstraint *bookCoverViewLeadingConstraint = [self.bookCoverView.leadingAnchor constraintEqualToAnchor:marginsGuide.leadingAnchor];
    
    NSLayoutConstraint *labelStackViewTopConstraint = [self.labelStackView.topAnchor constraintEqualToAnchor:marginsGuide.topAnchor];
    NSLayoutConstraint *labelStackViewLeadingConstraint = [self.labelStackView.leadingAnchor constraintEqualToAnchor:self.bookCoverView.trailingAnchor
                                                                                                            constant:standardMargin];
    NSLayoutConstraint *labelStackViewTrailingConstraint = [self.labelStackView.trailingAnchor constraintEqualToAnchor:marginsGuide.trailingAnchor];
    
    NSLayoutConstraint *buttonStackViewTopConstraint = [self.buttonStackView.topAnchor constraintGreaterThanOrEqualToAnchor:self.labelStackView.bottomAnchor
                                                                                                                   constant:standardMargin];
    NSLayoutConstraint *buttonStackViewTrailingConstraint = [self.buttonStackView.trailingAnchor constraintEqualToAnchor:marginsGuide.trailingAnchor];
    NSLayoutConstraint *buttonStackViewBottomConstraint = [self.buttonStackView.bottomAnchor constraintEqualToAnchor:marginsGuide.bottomAnchor];
    
    [NSLayoutConstraint activateConstraints:@[bookCoverViewTopConstraint,
                                              bookCoverViewBottomConstraint,
                                              bookCoverViewLeadingConstraint]];
    [NSLayoutConstraint activateConstraints:@[labelStackViewTopConstraint,
                                              labelStackViewLeadingConstraint,
                                              labelStackViewTrailingConstraint]];
    [NSLayoutConstraint activateConstraints:@[buttonStackViewTopConstraint,
                                              buttonStackViewTrailingConstraint,
                                              buttonStackViewBottomConstraint]];
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
        NSString *isbn = book.isbn;
        NSURL *coverURL = [NSURL URLWithString:book.coverURL];
        
        [self.titleLabel setText:title];
        [self.authorLabel setText:author];
        [self.publisherLabel setText:publisher];
        [self.pubDateLabel setText:pubDate];
        [self.bookCoverView updateImageWithURL:coverURL
                                          isbn:isbn];
    }
}

@end
