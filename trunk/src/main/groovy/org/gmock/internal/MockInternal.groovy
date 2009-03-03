package org.gmock.internal

import org.gmock.internal.signature.MethodSignature
import org.gmock.internal.result.ToStringDefaultBehavior
import org.gmock.internal.result.HashCodeDefaultBehavior
import org.gmock.internal.result.EqualsDefaultBehavior
import org.gmock.internal.matcher.AlwaysMatchMatcher
import org.gmock.internal.times.AnyTimes
import org.gmock.internal.recorder.ReturnMethodRecorder
import static org.gmock.internal.metaclass.MetaClassHelper.*
import org.gmock.internal.recorder.StaticMethodRecoder
import static org.gmock.internal.InternalModeHelper.doExternal


class MockInternal {

    def expectations
    def mockInstance
    def controller
    def mockProxyMetaClass
    def mockName

    MockInternal(controller, mockInstance, mockName, mockProxyMetaClass){
        this.expectations = new ExpectationCollection(controller)
        this.controller = controller
        this.mockName = mockName
        this.mockProxyMetaClass = mockProxyMetaClass
        this.mockInstance = mockInstance
        mockProxyMetaClass.mock = this
    }

    void verify(){
        expectations.verify()
    }

    void validate(){
        expectations.validate()
    }

    void reset(){
        this.expectations = new ExpectationCollection(controller)
    }

    void replay() {
        addMethodDefaultBehavior("equals", [AlwaysMatchMatcher.INSTANCE], new EqualsDefaultBehavior(mockInstance))
        addMethodDefaultBehavior("hashCode", [], new HashCodeDefaultBehavior(mockInstance))
        addMethodDefaultBehavior("toString", [], new ToStringDefaultBehavior(mockName))
    }

    private addMethodDefaultBehavior(methodName, arguments, result) {
        def signature = new MethodSignature(mockProxyMetaClass, methodName, arguments)
        if (!expectations.findSignature(signature) && !controller.orderedExpectations.findSignature(signature)) {
            def expectation = new Expectation(signature: signature, result: result, times: AnyTimes.INSTANCE, hidden: true)
            expectations.add(expectation)
        }
    }


    Object invokeMockMethod(Class sender, Object receiver, String methodName, Object[] arguments) {
        def signature = newSignatureForMethod(mockProxyMetaClass, methodName, arguments)
        if (controller.replay){
            def result =  findExpectation(expectations, signature, "Unexpected method call", arguments, controller)
            return result
        } else {
            if (methodName == "static" && arguments.length == 1 && arguments[0] instanceof Closure) {
                invokeStaticExpectationClosure(arguments[0])
                return null
            } else {
                def expectation = new Expectation(signature: signature)
                addToExpectations(expectation, expectations, controller)
                return new ReturnMethodRecorder(expectation)
            }
        }
    }
    private invokeStaticExpectationClosure(Closure staticExpectationClosure) {
        def recorder = new StaticMethodRecoder(mockProxyMetaClass.theClass, mockProxyMetaClass.classExpectations, controller)
        staticExpectationClosure.resolveStrategy = Closure.DELEGATE_FIRST
        staticExpectationClosure.delegate = recorder
        def backup = controller.mockDelegate
        try {
            controller.mockDelegate = recorder
            doExternal(controller) {
                staticExpectationClosure(recorder)
            }
        } finally {
            controller.mockDelegate = backup
        }
    }

}