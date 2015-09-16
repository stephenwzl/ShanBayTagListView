//
//  SBTagListView.m
//  SBTagListView
//
//  Created by 王志龙 on 15/9/16.
//  Copyright © 2015年 王志龙. All rights reserved.
//

#import "SBTagListView.h"


@interface SBTagListView()
@property (assign, nonatomic) NSUInteger linesOfTags;

@end
@implementation SBTagListView

- (instancetype)initWithWidth:(CGFloat)width contentArray:(NSMutableArray *)array {
    self = [super initWithFrame:CGRectMake(0, 0, width, 0)];
    if (self) {
        self.contentArray = array;
        self.tagsArray = [self generateTagsByStrings:self.contentArray];
        self.linesOfTags = [self generateLinesOfTags];
        self.frame = CGRectMake(0, 0, width, self.linesOfTags * 39);
    }
    return self;
}

#pragma mark view 
- (void)layoutSubviews {
    [self layoutTags];
}

- (void)reloadTags {
    NSArray *subviews = [self subviews];
    for (UIView *subvie in subviews) {
        [subvie removeFromSuperview];
    }
    [self layoutTags];
}

- (void)layoutTags {
    NSUInteger totalLines = 1;
    CGFloat currentTotalWidth = 0;
    for (NSUInteger i = 0; i < self.tagsArray.count; ++i) {
        SBTag *tag = self.tagsArray[i];
        currentTotalWidth += tag.frame.size.width + 4;
        if (currentTotalWidth >= self.frame.size.width) {
            if (currentTotalWidth == self.frame.size.width) {
                tag.frame = CGRectMake(currentTotalWidth - tag.frame.size.width, (totalLines -1) * 39, tag.frame.size.width, tag.frame.size.height);
                [self addSubview:tag];
            }
            totalLines++;
            if (currentTotalWidth > self.frame.size.width) {
                --i;
            }
            currentTotalWidth = 0;
            
        }else {
            tag.frame = CGRectMake(currentTotalWidth - tag.frame.size.width, (totalLines -1) * 39, tag.frame.size.width, tag.frame.size.height);
            [self addSubview:tag];
        }
    }
}


- (NSUInteger)generateLinesOfTags {
    NSUInteger totalLines = 1;
    CGFloat currentTotalWidth = 0;
    for (NSUInteger i = 0; i < self.tagsArray.count; ++i) {
        SBTag *tag = self.tagsArray[i];
        currentTotalWidth += tag.frame.size.width + 4;
        if (currentTotalWidth >= self.frame.size.width) {
            totalLines++;
            if (currentTotalWidth > self.frame.size.width) {
                --i;
            }
            currentTotalWidth = 0;
        }
    }
    NSLog(@"lines: %lu",(unsigned long)totalLines);
    return totalLines;
}

- (void)removeTagAtIndex:(NSUInteger)index {
    [self.tagsArray removeObject:[self desequeseTagAtIndex:index]];
    [self reloadTags];
}
#pragma mark data
- (NSMutableArray *)generateTagsByStrings:(NSMutableArray *)array {
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    NSUInteger i = 0;
    @autoreleasepool {
        for (NSString *tagString in self.contentArray) {
            SBTag *tag = [[SBTag alloc] initWithText:tagString];
            tag.index = i;
            [tag addTarget:self action:@selector(didTappedTag:) forControlEvents:UIControlEventTouchUpInside];
            if (tag.frame.size.width > self.frame.size.width) {
                NSLog(@"can not create a taglistview that the width smaller than his tags");
            }else {
                [resultArray addObject:tag];
                ++i;
            }
            
            
        }
    }
    return resultArray;
}

#pragma SEL
- (void)didTappedTag:(SBTag *)sender {
    NSLog(@"%ld",sender.index);
    if ([self.delegate respondsToSelector:@selector(didSelectTagAtIndex:)]) {
        [self.delegate didSelectTagAtIndex:sender.index];
    }
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
    self = [super initWithFrame:CGRectMake(0, 0, contentSize.width + 20, 30)];
    if (self) {
        self.text = text;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.557 green: 0.557 blue: 0.557 alpha: 1];
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: rect cornerRadius: 4];
    [color setFill];
    [rectanglePath fill];
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
    {
        NSString* textContent = self.text;
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(10, 4, self.frame.size.width - 10, self.frame.size.height) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
    

}

- (void)setNormal {
    self.layer.shadowColor = [UIColor clearColor].CGColor;
}
- (void)setError {
    self.layer.shadowColor = [UIColor redColor].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 3;
}

- (void)setSuccess {
    self.layer.shadowColor = [UIColor greenColor].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 3;
}

- (void)setTagType:(SBTagType)type {
    switch (type) {
        case SBTagTypeNormal:
            [self setNormal];
            break;
        case SBTagTypeSuccess:
            [self setSuccess];
            break;
        case SBTagTypeError:
            [self setError];
            break;
        default:
            [self setNormal];
            break;
    }
}

@end