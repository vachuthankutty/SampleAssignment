//
//  CountryDetailsCell.m
//  Assignment
//
//  Created by Admin on 19/04/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountryDetailsCell.h"

@implementation CountryDetailsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Title Label
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 0;
        self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        //Detail text Label
        self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //Fix the frame of ImageView with variable height and width based on contentview
    self.imageView.frame = CGRectMake(10, 15, CGRectGetWidth(self.contentView.frame)/4, CGRectGetHeight(self.contentView.frame)/1.5);
    //Fix the textLabel using addconstraint with respect to content view
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.30
                                                                  constant:0.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:0.65
                                                                  constant:0.0]];
    
    [self.self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel
                                                                      attribute:NSLayoutAttributeCenterY
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.contentView
                                                                      attribute:NSLayoutAttributeCenterY
                                                                     multiplier:0.25
                                                                       constant:5.0]];
     //Fix the detailTextLabel using addconstraint with respect to content view
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.detailTextLabel
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.30
                                                                  constant:0.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.detailTextLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:0.65
                                                                  constant:0]];
    
    [self.self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.detailTextLabel
                                                                      attribute:NSLayoutAttributeCenterY
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.contentView
                                                                      attribute:NSLayoutAttributeCenterY
                                                                     multiplier:1.25
                                                                       constant:0.0]];
    
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    //Set default value
    self.detailTextLabel.text = @"";
    self.detailTextLabel.text = @"";
    self.imageView.image = nil;
}

@end