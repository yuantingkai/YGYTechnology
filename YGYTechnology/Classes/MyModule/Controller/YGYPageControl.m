//
//  YGYPageControl.m
//  YGYTechnology
//
//  Created by 袁庭楷 on 2018/10/17.
//  Copyright © 2018年 YGY. All rights reserved.
//

#import "YGYPageControl.h"

@implementation YGYPageControl

- (void)layoutSubviews{
    
    for (NSUInteger index = 0; index < [self.subviews count]; index++) {
        UIImageView* subview = [self.subviews objectAtIndex:index];
        subview.layer.cornerRadius = 0;
        subview.frame = CGRectMake( index * 30, 20, 18,5);
        if (index == self.currentPage) {
            [subview setBackgroundColor:self.currentPageIndicatorTintColor];
        } else {
            [subview setBackgroundColor:self.pageIndicatorTintColor];
        }
    }
}

@end
