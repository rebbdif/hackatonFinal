//
//  MSCollectionVC.m
//  hackatonFinal
//
//  Created by Максим Стегниенко on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "MSCollectionVC.h"
#import "MSCollectionLayout.h"


@interface MSCollectionVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation MSCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    MSCollectionLayout *layout = [MSCollectionLayout new];
    layout.cellSize = CGSizeMake(5, 5);
    self.collectionView.collectionViewLayout = layout;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    
    return cell;
    
}








@end
