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
package org.gmock.internal.recorder

import org.gmock.internal.result.ReturnNull
import org.gmock.internal.result.ReturnValue
import org.gmock.internal.result.ThrowException
import org.gmock.internal.signature.PropertyGetSignature
import org.gmock.internal.signature.PropertySetSignature
import org.gmock.internal.signature.PropertyUncompleteSignature

class PropertyRecorder extends BaseRecorder {

    def mock
    def propertyName

    PropertyRecorder(mock, propertyName, expectation) {
        super(expectation)
        this.mock = mock
        this.propertyName = propertyName
        this.expectation.signature = new PropertyUncompleteSignature(mock, propertyName)
    }

    def sets(value) {
        throw new DeprecationException("'sets' is deprecated. Use 'set' instead.");
    }

    def set(value) {
        expectation.signature = new PropertySetSignature(mock, propertyName, value)
        expectation.result = ReturnNull.INSTANCE
        return this
    }

    def returns(value) {
        expectation.signature = new PropertyGetSignature(mock, propertyName)
        expectation.result = new ReturnValue(value)
        return this
    }

    private doRaises(Object[] params) {
        if (expectation.signature.class == PropertyUncompleteSignature){
            expectation.signature = new PropertyGetSignature(mock, propertyName)
        }
        expectation.result = ThrowException.metaClass.invokeConstructor(params)
        return this
    }

    def raises(Throwable exception) {
        return doRaises(exception)
    }

    def raises(Class exceptionClass, Object[] params) {
        return doRaises(exceptionClass, *params)
    }

}
