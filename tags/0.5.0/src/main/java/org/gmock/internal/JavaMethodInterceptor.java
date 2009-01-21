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
package org.gmock.internal;

import groovy.lang.GroovyObject;
import groovy.lang.MetaClass;
import net.sf.cglib.proxy.MethodInterceptor;
import net.sf.cglib.proxy.MethodProxy;

import java.lang.reflect.Method;

public class JavaMethodInterceptor implements MethodInterceptor {

    private GroovyObject gmc;

    private MetaClass mpmc;

    private Class mockClass;

    public JavaMethodInterceptor(GroovyObject gmc, MetaClass mpmc, Class mockClass) {
        this.gmc = gmc;
        this.mpmc = mpmc;
        this.mockClass = mockClass;
    }

    public Object intercept(Object obj, Method method, Object[] args, MethodProxy proxy) throws Throwable {
        if ("toString".equals(method.getName()) && args.length == 0 && !(Boolean) gmc.getProperty("replay")) {
            return "Mock for " + mockClass.getName();
        } else if ((Boolean) gmc.getProperty("internal")) {
            return proxy.invokeSuper(obj, args);
        } else {
            return mpmc.invokeMethod(obj, method.getName(), args);
        }
    }

}