//
//  KIFAssertionMap.h
//  KIF
//
//  Created by Tony DiPasquale on 12/9/13.
//
//

#ifndef KIF_KIFAssertionMap_h
#define KIF_KIFAssertionMap_h

#ifdef XCT_EXPORT

#define KIFFail XCTFail
#define KIFAssertEqual XCTAssertEqual

#else

#define KIFFail STFail
#define KIFAssertEqual STAssertEquals

#endif

#endif
