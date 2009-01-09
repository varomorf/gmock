/*
 * Copyright 2008-2009 Julien Gagnet, Johnny Jian
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.gmock.internal

import junit.framework.AssertionFailedError
import org.gmock.GMockTestCase
import org.gmock.internal.signature.MethodSignature
import org.gmock.internal.times.RangeTimes
import org.gmock.internal.times.StrictTimes

class ExpectationCollectionTest extends GMockTestCase {

    ExpectationCollection expectations = new ExpectationCollection()
    def mockExpectation1 = mock()
    def mockExpectation2 = mock()
    def mockExpectation3 = mock()

    void testAdd() {
        assertEquals([], expectations.expectations)

        def expectation1 = new Expectation()
        def expectation2 = new Expectation()
        expectations.add expectation1
        assertEquals([expectation1], expectations.expectations)

        expectations.add expectation2
        assertEquals([expectation1, expectation2], expectations.expectations)
    }

    void testFindMatching() {
        def signature = new MethodSignature("method", [1, 2])
        mockExpectation1.canCall(signature).returns(false)
        mockExpectation2.canCall(signature).returns(true)
        expectations.expectations = [mockExpectation1, mockExpectation2, mockExpectation3]

        play {
            assertEquals mockExpectation2, expectations.findMatching(signature)
        }
    }

    void testVerify() {
        mockExpectation1.isVerified().returns(true)
        mockExpectation2.isVerified().returns(true)
        mockExpectation3.isVerified().returns(true)
        expectations.expectations = [mockExpectation1, mockExpectation2, mockExpectation3]

        play {
            expectations.verify()
        }
    }

    void testVerifyFailed() {
        def mockCallState = mock(CallState, constructor())
        mockCallState.append(mockExpectation1)
        mockCallState.append(mockExpectation2)
        mockCallState.append(mockExpectation3)
        mockCallState.toString().returns("mockCallState")
        mockExpectation1.isVerified().returns(true)
        mockExpectation2.isVerified().returns(false)
        expectations.expectations = [mockExpectation1, mockExpectation2, mockExpectation3]
        def expected = "Expectation not matched on verify:\nmockCallState"

        play {
            def message = shouldFail(AssertionFailedError) {
                expectations.verify()
            }
            assertEquals expected, message
        }
    }

    void testCallState() {
        def mockCallState = mock(CallState, constructor())
        mockCallState.append(mockExpectation1)
        mockCallState.append(mockExpectation2)
        mockCallState.append(mockExpectation3)
        expectations.expectations = [mockExpectation1, mockExpectation2, mockExpectation3]

        play {
            assertEquals mockCallState, expectations.callState()
        }
    }

    void testEmpty() {
        expectations.expectations = []
        assert expectations.empty()

        expectations.expectations = [new Expectation()]
        assertFalse expectations.empty()
    }

    void testCheckTimes() {
        def signature1 = new MethodSignature("a", [1])
        def signature2 = new MethodSignature("b", [2])
        mockExpectation3.is(mockExpectation3).returns(true)
        mockExpectation2.is(mockExpectation3).returns(false)
        mockExpectation1.is(mockExpectation3).returns(false)
        mockExpectation3.signature.returns(signature1).atLeast(1)
        mockExpectation2.signature.returns(signature2)
        mockExpectation1.signature.returns(signature1)
        mockExpectation1.times.returns(new StrictTimes(2))
        expectations.expectations = [mockExpectation1, mockExpectation2, mockExpectation3]

        play {
            expectations.checkTimes(mockExpectation3)
        }
    }

    void testCheckTimesFailed() {
        def signature = new MethodSignature("a", [1])

        mockExpectation3.is(mockExpectation3).returns(true)
        mockExpectation2.is(mockExpectation3).returns(false)
        mockExpectation3.signature.returns(signature).atLeast(1)
        mockExpectation2.signature.returns(signature)
        mockExpectation2.times.returns(new RangeTimes(1..2))

        def mockExpectations = mock()
        mockExpectations.reverse().returns([mockExpectation3, mockExpectation2, mockExpectation1])
        mockExpectations.remove(mockExpectation3)
        expectations.expectations = mockExpectations

        play {
            def message = shouldFail(IllegalStateException) {
                expectations.checkTimes(mockExpectation3)
            }
            assertEquals "Last method called on mock already has a non-fixed count set.", message
        }
    }

}
