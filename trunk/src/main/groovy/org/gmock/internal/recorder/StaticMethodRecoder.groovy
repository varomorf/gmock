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

import org.gmock.internal.expectation.Expectation
import static org.gmock.internal.metaclass.MetaClassHelper.getGMockMethod
import org.gmock.internal.metaclass.ProxyMetaMethod
import org.gmock.internal.signature.StaticMethodSignature

class StaticMethodRecoder implements GroovyInterceptable {

    def classExpectations
    def aClass
    boolean missingExpectation = true

    StaticMethodRecoder(aClass, classExpectations, controller){
        this.classExpectations = classExpectations
        this.aClass = aClass
        this.metaClass = new StaticMethodRecorderProxyMetaClass(StaticMethodRecoder, controller)
        classExpectations.addStaticValidator { ->
            if (this.@missingExpectation) {
                throw new IllegalStateException("Missing static expectation for ${aClass.simpleName}")
            }
        }
    }

    Object invokeMethod(String name, Object args) {
        def expectation = new Expectation(signature: new StaticMethodSignature(aClass, name, args))
        classExpectations.addStaticExpectation(aClass, expectation)
        missingExpectation = false
        return new MethodRecorder(expectation)
    }

    Object getProperty(String property) {
        def expectation = new Expectation()
        classExpectations.addStaticExpectation(aClass, expectation)
        missingExpectation = false
        return new StaticPropertyRecorder(aClass, property, expectation)
    }

    void setProperty(String property, Object value) {
        throw new MissingPropertyException("Cannot use property setter in record mode. " +
                "Are you trying to mock a setter? Use 'static.${property}.set(${value.inspect()})' instead.")
    }

}

class StaticMethodRecorderProxyMetaClass extends ProxyMetaClass {

    def controller

    StaticMethodRecorderProxyMetaClass(Class clazz, controller) {
        super(GroovySystem.metaClassRegistry, clazz, GroovySystem.metaClassRegistry.getMetaClass(clazz))
        this.controller = controller
    }

    MetaMethod pickMethod(String methodName, Class[] arguments) {
        controller.doInternal {
            adaptee.pickMethod(methodName, arguments)
        } {
            if (!controller.replay) {
                def method = getGMockMethod(methodName, arguments, this, controller)
                if (method) return method
            }
            return new StaticMethodRecorderProxyMetaMethod(this, methodName, arguments)
        }
    }

}

class StaticMethodRecorderProxyMetaMethod extends ProxyMetaMethod {

    StaticMethodRecorderProxyMetaMethod(MetaClass metaClass, String name, Class[] parameterTypes) {
        super(metaClass, name, parameterTypes)
    }

    Object invoke(Object object, Object[] arguments) {
        object."$name"(*arguments)
    }

}
