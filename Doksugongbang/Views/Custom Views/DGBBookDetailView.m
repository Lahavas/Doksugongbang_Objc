//
//  DGBBookDetailView.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 9..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookDetailView.h"
#import "DGBBook.h"
#import "NSString+DGBHTMLEncoder.h"

@interface DGBBookDetailView ()

#pragma mark - Private Properties

@property (strong, nonatomic) NSURL *amazonLinkURL;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *categoryLabel;
@property (strong, nonatomic) UILabel *pageLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIButton *purchaseButton;

@property (strong, nonatomic) UIStackView *labelStackView;

@end

#pragma mark -

@implementation DGBBookDetailView

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

#pragma mark - Deallocation

- (void)dealloc {
    [self.purchaseButton removeTarget:self
                               action:@selector(openAmazonLink:)
                     forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Set Up Methods

- (void)setUpSubviews {
    [self setUpLabelsConfigurations];
    [self setUpPurchaseButton];
    [self setUpLabelStackView];
    
    [self setUpConstraints];
}

- (void)setUpLabelsConfigurations {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _categoryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    UIColor *titleTextColor = [UIColor blackColor];
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    UIColor *subtitleColor = [UIColor lightGrayColor];
    UIFont *subtitleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    UIColor *bodyColor = [UIColor blackColor];
    UIFont *bodyFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    
    [self.titleLabel setText:@"상세 정보"];
    [self.titleLabel setTextColor:titleTextColor];
    [self.titleLabel setFont:titleFont];
    [self.titleLabel setAdjustsFontForContentSizeCategory:YES];
    [self.titleLabel setNumberOfLines:1];
    
    [self.categoryLabel setTextColor:subtitleColor];
    [self.categoryLabel setFont:subtitleFont];
    [self.categoryLabel setAdjustsFontForContentSizeCategory:YES];
    [self.categoryLabel setNumberOfLines:1];
    
    [self.pageLabel setTextColor:subtitleColor];
    [self.pageLabel setFont:subtitleFont];
    [self.pageLabel setAdjustsFontForContentSizeCategory:YES];
    [self.pageLabel setNumberOfLines:1];
    
    [self.descriptionLabel setTextColor:bodyColor];
    [self.descriptionLabel setFont:bodyFont];
    [self.descriptionLabel setAdjustsFontForContentSizeCategory:YES];
    [self.descriptionLabel setNumberOfLines:0];
}

- (void)setUpPurchaseButton {
    _purchaseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.purchaseButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentTrailing];
    
    [self addSubview:self.purchaseButton];
}

- (void)setUpLabelStackView {
    CGFloat standardSpace = 8.0;
    
    _labelStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.titleLabel,
                                                                      self.categoryLabel,
                                                                      self.pageLabel,
                                                                      self.descriptionLabel]];
    
    [self.labelStackView setAxis:UILayoutConstraintAxisVertical];
    [self.labelStackView setSpacing:standardSpace];
    [self.labelStackView setAlignment:UIStackViewAlignmentFill];
    [self.labelStackView setDistribution:UIStackViewDistributionFill];
    
    [self.labelStackView setCustomSpacing:standardSpace / 2.0
                                afterView:self.categoryLabel];
    
    [self addSubview:self.labelStackView];
}

- (void)setUpConstraints {
    UILayoutGuide *marginsGuide = self.layoutMarginsGuide;
    
    [self.labelStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.purchaseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[[self.labelStackView.topAnchor constraintEqualToAnchor:marginsGuide.topAnchor],
                                              [self.labelStackView.leadingAnchor constraintEqualToAnchor:marginsGuide.leadingAnchor],
                                              [self.labelStackView.trailingAnchor constraintEqualToAnchor:marginsGuide.trailingAnchor]]];
    
    [NSLayoutConstraint activateConstraints:@[[self.purchaseButton.topAnchor constraintEqualToSystemSpacingBelowAnchor:self.descriptionLabel.lastBaselineAnchor
                                                                                                            multiplier:1.0],
                                              [self.purchaseButton.bottomAnchor constraintEqualToAnchor:marginsGuide.bottomAnchor],
                                              [self.purchaseButton.leadingAnchor constraintEqualToAnchor:marginsGuide.leadingAnchor],
                                              [self.purchaseButton.trailingAnchor constraintEqualToAnchor:marginsGuide.trailingAnchor]]];
}

#pragma mark - Actions

- (void)openAmazonLink:(id)sender {
    if (self.amazonLinkURL) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:self.amazonLinkURL];
        [self.delegate bookDetailViewPresentSafariViewController:safariViewController];
    }
}

#pragma mark - Public Methods

- (void)setContentsWithBook:(DGBBook *)book {
    if (book) {
        NSString *title = @"상세 정보";
        NSString *category = book.category;
        NSString *page = [NSString stringWithFormat:@"%ldp", book.page];
        NSString *bookDescription = [NSString stringWithHTMLEncodedString:book.bookDescription];
        
        NSString *purchaseBookText = @"책 구매하기";
        self.amazonLinkURL = [NSURL URLWithString:book.linkURL];
        
        [self.titleLabel setText:title];
        [self.categoryLabel setText:category];
        [self.pageLabel setText:page];
        [self.descriptionLabel setText:bookDescription];
        
        [self.purchaseButton setTitle:purchaseBookText
                             forState:UIControlStateNormal];
        [self.purchaseButton addTarget:self
                                action:@selector(openAmazonLink:)
                      forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
