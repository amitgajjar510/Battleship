//
//  BoardCollectionCell.h
//  Battleship
//
//  Created by doxper on 26/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Block.h"

@interface BoardCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *hitMissImageView;

-(void)fillCellData:(NSInteger)tag withBlock:(Block *)block isGameOn:(BOOL)isGameOn;
-(void)updateHitMissImageViewForBlock:(Block*)block;

@end
