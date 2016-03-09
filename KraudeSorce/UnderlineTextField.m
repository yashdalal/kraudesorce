//
//  UnderlineTextField.m
//  KraudeSorce
//
//  Created by Yash Dalal on 3/8/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//

#import "UnderlineTextField.h"

@implementation UnderlineTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, rect.size.height - borderWidth, rect.size.width, rect.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}


@end
