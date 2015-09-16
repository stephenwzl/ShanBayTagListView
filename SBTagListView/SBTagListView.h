//
//  SBTagListView.h
//  SBTagListView
//
//  Created by 王志龙 on 15/9/16.
//  Copyright © 2015年 王志龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    SBTagTypeNormal = 0,
    SBTagTypeError,
    SBTagTypeSuccess,
}SBTagType;

@protocol SBTagListViewDelegate <NSObject>

@optional
- (void)didSelectTagAtIndex:(NSUInteger)index;

@end



@interface SBTag : UIButton

@property (copy, nonatomic) NSString *text;
@property (assign, nonatomic) NSUInteger index;

- (instancetype)initWithText:(NSString *)text;
- (void)setTagType:(SBTagType)type;
@end



@interface SBTagListView : UIView

@property (strong, nonatomic) NSMutableArray *contentArray;
@property (strong, nonatomic) NSMutableArray *tagsArray;
@property (assign, nonatomic) id<SBTagListViewDelegate> delegate;

- (instancetype)initWithWidth:(CGFloat)width contentArray:(NSMutableArray *)array;

- (SBTag *)desequeseTagAtIndex:(NSUInteger)index;

@end
