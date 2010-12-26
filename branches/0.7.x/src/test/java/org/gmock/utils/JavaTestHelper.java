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
package org.gmock.utils;

public class JavaTestHelper {

    public static boolean equalsToEachOther(Object a, Object b) {
        return a.equals(b);
    }

    public static int hashCodeOf(Object obj) {
        return obj.hashCode();
    }

    public static String toStringOn(Object obj) {
        return obj.toString();
    }

}