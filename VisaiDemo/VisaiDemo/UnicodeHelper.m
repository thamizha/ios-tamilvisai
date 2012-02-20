//
//  UnicodeHelper.m
//  Transliteration Helper class
//
//  Created by Kishore Kumar (@techlona) - http://kishorek.com for Thamizha 

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


/************************************************
 The Transliteration logic is based on http://www.yash.info/indianLanguageConverter
 
 Following links have helped me on developing this.
 http://theorem.ca/~mvcorks/code/charsets/auto.html
 http://www.cocoadev.com/index.pl?UniCode
 ************************************************/

#import "UnicodeHelper.h"

@interface UnicodeHelper (PrivateMethods)

- (NSString *) parseSentence: (NSString *) sentence;
- (NSMutableArray *) splitWord:(NSString *) word;
- (NSString *) parseWord: (NSString *) word_ow;

@end


@implementation UnicodeHelper

@synthesize chars,vowels,consonants;

-(NSString *) getUnicodeConvertedString: (NSString *) str ofLanguage:(NSString *) lang{
	NSString *path = nil;
	
	if ([lang isEqualToString:@"tamil"]) {
		path = [[NSBundle mainBundle] pathForResource:
				@"Tamil" ofType:@"plist"];
		vowels = ta_vowels;
		consonants = ta_consonants;
	} else if ([lang isEqualToString:@"hindi"]) {
		path = [[NSBundle mainBundle] pathForResource:
				@"Hindi" ofType:@"plist"];
		vowels = hi_vowels;
		consonants = hi_consonants;
	} else if ([lang isEqualToString:@"malayalam"]) {
		path = [[NSBundle mainBundle] pathForResource:
				@"Malayalam" ofType:@"plist"];
		vowels = ma_vowels;
		consonants = ma_consonants;
	} else if ([lang isEqualToString:@"telugu"]) {
		path = [[NSBundle mainBundle] pathForResource:
				@"Telugu" ofType:@"plist"];
		vowels = te_vowels;
		consonants = te_consonants;
	} else if ([lang isEqualToString:@"punjabi"]) {
		path = [[NSBundle mainBundle] pathForResource:
				@"Punjabi" ofType:@"plist"];
		vowels = pu_vowels;
		consonants = pu_consonants;
	} else if ([lang isEqualToString:@"bengali"]) {
		path = [[NSBundle mainBundle] pathForResource:
				@"Bengali" ofType:@"plist"];
		vowels = be_vowels;
		consonants = be_consonants;
	} else if ([lang isEqualToString:@"gujarati"]) {
		path = [[NSBundle mainBundle] pathForResource:
				@"Gujarati" ofType:@"plist"];
		vowels = gu_vowels;
		consonants = gu_consonants;
	} else if ([lang isEqualToString:@"kannada"]) {
		path = [[NSBundle mainBundle] pathForResource:
				@"Kannada" ofType:@"plist"];
		vowels = ka_vowels;
		consonants = ka_consonants;
	} else if ([lang isEqualToString:@"oriya"]) {
		path = [[NSBundle mainBundle] pathForResource:
				@"Oriya" ofType:@"plist"];
		vowels = or_vowels;
		consonants = or_consonants;
	}
	
	
	// Build the array from the plist  
	chars = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	return [self parseSentence:str];
}


- (NSString *) parseSentence: (NSString *) sentence{
    
    NSString *regex =[NSString stringWithFormat:@"^((%@)|(%@))+",vowels,consonants];
    NSMutableArray *words = [[NSMutableArray alloc] init];
	
    while ([sentence length] >= 1) {
        NSArray *match = [sentence componentsMatchedByRegex:regex];
		NSString *matchStr = nil;
        if (match != nil && [match count]>0) {
            matchStr = [match objectAtIndex:0];
			[words addObject:[self parseWord:matchStr]];
            sentence = [sentence substringFromIndex:[matchStr length]];
        } else {
			[words addObject:[NSString stringWithFormat:@"%@",[sentence substringToIndex:1] ]];
            sentence = [sentence substringFromIndex:1];
        }
    }
	
	NSMutableString *str = [[[NSMutableString alloc] initWithString:@""] autorelease];
	for (id key in words) {
		[str appendString:key];
	}
    
    [words release];
    
	return str;
}

- (NSMutableArray *) splitWord:(NSString *) word{
	NSMutableArray *syllables = [[NSMutableArray alloc] init];
    BOOL vowel_start_p = YES;
	
    while (word!=nil && [word length]>0) {
		NSRange index = [word rangeOfString:vowels options:NSRegularExpressionSearch];		
        if (index.location==0) { 
			NSArray *matched = [word componentsMatchedByRegex:vowels];
			NSString *matchedStr = [matched objectAtIndex:0];
            
            if (vowel_start_p) {
				[syllables addObject:[NSString stringWithFormat:@"~%@",matchedStr]];
            } else {
				[syllables addObject:matchedStr];
            }
            vowel_start_p = YES;
            word = [word substringFromIndex:[matchedStr length]];
        } else {
			index = [word rangeOfString:consonants options:NSRegularExpressionSearch];
            if (index.location == 0) {
                NSArray *matched = [word componentsMatchedByRegex:consonants];
				NSString *matchedStr = [matched objectAtIndex:0];
				
                [syllables addObject:matchedStr];
                vowel_start_p = NO;
                word = [word substringFromIndex:[matchedStr length]];
				
				NSRange next = [word rangeOfString:vowels options:NSRegularExpressionSearch];
                if (next.location != 0 || word.length == 0) [syllables addObject:@"*"];
            } else {
                [syllables addObject:[NSString stringWithFormat:@"%@",[word substringToIndex:1]]];
                word = [word substringFromIndex:1];
            }
        }
    }
    return syllables;
}

- (NSString *) parseWord: (NSString *) word_ow{
	if (!word_ow) return @"";
	
    NSMutableArray *syllables_ow = [self splitWord:word_ow];
    NSMutableArray *letters_ow = [[NSMutableArray alloc] init];
	
    for (int i_ow = 0; i_ow < syllables_ow.count; i_ow++) {
		if (i_ow==0) {
			NSRange next = [[syllables_ow objectAtIndex:0] rangeOfString:consonants options:NSRegularExpressionSearch];
			if (next.location == 0) {
				if ([chars objectForKey:[NSString stringWithFormat:@"~%@",[syllables_ow objectAtIndex:i_ow]]]) {
					[letters_ow addObject: [chars objectForKey:[NSString stringWithFormat:@"~%@",[syllables_ow objectAtIndex:i_ow]]]];
					continue;
				}
			}
		} 
        
        if ([chars objectForKey:[syllables_ow objectAtIndex:i_ow]]) {
            [letters_ow addObject: [chars objectForKey:[syllables_ow objectAtIndex:i_ow]]];
        }        
    }
	
	NSMutableString *temp = [[NSMutableString alloc] initWithString:@""];
	for(id key in letters_ow){
		[temp appendString:key];
	}
	
	[letters_ow release];
	[syllables_ow release];
	
    return temp;
}

- (void) dealloc{
	[vowels release];
	[consonants release];
	[chars release];
	[super dealloc];
}


@end
