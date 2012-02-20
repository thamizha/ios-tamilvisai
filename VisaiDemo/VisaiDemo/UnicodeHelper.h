//
//  UnicodeHelper.h
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

#import <UIKit/UIKit.h>
#import <UIKit/UIWebView.h>
#import "RegexKitLite.h"

#define ta_vowels @"(a(a|i|e|u)?)|(ee?)|(i(i)?)|(o(o|a)?)|(u(u)?)|(A(hh)?)|(E)|(I)|(O)|(U)|(H)"
#define ta_consonants @"(bh?)|(ch?)|(dh?)|(f)|(g)|(h)|(j)|(kh?)|(l)|(L)|(m)|(n(g|j|N|G|Y)?)|(N)|(p)|(q)|(r)|(R)|(S)|(sh?)|(th?)|(v)|(w)|(y)|(zh)|(z)"

#define hi_vowels @"(A((o)|(O))?)|(a((A)|(a)|(u)|(i))?)|(En)|(e(e)?)|(I)|(H)|(TR)|(M)|(o(o)?)|(tR)|(i)|(U)|(u)|([:])|([|]([|])?)"
#define hi_consonants @"(Ch)|(D(dD|h)?)|(G)|(L(lL)?)|(N(nN)?)|(R(rR)?)|(Sh)|(Th?)|(Y)|(bh?)|(ch)|(dh?)|(f)|(g(h|G)?)|(h)|(jh?)|(kh?)|(l)|(m)|(nY?)|(ph?)|(qh?)|(r)|(sh?)|(th?)|(v)|(y)|(z)|(Bh?)"

#define ma_vowels @"(a(a|e|i|u)?)|(i)|(ee?)|(u)|(o(o|a)?)|(Rr)|(Am)|(Ahh)"
#define ma_consonants @"(bh?)|(Bh?)|(ch?)|(Ch?)|(dh?)|(D(h|H)?)|(f)|(g)|(Gh?)|(h)|(j)|(Jh?)|(k)|(Kh?)|(l)|(L)|(m)|(N)|(n(y|g)?)|(ph?)|(r)|(R)|(th?)|(T)|(sh?)|(Sh)|(v)|(y)|(zh)"

#define te_vowels @"(A(O)?)|(a((a)|(i)|(e)|(u))?)|(E)|(I)|(H)|(TR)|(M)|(O)|(tR)|(i)|(U)|(o((a)|(o))?)|(e(e)?)|(u)|(\\:)"
#define te_consonants @"(ch)|(r)|(b(h)?)|(B(h)?)|(D(h)?)|(G)|(K(h)?)|(J(h)?)|(L)|(N)|(R)|(T(h)?)|(Ch)|(d(h)?)|(g(h)?)|(h)|(k(h)?)|(j(h)?)|(m)|(l)|(n(Y)?)|(p(h)?)|(s(h)?)|(Sh)|(t(h)?)|(v)|(y)"

#define pu_vowels @"(An)|(a(a|e|i|u)?)|(ee?)|(i)|(o(a|o)?)|(u)"
#define pu_consonants @"(Bh?)|(Ch)|(Dh?)|(Gh?)|(Kh)|(L)|(N)|(R)|(Sh)|(Th?)|(bh?)|(ch)|(dh?)|(f)|(gh?)|(h)|(jh?)|(kh?)|(l)|(m)|(n(G|y)?)|(ph?)|(q)|(r)|(sh?)|(th?)|(v)|(y)|(z)"

#define be_vowels @"(A(O)?)|(a((a)|(i)|(u))?)|(e(e)?)|(I)|(H)|(M)|(L((l(L)?)))|(o(o)?)|(i)|(R((r(R)?)))|(U)|(u)"
#define be_consonants @"(Ch)|(B(h)?)|(D(h)?)|(G)|(N)|(Sh)|(T(h)?)|(Y)|(ch)|(b(h)?)|(d(h)?)|(g(h)?)|(h)|(k(h)?)|(j(h)?)|(m)|(l)|(n(Y)?)|(p(h)?)|(s(h)?)|(r((R(r)?))?)|(t(h)?)|(v)|(y)"

#define gu_vowels @"(A((o)|(O))?)|(a((A)|(a)|(u)|(i))?)|(En)|(e(e)?)|(I)|(H)|(TR)|(M)|(o(o)?)|(tR)|(i)|(U)|(u)|([:])|([|]([|])?)|(Om)"
#define gu_consonants @"(Ch)|(D(dD|h)?)|(G)|(L(lL)?)|(N(nN)?)|(R(rRU)?)|(Sh)|(Th?)|(Y)|(bh?)|(ch)|(dh?)|(f)|(g(h|G)?)|(h)|(jh?)|(kh?)|(l)|(m)|(nY?)|(ph?)|(qh?)|(r)|(sh?)|(th?)|(v)|(y)|(z)|(Bh?)"

#define ka_vowels @"(A)|(a((a)|(i)|(e)|(u))?)|(E)|(o((a)|(o))?)|(I)|(H)|(M)|(O)|(i)|(U)|(TR)|(e(e)?)|(u)|(tR)";
#define ka_consonants @"(Ch)|(B(h)?)|(D(h)?)|(K(h)?)|(J(h)?)|(L)|(N)|(Sh)|(T(h)?)|(ch)|(b(h)?)|(d(h)?)|(g(h)?)|(f)|(h)|(k(h)?)|(j(h)?)|(m)|(l)|(n((Y)|(G))?)|(p(h)?)|(s(h)?)|(r(R)?)|(t(h)?)|(v)|(w)|(y)";

#define or_vowels @"(A((h(h|n))|(m)|(n))?)|(a(a|i|u)?)|(ee?)|(i)|(oo?)|(rRr?)|(u)"
#define or_consonants @"(Ch)|(Dh?)|(L)|(N)|(Rr?)|(Sh)|(Th?)|(Y)|(bh?)|(ch)|(dh?)|(gh?)|(h)|(jh?)|(kh?)|(l)|(m)|(n(g|y)?)|(ph?)|(r)|(sh?)|(th?)|(y)|(v)"

@interface UnicodeHelper : NSObject {
	NSMutableDictionary *chars;
	NSString *vowels;
	NSString *consonants;
}

@property(nonatomic, retain) NSMutableDictionary *chars;
@property(nonatomic, retain) NSString *vowels;
@property(nonatomic, retain) NSString *consonants;

-(NSString *) getUnicodeConvertedString: (NSString *) str ofLanguage:(NSString *) lang;

@end
