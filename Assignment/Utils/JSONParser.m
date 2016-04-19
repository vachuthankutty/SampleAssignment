//
//  JSONParser.m
//  Assignment
//
//  Created by Admin on 19/04/16.
//  Copyright © 2016 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONParser.h"
#import "AllAbout.h"
#import "CountryDetails.h"

@implementation JSONParser

//This method will fetch and parse a JSON to the object
- (id)fetchAndParseJSON:(NSString*) URL
{
    NSError *error;
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString: URL] encoding:NSISOLatin1StringEncoding error:&error];
    NSData *resData = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (resData == NULL)
    {
        AllAbout *countryData = [[AllAbout alloc] init];
        countryData.countryDetails=[[NSMutableArray alloc] init];
        return (countryData);
    }
    NSDictionary *jsonObject = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:resData options:kNilOptions error:&error];
    NSMutableArray *rowData = [[NSMutableArray alloc]init];
    AllAbout *countryData = [[AllAbout alloc] init];
    if (error) {
        NSString *errorMessage = [error localizedDescription];
        NSLog(@"JSON error %@",errorMessage);
    } else {
        NSArray *dataRows = jsonObject[@"rows"];
        [dataRows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (!([obj[@"title"] isEqual:[NSNull null]] &&  [obj[@"description"] isEqual:[NSNull null]] && [obj[@"imageHref"] isEqual:[NSNull null]])) {
                CountryDetails *countryDetails =[[CountryDetails alloc]init];
                countryDetails.itemTitle = ([obj[@"title"] isEqual:[NSNull null]])?@"":obj[@"title"];
                countryDetails.itemDetail = ([obj[@"description"] isEqual:[NSNull null]])?NSLocalizedString(@"No Data Received", nil):obj[@"description"];
                countryDetails.imageUrl = ([obj[@"imageHref"] isEqual:[NSNull null]])?@"":obj[@"imageHref"];
                [rowData addObject:countryDetails];
            }
            
        }];
        
        countryData.countryDetails = [NSArray arrayWithArray:rowData];
        countryData.countryTitle = [jsonObject objectForKey:@"title"];
    }
    return (countryData);
}

@end