//
//  UIPlaceHolderTextView.h
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/18/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
