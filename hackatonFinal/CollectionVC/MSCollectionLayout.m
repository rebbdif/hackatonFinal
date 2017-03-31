//
//  MSCollectionLayout.m
//  hackatonFinal
//
//  Created by Максим Стегниенко on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "MSCollectionLayout.h"



@interface MSCollectionLayout()
{
    NSMutableArray *layoutArr;
    CGSize  currentContentSize;
}

@end


@implementation MSCollectionLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    layoutArr = [self generateLayout];
    
    
}

- ( NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    return layoutArr;
    
}

- (CGSize)collectionViewContentSize {
    
    return currentContentSize;
}

-(NSMutableArray *) generateLayout {
    
    
    NSMutableArray *arr  = [NSMutableArray new];
    NSInteger sectionCount = 1;
    if ([self.collectionView.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)] ) {
        sectionCount = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
        
    }

    float xOffset = 15;
    float yOffset = 15;
    float screenWidht = [UIScreen mainScreen].bounds.size.width;

    for (NSInteger section = 0 ; section < sectionCount ; section++) {
        NSInteger itemCount = [ self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0 ;item < itemCount; item++) {
            NSIndexPath *idxPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            if (section==0 ) {
                UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:idxPath];
                
                attr.frame = CGRectMake(xOffset, yOffset, screenWidht-2*xOffset,  (screenWidht-2*xOffset )*0.6);
                [arr addObject:attr];
                yOffset = yOffset + ((screenWidht-2*xOffset )*0.6 )+15;
                
            }
            
    
            
        }
        
    }
    
    
    
    
    currentContentSize = CGSizeMake(xOffset, yOffset);
    
    return arr;
    
}

@end
