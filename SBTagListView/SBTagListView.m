//
//  SBTagListView.m
//  SBTagListView
//
//  Created by 王志龙 on 15/9/16.
//  Copyright © 2015年 王志龙. All rights reserved.
//

#import "SBTagListView.h"



@implementation SBTagListView

- (instancetype)initWithWidth:(CGFloat)width contentArray:(NSMutableArray *)array {
    self = [super init];
    if (self) {
        self.contentArray = array;
    }
    return self;
}

- (SBTag *)desequeseTagAtIndex:(NSUInteger)index {
    for (SBTag *tag in self.tagsArray) {
        if (tag.index == index) {
            return tag;
        }
    }
    return nil;
}
@end

@implementation SBTag

- (instancetype)initWithText:(NSString *)text {
    CGSize contentSize = [text boundingRectWithSize:CGSizeMake(FLT_MAX, 30) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self = [super initWithFrame:CGRectMake(0, 0, contentSize.width + 20, contentSize.height)];
    if (self) {
        self.text = text;
    }
    return self;
}

@end