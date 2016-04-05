//
//  UrlClass.m
//  JsonCrudBasic
//
//  Created by Tops on 12/21/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "UrlClass.h"

@implementation UrlClass
@synthesize delegate;
-(void)ConntectWithURL:(NSString *)sturl Flag:(NSString *)stflag
{
    st_global_glag=stflag;
    NSURL *url=nil;
    NSMutableURLRequest *req=nil;
    NSURLConnection *con=nil;
    
    if ([stflag isEqual:@"insert"])
    {
        NSArray *arrurl=[sturl componentsSeparatedByString:@"?"];
        
        NSString *part_one=[[arrurl objectAtIndex:0]stringByAppendingString:@"?"];
        
        NSString *part_two=[arrurl objectAtIndex:1];
        
        url=[NSURL URLWithString:part_one];
        
        req=[NSMutableURLRequest requestWithURL:url];
        [req setHTTPBody:[part_two dataUsingEncoding:NSUTF8StringEncoding]];
        [req setHTTPMethod:@"POST"];
        
        con=[NSURLConnection connectionWithRequest:req delegate:self];

    }
    else
    {
        url=[NSURL URLWithString:sturl];
        req=[NSMutableURLRequest requestWithURL:url];
        con=[NSURLConnection connectionWithRequest:req delegate:self];
    }
    if (con)
    {
        datamute=[[NSMutableData alloc]init];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    datamute.length=0;
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [datamute appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alrt show];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([delegate respondsToSelector:@selector(GetUrlData:Flag:)])
    {
        if ([st_global_glag isEqual:@"insert"])
        {
            NSString *strr=[[NSString alloc]initWithData:datamute encoding:NSUTF8StringEncoding];
            NSLog(@"%@",strr);
        }
        else
        {
        NSArray *arrjson=[NSJSONSerialization JSONObjectWithData:datamute options:kNilOptions error:nil];
        [delegate GetUrlData:arrjson Flag:st_global_glag];
        }
    }
}
@end
