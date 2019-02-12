//
//  ShipCollectionCell.m
//  Battleship
//
//  Created by doxper on 30/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import "ShipCollectionCell.h"

@interface ShipCollectionCell() {
    
    __weak IBOutlet UIView *colorView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UIImageView *selectedImageView;
    
}
@end

@implementation ShipCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)fillCellData:(NSInteger)tag withShip:(Ship*)ship isSelected:(BOOL)isSelected {
    self.tag = tag;
    
    colorView.backgroundColor = ship.color;
    nameLabel.text = ship.name;
    [selectedImageView setHidden:!isSelected];
}

-(void)fillCellData:(NSInteger)tag withShip:(Ship*)ship {
    self.tag = tag;
    
    colorView.backgroundColor = ship.color;
    [selectedImageView setHidden:YES];
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    BOOL isShipFound = [ship found];
    if (isShipFound) {
        [attributes setObject:@2 forKey:NSStrikethroughStyleAttributeName];
    }
    NSAttributedString *attributedNameString = [[NSAttributedString alloc] initWithString:ship.name attributes:attributes];
    nameLabel.attributedText = attributedNameString;
}

@end
