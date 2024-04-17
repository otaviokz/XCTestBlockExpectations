## Overview

This package is meant solely to add a new type of XCTestExpectation to your XCTestCase files. It creates expectations by passing a code block `() -> Bool` that is evaluated multiple times, either until it returns `true` or the `waitForExpectations(timeout:)` times out.

This block expectation is meant primarily to test asynchronows logic, since the code block is executed multiple times until `waitForExpectations` times out.

It's still in a beta stage because I'm still trying to find the most elegant and safe way to implement it, although it has been working correctly and reliably for most my personal use.

Methods available:

```Swift
func blockExpectation(block: @escaping () -> Bool) -> XCTestExpectation
``` 

### Usage examples:

```Swift
func testSomesynchronousCall() throws {
	// GIVEN
	let mockApi = MockApi()
	let viewModel(api: mockApi)

	_ = blockExpectation {
		viewModel.isLoading == true &&
		viewModel.items.isEmpty == true
	}

	_ = blockExpectation {
		viewModel.isLoading == false &&
		viewModel.items.isEmpty == false
	}

	viewModel.fetchItems()

	// When
	DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1.25) {
    	mockApi.returnItems()
    }

    // Then
    waitForExpectations(timeOut: 5)
}
```

A case similar to the example above can be seen at one of my tech tests [repo](https://github.com/otaviokz/TVmazeAssessmentVIPER), on thi [TestCase](https://github.com/otaviokz/TVmazeAssessmentVIPER/blob/develop/TVMazeAssessmentVIPERTests/Interactors/PagedShowsInteractorTests.swift).

## Contact

otaviokz@gmail.com

[otaviokz.com](https://otaviokz.com)

[linkedin.com/in/otaviokz](http://www.linkedin.com/in/otaviokz)

## Licensing 

#### <p>```  MIT Lisense  ```</p>

Copyright (c) 2024 Otavio Zabaleta

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.