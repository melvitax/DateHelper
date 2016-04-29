//
//  TableItem.m
//  AFDateHelperExtObjective-C
//
//  Created by Tassilo Lechner von Leheneck on 17/04/16.
//  Copyright © 2016 Tassilo Lechner von Leheneck. All rights reserved.
//

#import "TableItem.h"

@implementation TableItem

-(instancetype)initWithTitle: (NSString *) title theDescription: (NSString *) theDescription {
    self.title = title;
    self.theDescription = theDescription;
    
    return self;
}

@end
