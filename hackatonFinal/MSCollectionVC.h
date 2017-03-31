//
//  MSCollectionVC.h
//  hackatonFinal
//
//  Created by Максим Стегниенко on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCollectionVC : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
