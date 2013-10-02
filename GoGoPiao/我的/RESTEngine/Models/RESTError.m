//
//  RESTError.m
//  iHotelApp
//
//  Created by Mugunth Kumar on 1-Jan-11.
//  Copyright 2010 Steinlogic. All rights reserved.
//

#import "RESTError.h"

static NSDictionary *errorCodes;

@implementation RESTError

+ (void) initialize
{
	//NSString *fileName = [NSString stringWithFormat:@"Errors_%@", [[NSLocale currentLocale] localeIdentifier]];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ErrorsList" ofType:@"plist"];
    errorCodes = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
}

+ (void) dealloc
{
	[super dealloc];
}


-(id) init
{
    if ((self = [super init])) {
		
		return self;
	}
    
    return self;
}


//=========================================================== 
//  Keyed Archiving
//
//=========================================================== 
- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.errorMessage forKey:@"error"];
    [encoder encodeObject:self.errorCode forKey:@"error_code"];
    [encoder encodeObject:self.errorDescription forKey:@"error_description"];
    [encoder encodeObject:self.errorUri forKey:@"error_uri"];
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if ((self = [super init])) {
        self.errorMessage = [decoder decodeObjectForKey:@"error"];
        self.errorCode = [decoder decodeObjectForKey:@"error_code"];
        self.errorDescription = [decoder decodeObjectForKey:@"error_description"];
        self.errorUri = [decoder decodeObjectForKey:@"error_uri"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
	[theCopy setErrorCode:self.errorCode];
    [theCopy setErrorMessage:[self.errorMessage copy]];
    [theCopy setErrorDescription:[self.errorDescription copy]];
    [theCopy setErrorUri:self.errorUri];
	
    return theCopy;
}
#pragma mark -
#pragma mark super class implementations

-(int) code
{
	if([self.errorCode intValue] == 0) return [super code];
	else return [self.errorCode intValue];		
}
- (NSString *) domain
{
    // we are assuming that any request within 1000 to 5000 is thrown by our server
	if([self.errorCode intValue] >= 1000 && [self.errorCode intValue] < 5000) return kBusinessErrorDomain;
    else return kRequestErrorDomain;
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%@[%@]:%@", self.errorMessage, self.errorCode,self.errorDescription];
}

- (NSString*) localizedDescription
{
    if([[self domain] isEqualToString:kBusinessErrorDomain])
        return [[errorCodes objectForKey:self.errorCode] objectForKey:@"Title"];
    else
        return [super localizedDescription];
}

- (NSString*) localizedRecoverySuggestion
{
    if([[self domain] isEqualToString:kBusinessErrorDomain])
        return [[errorCodes objectForKey:self.errorCode] objectForKey:@"Suggestion"];
    else
        return [super localizedRecoverySuggestion];
}

- (NSString*) localizedOption
{
    if([[self domain] isEqualToString:kBusinessErrorDomain])
        return [[errorCodes objectForKey:self.errorCode] objectForKey:@"Option-1"];
    else
        return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"Undefined Key: %@", key);
}

#pragma mark -
#pragma mark Our implementations
-(id) initWithDictionary:(NSDictionary*) jsonObject
{
    if((self = [super init]))
    {
        self = [self init];
        self.errorMessage = [jsonObject objectForKey:@"error"];
        self.errorCode = [jsonObject objectForKey:@"error_code"];
        self.errorDescription = [jsonObject objectForKey:@"error_description"];
        self.errorUri = [jsonObject objectForKey:@"error_uri"];
    }
    return self;
}

- (void)dealloc{
    self.errorMessage = nil;
    self.errorDescription = nil;
}
@end
