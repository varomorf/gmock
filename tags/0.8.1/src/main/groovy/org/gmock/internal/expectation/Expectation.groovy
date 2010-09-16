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
package org.gmock.internal.expectation

import org.gmock.internal.result.ReturnNull
import org.gmock.internal.times.StrictTimes
import org.gmock.internal.signature.MethodSignature

class Expectation {

    def signature
    def signatureObserver
    def result = ReturnNull.INSTANCE
    def times = new StrictTimes(1)
    def called = 0
    def hidden = false
    def expectations

    def duplicate() {
        def result = new Expectation(signature: signature, signatureObserver: signatureObserver, result: result, expectations: expectations)
        expectations.duplicate(this, result)
        return result
    }

    void setSignature(signature) {
        this.signature = signature
        signatureObserver?.signatureChanged(this)
    }

    void setSignatureObserver(signatureObserver) {
        this.signatureObserver = signatureObserver
        if (signature) {
            signatureObserver.signatureChanged(this)
        }
    }

    boolean canCall(methodSignature) {
        return times.stillRemain(called) && signature.match(methodSignature)
    }

    def answer(arguments) {
        ++called
        return result.answer(arguments as Object[])
    }

    def isVerified() {
        return called in times
    }

    def satisfied() {
        isVerified()
    }

    def validate(){
        signature.validate()
    }

    String toString() {
        return "Expectation [signature: $signature, result: $result, times: $times]"
    }

    def findMatching(signature) {
        canCall(signature) ? this : null
    }

    def findSignature(signature) {
        signature.match(this.signature) ? this : null
    }


}
