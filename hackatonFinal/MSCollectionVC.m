//
//  MSCollectionVC.m
//  hackatonFinal
//
//  Created by Максим Стегниенко on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "MSCollectionVC.h"
#import "MSCollectionLayout.h"
#import "MSCollectionViewCell.h"
#import "WeAddImagesViewController.h"

@interface MSCollectionVC () <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate>




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
    
    return  2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    else {
    return 100;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    MSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    if (indexPath.section ==0 ) {
        
        
        UIColor *colour = [UIColor colorWithRed:0.f/256 green:204.f/256 blue:102.f/256 alpha:1.f];
        
        cell.label.text = @"Add";
        cell.img.backgroundColor = colour;
        cell.label.textColor = [UIColor whiteColor];
        return cell;
    }
    
    else {
        cell.label.text = @"Instagram";
        cell.img.backgroundColor = [UIColor whiteColor];
        cell.label.textColor = [UIColor darkGrayColor];
        
        return cell;
    }
    
    
    
    
    
}




#pragma mark - UICollectionViewDelegate


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    
    if (indexPath.section == 0 )
    {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"WeAddImagesStoryboard" bundle:nil];
           WeAddImagesViewController* vc = [sb instantiateViewControllerWithIdentifier:@"WeAddImages"];
        vc.cVc=self;
        [self presentViewController:vc animated:YES completion:nil];
    }
 

}


#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    
    [ searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [ searchBar setShowsCancelButton:NO animated:YES];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    NSLog(@"text is editing");
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [ searchBar setShowsCancelButton:NO animated:YES];
    
    
}








@end
