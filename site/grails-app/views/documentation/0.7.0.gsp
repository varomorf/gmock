<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Gmock: Documentation 0.7.0</title>
    <meta name="layout" content="main"/>
</head>


<body>

<div class="container">

    <div class="span-24 source">
        <h1><a name="Introduction">Introduction</a></h1><p><a name="Introduction">Gmock is a mocking framework for the Groovy language.  </a></p><p><a name="Introduction">Gmock is all about simple syntax and readability of your tests so you spend less time learning the framework and more time writing code. To use Gmock just drop the gmock jar file into your classpath and make sure you also have junit. </a></p><p><a name="Introduction">This documention describes the version 0.7 of Gmock. </a></p><h1><a name="Getting_Started">Getting Started</a></h1><h2><a name="Simple_Test">Simple Test</a></h2><p><a name="Simple_Test">  </a></p><pre class="prettyprint"><a name="Simple_Test"><span class="kwd">import</span><span class="pln"> org</span><span class="pun">.</span><span class="pln">gmock</span><span class="pun">.</span><span class="typ">GMockTestCase</span><span class="pln"><br><br></span><span class="kwd">class</span><span class="pln"> </span><span class="typ">LoaderTest</span><span class="pln"> </span><span class="kwd">extends</span><span class="pln"> </span><span class="typ">GMockTestCase</span><span class="pln"> </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; </span><span class="kwd">void</span><span class="pln"> testLoader</span><span class="pun">(){</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp; </span><span class="kwd">def</span><span class="pln"> mockLoader </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp; mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="str">'key'</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">'value'</span><span class="pun">)</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp; play </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; assertEquals </span><span class="str">"value"</span><span class="pun">,</span><span class="pln"> mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="str">'key'</span><span class="pun">)</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp; </span><span class="pun">}</span><span class="pln"><br>&nbsp; &nbsp; </span><span class="pun">}</span><span class="pln"><br></span><span class="pun">}</span><span class="pln"> &nbsp;</span></a></pre><ul><li><a name="Simple_Test">First extend the <tt>GMockTestCase</tt> </a></li><li><a name="Simple_Test">Create mock objects using the <tt>mock()</tt> method </a></li><li><a name="Simple_Test">Set up expectations by calling the methods you expect on your mock </a></li><li><a name="Simple_Test">Run the code you are testing within the <tt>play</tt> closure </a></li></ul><h2><a name="Expectation_and_Play_mode">Expectation and Play mode</a></h2><p><a name="Expectation_and_Play_mode">Mock objects are created using the <tt>mock()</tt> method available in <tt>GMockTestCase</tt>. By default mock objects will record method calls and generate expectations. </a></p><p><a name="Expectation_and_Play_mode">The code under test should run through the <tt>play</tt> closure.  </a></p><pre class="prettyprint"><a name="Expectation_and_Play_mode"><span class="kwd">void</span><span class="pln"> testBasic</span><span class="pun">(){</span><span class="pln"><br>&nbsp; </span><span class="kwd">def</span><span class="pln"> aMock </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>&nbsp; </span><span class="com">// set up expectation</span><span class="pln"><br>&nbsp; play </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; </span><span class="com">// run your code </span><span class="pln"><br>&nbsp; </span><span class="pun">}</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Expectation_and_Play_mode">Gmock supports Java strong typing. The <tt>mock()</tt> method takes an optional class. More about that in the strong typing section. </a></p><pre class="prettyprint"><a name="Expectation_and_Play_mode"><span class="pln">&nbsp; </span><span class="typ">File</span><span class="pln"> mockFile </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">File</span><span class="pun">)</span></a></pre><h2><a name="Strong_typing">Strong typing</a></h2><p><a name="Strong_typing">Gmock supports out-of-the-box Java strong typing. You don't need to import any extra libraries - we've done that for you. Mock objects can be used in a pure Java project which makes Gmock a powerful alternative for Java testing. </a></p><pre class="prettyprint"><a name="Strong_typing"><span class="typ">File</span><span class="pln"> mockFile </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">File</span><span class="pun">)</span></a></pre><p><a name="Strong_typing">Strong typing works well with constructor call expectations: </a></p><pre class="prettyprint"><a name="Strong_typing"><span class="typ">File</span><span class="pln"> mockFile </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">File</span><span class="pun">,</span><span class="pln"> </span><span class="kwd">constructor</span><span class="pun">(</span><span class="str">"/a/path/file.txt"</span><span class="pun">))</span><span class="pln"><br>mockFile</span><span class="pun">.</span><span class="pln">getName</span><span class="pun">().</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"file.txt"</span><span class="pun">)</span><span class="pln"><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; </span><span class="kwd">def</span><span class="pln"> file </span><span class="pun">=</span><span class="pln"> </span><span class="kwd">new</span><span class="pln"> </span><span class="typ">File</span><span class="pun">(</span><span class="str">"/a/path/file.txt"</span><span class="pun">)</span><span class="pln"><br>&nbsp; assertEquals </span><span class="str">"file.txt"</span><span class="pun">,</span><span class="pln"> file</span><span class="pun">.</span><span class="pln">getName</span><span class="pun">()</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Strong_typing">Sometimes you need to call the original constructor when mocking an object. Use the <tt>invokeConstructor</tt> for that purpose: </a></p><pre class="prettyprint"><a name="Strong_typing"><span class="typ">JavaLoader</span><span class="pln"> mock </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">JavaLoader</span><span class="pun">,</span><span class="pln"> invokeConstructor</span><span class="pun">(</span><span class="str">"loader"</span><span class="pun">),</span><span class="pln"> </span><span class="kwd">constructor</span><span class="pun">(</span><span class="str">"name"</span><span class="pun">))</span></a></pre><p><a name="Strong_typing">This would create a <tt>JavaLoader</tt> using its constructor with "loader" during the creation process of the mock. </a></p><h1><a name="Mocking">Mocking</a></h1><h2><a name="Mock_method_call">Mock method call</a></h2><p><a name="Mock_method_call">Method call expectations are created when calling methods on Mock. Return values can be set up using the <tt>returns</tt> keyword. </a></p><pre class="prettyprint"><a name="Mock_method_call"><span class="kwd">def</span><span class="pln"> loader </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"fruit"</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"apple"</span><span class="pun">)</span><span class="pln"><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; assertEquals </span><span class="str">"apple"</span><span class="pun">,</span><span class="pln"> loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"fruit"</span><span class="pun">)</span><span class="pln"> <br></span><span class="pun">}</span></a></pre><p><a name="Mock_method_call">Exceptions can be set up using the <tt>raises</tt> keyword. </a></p><pre class="prettyprint"><a name="Mock_method_call"><span class="kwd">def</span><span class="pln"> loader </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"throw exception"</span><span class="pun">).</span><span class="pln">raises</span><span class="pun">(</span><span class="kwd">new</span><span class="pln"> </span><span class="typ">RuntimeException</span><span class="pun">(</span><span class="str">"an exception"</span><span class="pun">))</span><span class="pln"> </span><span class="com">// or 'raises(RuntimeException, "an exception")'</span><span class="pln"><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; </span><span class="kwd">def</span><span class="pln"> message </span><span class="pun">=</span><span class="pln"> shouldFail</span><span class="pun">(</span><span class="typ">RuntimeException</span><span class="pun">)</span><span class="pln"> </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"throw exception"</span><span class="pun">)</span><span class="pln"> <br>&nbsp; </span><span class="pun">}</span><span class="pln"><br>&nbsp; assertEquals </span><span class="str">"an exception"</span><span class="pun">,</span><span class="pln"> message<br></span><span class="pun">}</span></a></pre><h2><a name="Mock_property_call">Mock property call</a></h2><p><a name="Mock_property_call">Property calls should be mocked using the following syntax. For Setters and getters </a></p><pre class="prettyprint"><a name="Mock_property_call"><span class="kwd">def</span><span class="pln"> loader </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>loader</span><span class="pun">.</span><span class="pln">name</span><span class="pun">.</span><span class="kwd">set</span><span class="pun">(</span><span class="str">"a name"</span><span class="pun">)</span><span class="pln"><br>loader</span><span class="pun">.</span><span class="pln">name</span><span class="pun">.</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"a different name"</span><span class="pun">)</span><span class="pln"><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; loader</span><span class="pun">.</span><span class="pln">name </span><span class="pun">=</span><span class="pln"> </span><span class="str">"a name"</span><span class="pln"><br>&nbsp; assertEquals </span><span class="str">"a different name"</span><span class="pun">,</span><span class="pln"> loader</span><span class="pun">.</span><span class="pln">name<br></span><span class="pun">}</span></a></pre><p><a name="Mock_property_call">Support for exceptions and method stubs are similar to standard method calls. Ex: </a></p><ul><li><a name="Mock_property_call"><tt>loader.name.raises(RuntimeException)</tt> </a></li><li><a name="Mock_property_call"><tt>loader.name.set("invalid").raises(new RuntimeException())</tt> </a></li><li><a name="Mock_property_call"><tt>mockLoader.name.returns('a name').stub()</tt> </a></li></ul><p><a name="Mock_property_call">Property expectations are transparently translated to their method equivalent and vice versa.  So you can write <tt>mockUrl.text.returns("some text")</tt> in you expectation and have <tt>mock.getText()</tt> in your code. </a></p><h2><a name="Mock_static_call">Mock static call</a></h2><p><a name="Mock_static_call">Mocking static method calls and property call is similar to standard method calls, just add the static keyword: </a></p><pre class="prettyprint"><a name="Mock_static_call"><span class="kwd">def</span><span class="pln"> mockMath </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">Math</span><span class="pun">)</span><span class="pln"><br>mockMath</span><span class="pun">.</span><span class="kwd">static</span><span class="pun">.</span><span class="pln">random</span><span class="pun">().</span><span class="pln">returns</span><span class="pun">(</span><span class="lit">0.5</span><span class="pun">)</span><span class="pln"><br><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp;assertEquals </span><span class="lit">0.5</span><span class="pun">,</span><span class="pln"> </span><span class="typ">Math</span><span class="pun">.</span><span class="pln">random</span><span class="pun">()</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h2><a name="Partial_mock">Partial mock</a></h2><p><a name="Partial_mock">Partial mock let you mock single method out of an object. Having to mock out method is usually considered as a bad design but we believe it to be different in a dynamic environment where you will get method automatically injected for you. </a></p><p><a name="Partial_mock">Calling <tt>mock(object)</tt> on a concrete object will return a mock version of it. You will be able to setup expectation on that object whilst being able to use the concrete implementation. Your test will look like this: </a></p><pre class="prettyprint"><a name="Partial_mock"><span class="kwd">def</span><span class="pln"> controller </span><span class="pun">=</span><span class="pln"> </span><span class="kwd">new</span><span class="pln"> </span><span class="typ">SomeController</span><span class="pun">()</span><span class="pln"><br></span><span class="kwd">def</span><span class="pln"> mockController </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="pln">controller</span><span class="pun">)</span><span class="pln"><br>mockController</span><span class="pun">.</span><span class="kwd">params</span><span class="pun">.</span><span class="pln">returns </span><span class="pun">=</span><span class="pln"> </span><span class="pun">[</span><span class="pln">id</span><span class="pun">:</span><span class="pln"> </span><span class="lit">3</span><span class="pun">]</span><span class="pln"><br></span><span class="kwd">def</span><span class="pln"> mockRequest </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>mockController</span><span class="pun">.</span><span class="pln">request</span><span class="pun">.</span><span class="pln">returns</span><span class="pun">(</span><span class="pln">mockRequest</span><span class="pun">)</span></a></pre><p><a name="Partial_mock">Or you could use the shortcut version of it: </a></p><pre class="prettyprint"><a name="Partial_mock"><span class="kwd">def</span><span class="pln"> controller </span><span class="pun">=</span><span class="pln"> </span><span class="kwd">new</span><span class="pln"> </span><span class="typ">SomeController</span><span class="pun">()</span><span class="pln"><br>mock</span><span class="pun">(</span><span class="pln">controller</span><span class="pun">).</span><span class="kwd">params</span><span class="pun">.</span><span class="pln">returns </span><span class="pun">=</span><span class="pln"> </span><span class="pun">[</span><span class="pln">id</span><span class="pun">:</span><span class="pln"> </span><span class="lit">3</span><span class="pun">]</span><span class="pln"><br></span><span class="kwd">def</span><span class="pln"> mockRequest </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>mock</span><span class="pun">(</span><span class="pln">controller</span><span class="pun">).</span><span class="pln">request</span><span class="pun">.</span><span class="pln">returns</span><span class="pun">(</span><span class="pln">mockRequest</span><span class="pun">)</span></a></pre><p><a name="Partial_mock">This could be incredibly  useful in the Grails environment, let's pick a simple tag lib: </a></p><pre class="prettyprint"><a name="Partial_mock"><span class="kwd">class</span><span class="pln"> </span><span class="typ">FakeTagLib</span><span class="pln"> </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp;</span><span class="kwd">def</span><span class="pln"> hello </span><span class="pun">=</span><span class="pln"> </span><span class="pun">{</span><span class="pln"> attrs </span><span class="pun">-&gt;</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp; </span><span class="kwd">out</span><span class="pln"> </span><span class="pun">&lt;&lt;</span><span class="pln"> </span><span class="str">"hello"</span><span class="pln"><br>&nbsp; &nbsp; </span><span class="pun">}</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Partial_mock">We can mock the <tt>out</tt> property that way: </a></p><pre class="prettyprint"><a name="Partial_mock"><span class="kwd">def</span><span class="pln"> tagLib </span><span class="pun">=</span><span class="pln"> </span><span class="kwd">new</span><span class="pln"> </span><span class="typ">FakeTagLib</span><span class="pun">()</span><span class="pln"><br></span><span class="kwd">def</span><span class="pln"> mockTabLib </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="pln">tagLib</span><span class="pun">)</span><span class="pln"><br></span><span class="kwd">def</span><span class="pln"> mockOut </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br><br>mockTabLib</span><span class="pun">.</span><span class="kwd">out</span><span class="pun">.</span><span class="pln">returns</span><span class="pun">(</span><span class="pln">mockOut</span><span class="pun">)</span><span class="pln"><br>mockOut </span><span class="pun">&lt;&lt;</span><span class="pln"> </span><span class="str">"hello"</span><span class="pln"><br><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; tagLib</span><span class="pun">.</span><span class="pln">hello</span><span class="pun">()</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h2><a name="Mock_constructor_call">Mock constructor call</a></h2><p><a name="Mock_constructor_call">Constructor calls are mocked using the following syntax: </a></p><pre class="prettyprint"><a name="Mock_constructor_call"><span class="kwd">def</span><span class="pln"> mockFile </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">File</span><span class="pun">,</span><span class="pln"> </span><span class="kwd">constructor</span><span class="pun">(</span><span class="str">"/a/path/file.txt"</span><span class="pun">))</span></a></pre><p><a name="Mock_constructor_call">This would match: <tt>new File("/a/path/file.txt")</tt>. The mockFile can then be used to set up further expectations. </a></p><p><a name="Mock_constructor_call">Here is the full picture: </a></p><pre class="prettyprint"><a name="Mock_constructor_call"><span class="kwd">def</span><span class="pln"> mockFile </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">File</span><span class="pun">,</span><span class="pln"> </span><span class="kwd">constructor</span><span class="pun">(</span><span class="str">"/a/path/file.txt"</span><span class="pun">))</span><span class="pln"><br>mockFile</span><span class="pun">.</span><span class="pln">getName</span><span class="pun">().</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"file.txt"</span><span class="pun">)</span><span class="pln"><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; </span><span class="kwd">def</span><span class="pln"> file </span><span class="pun">=</span><span class="pln"> </span><span class="kwd">new</span><span class="pln"> </span><span class="typ">File</span><span class="pun">(</span><span class="str">"/a/path/file.txt"</span><span class="pun">)</span><span class="pln"><br>&nbsp; assertEquals </span><span class="str">"file.txt"</span><span class="pun">,</span><span class="pln"> file</span><span class="pun">.</span><span class="pln">getName</span><span class="pun">()</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Mock_constructor_call">You can expect an exception to be raised when a constructor call is matched: </a></p><pre class="prettyprint"><a name="Mock_constructor_call"><span class="kwd">def</span><span class="pln"> mockFile </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">File</span><span class="pun">,</span><span class="pln"> </span><span class="kwd">constructor</span><span class="pun">(</span><span class="str">"/a/path/file.txt"</span><span class="pun">).</span><span class="pln">raises</span><span class="pun">(</span><span class="typ">RuntimeException</span><span class="pun">))</span><span class="pln"><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; shouldFail</span><span class="pun">(</span><span class="typ">RuntimeException</span><span class="pun">)</span><span class="pln"> </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; </span><span class="kwd">new</span><span class="pln"> </span><span class="typ">File</span><span class="pun">(</span><span class="str">"/a/path/file.txt"</span><span class="pun">)</span><span class="pln"><br>&nbsp; </span><span class="pun">}</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h1><a name="Matching">Matching</a></h1><h2><a name="Time_matching">Time matching</a></h2><p><a name="Time_matching">Gmock lets you specify how many times an expectation can be called. Like here: </a></p><pre class="prettyprint"><a name="Time_matching"><span class="pln">mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="lit">2</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="lit">3</span><span class="pun">).</span><span class="pln">atLeastOnce</span><span class="pun">()</span><span class="pln"><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; assertEquals </span><span class="lit">3</span><span class="pun">,</span><span class="pln"> mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="lit">2</span><span class="pun">)</span><span class="pln"><br>&nbsp; &nbsp; assertEquals </span><span class="lit">3</span><span class="pun">,</span><span class="pln"> mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="lit">2</span><span class="pun">)</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Time_matching">The supported times matchers are: </a></p><ul><li><a name="Time_matching"><strong>never()</strong> the expectation should never be called </a></li><li><a name="Time_matching"><strong>once()</strong> one time expectation (this is the implicit default) </a></li><li><a name="Time_matching"><strong>atLeastOnce()</strong> one or more times </a></li><li><a name="Time_matching"><strong>atMostOnce()</strong> zero or one time expectation </a></li><li><a name="Time_matching"><strong>stub()</strong> the expectation can be called anytime </a></li><li><a name="Time_matching"><strong>times(3)</strong> the expectation needs to be call n times </a></li><li><a name="Time_matching"><strong>times(2..4)</strong> the expectation needs to be called n times within the range </a></li><li><a name="Time_matching"><strong>atLeast(4)</strong> the expectation needs to be called at least n times </a></li><li><a name="Time_matching"><strong>atMost(4)</strong> the expectation needs to be called at most n times </a></li></ul><h2><a name="Using_matcher">Using matcher</a></h2><p><a name="Using_matcher">You can set up a customised matcher in your expectation using the <tt>match</tt> syntax. The argument gets passed to match closure and will return true if it matches. </a></p><p><a name="Using_matcher">Here is the idea: </a></p><pre class="prettyprint"><a name="Using_matcher"><span class="pln">mockLoader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"test"</span><span class="pun">,</span><span class="pln"> match </span><span class="pun">{</span><span class="pln"> it </span><span class="pun">&gt;</span><span class="pln"> </span><span class="lit">5</span><span class="pln"> </span><span class="pun">}).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"correct"</span><span class="pun">)</span><span class="pln"><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; assertEquals </span><span class="str">"correct"</span><span class="pun">,</span><span class="pln"> mockLoader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"test"</span><span class="pun">,</span><span class="pln"> </span><span class="lit">10</span><span class="pun">)</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Using_matcher">Gmock is also fully compatible with the </a><a href="http://code.google.com/p/hamcrest/" rel="nofollow">Hamcrest</a> matcher. You will have to include the optional Hamcrest library in your classpath </p><p>Here is an example: </p><pre class="prettyprint"><span class="pln">mockLoader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"test"</span><span class="pun">,</span><span class="pln"> </span><span class="kwd">is</span><span class="pun">(</span><span class="kwd">not</span><span class="pun">(</span><span class="pln">lessThan</span><span class="pun">(</span><span class="lit">5</span><span class="pun">)))).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"correct"</span><span class="pun">)</span><span class="pln"><br><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; assertEquals </span><span class="str">"correct"</span><span class="pun">,</span><span class="pln"> mockLoader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"test"</span><span class="pun">,</span><span class="pln"> </span><span class="lit">10</span><span class="pun">)</span><span class="pln"><br></span><span class="pun">}</span></pre><h2><a name="Order_matching">Order matching</a></h2><p><a name="Order_matching">When the method calls order is important you can use the <tt>ordered</tt> closure. Calls order expectation can apply across multiple mocks. </a></p><p><a name="Order_matching">Here is an example of an hypothetic cached cat database. </a></p><pre class="prettyprint"><a name="Order_matching"><span class="kwd">def</span><span class="pln"> database </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br></span><span class="kwd">def</span><span class="pln"> cache </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>ordered </span><span class="pun">{</span><span class="pln"><br>&nbsp; database</span><span class="pun">.</span><span class="pln">open</span><span class="pun">()</span><span class="pln"><br>&nbsp; cache</span><span class="pun">.</span><span class="kwd">get</span><span class="pun">(</span><span class="str">"select * from cat"</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="kwd">null</span><span class="pun">)</span><span class="pln"><br>&nbsp; database</span><span class="pun">.</span><span class="pln">query</span><span class="pun">(</span><span class="str">"select * from cat"</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">([</span><span class="str">"cat1"</span><span class="pun">,</span><span class="pln"> </span><span class="str">"cat2"</span><span class="pun">])</span><span class="pln"><br>&nbsp; cache</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"select * from cat"</span><span class="pun">,</span><span class="pln"> </span><span class="pun">[</span><span class="str">"cat1"</span><span class="pun">,</span><span class="pln"> </span><span class="str">"cat2"</span><span class="pun">])</span><span class="pln"><br>&nbsp; database</span><span class="pun">.</span><span class="pln">close</span><span class="pun">()</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Order_matching">There is scenario where you don't want to specify ordering within an <tt>ordered</tt> closure. In those cases you should nest the <tt>unordered</tt> closure like this: </a></p><pre class="prettyprint"><a name="Order_matching"><span class="kwd">def</span><span class="pln"> mockLock </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>ordered </span><span class="pun">{</span><span class="pln"><br>&nbsp; mockLock</span><span class="pun">.</span><span class="kwd">lock</span><span class="pun">()</span><span class="pln"><br>&nbsp; unordered </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; </span><span class="com">// ...</span><span class="pln"><br>&nbsp; </span><span class="pun">}</span><span class="pln"><br>&nbsp; mockLock</span><span class="pun">.</span><span class="pln">unlock</span><span class="pun">()</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h2><a name="Regex_methods_matching">Regex methods matching</a></h2><p><a name="Regex_methods_matching">When setting up expectation you can define the method in the form of a regex. This would pick any method matching the regex. Here is how it work: </a></p><pre class="prettyprint"><a name="Regex_methods_matching"><span class="kwd">def</span><span class="pln"> mock </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">()</span><span class="pln"><br>mock</span><span class="pun">.</span><span class="str">/set.*/</span><span class="pun">(</span><span class="lit">1</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="lit">2</span><span class="pun">)</span><span class="pln"><br>play </span><span class="pun">{</span><span class="pln"><br>&nbsp; assertEquals </span><span class="lit">2</span><span class="pun">,</span><span class="pln"> mock</span><span class="pun">.</span><span class="pln">setSomething</span><span class="pun">(</span><span class="lit">1</span><span class="pun">)</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h1><a name="Syntax_Shortcuts">Syntax Shortcuts</a></h1><p><a name="Syntax_Shortcuts">Gmock provides a few syntax shortcut useful in various situation. </a></p><h2><a name="Expectation_in_mock_closure">Expectation in mock closure</a></h2><p><a name="Expectation_in_mock_closure">Mock expectations could be setup during the mock creation in a closure. Like: </a></p><pre class="prettyprint"><a name="Expectation_in_mock_closure"><span class="kwd">def</span><span class="pln"> mock </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">Loader</span><span class="pun">){</span><span class="pln"> <br>&nbsp; load</span><span class="pun">(</span><span class="lit">1</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"one"</span><span class="pun">)</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Expectation_in_mock_closure">Which is equivalent to: </a></p><pre class="prettyprint"><a name="Expectation_in_mock_closure"><span class="kwd">def</span><span class="pln"> mock </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">Loader</span><span class="pun">)</span><span class="pln"><br>mock</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="lit">1</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"one"</span><span class="pun">)</span></a></pre><h2><a name="Using_the_with_Closure">Using the with Closure</a></h2><p><a name="Using_the_with_Closure">Similarly to mock closure you can use the <tt>with</tt> syntax on mock. Like:  </a></p><pre class="prettyprint"><a name="Using_the_with_Closure"><span class="kwd">def</span><span class="pln"> mock </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">Loader</span><span class="pun">)</span><span class="pln"><br><br></span><span class="kwd">with</span><span class="pun">(</span><span class="pln">mock</span><span class="pun">){</span><span class="pln"><br>&nbsp; load</span><span class="pun">(</span><span class="lit">1</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"one"</span><span class="pun">)</span><span class="pln"><br></span><span class="pun">}</span><span class="pln"><br><br></span></a></pre><h2><a name="Static_closure">Static closure</a></h2><p><a name="Static_closure">Static expectations could be setup using the static closure like: </a></p><pre class="prettyprint"><a name="Static_closure"><span class="kwd">def</span><span class="pln"> mockMath </span><span class="pun">=</span><span class="pln"> mock</span><span class="pun">(</span><span class="typ">Math</span><span class="pun">)</span><span class="pln"><br>mockMath</span><span class="pun">.</span><span class="kwd">static</span><span class="pln"> </span><span class="pun">{</span><span class="pln"><br>&nbsp;random</span><span class="pun">().</span><span class="pln">returns</span><span class="pun">(</span><span class="lit">.3</span><span class="pun">)</span><span class="pln"><br>&nbsp;random</span><span class="pun">().</span><span class="pln">returns</span><span class="pun">(</span><span class="lit">.6</span><span class="pun">)</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h1><a name="One_more_thing">One more thing</a></h1><h2><a name="Not_extending_the_GMockTestCase">Not extending the GMockTestCase</a></h2><p><a name="Not_extending_the_GMockTestCase">If you don't want to or can't extend the <tt>GMockTestCase</tt> in your test, you can use the GMockController. </a></p><p><a name="Not_extending_the_GMockTestCase">At the beginning of your test, create a new <tt>GMockController</tt>. You then can use its <tt>mock()</tt> method and <tt>play</tt> closure as per a usual Gmock test. </a></p><pre class="prettyprint"><a name="Not_extending_the_GMockTestCase"><span class="kwd">void</span><span class="pln"> testController</span><span class="pun">(){</span><span class="pln"><br>&nbsp; </span><span class="kwd">def</span><span class="pln"> gmc </span><span class="pun">=</span><span class="pln"> </span><span class="kwd">new</span><span class="pln"> </span><span class="typ">GMockController</span><span class="pun">()</span><span class="pln"><br>&nbsp; </span><span class="kwd">def</span><span class="pln"> mockLoader </span><span class="pun">=</span><span class="pln"> gmc</span><span class="pun">.</span><span class="pln">mock</span><span class="pun">()</span><span class="pln"><br>&nbsp; mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="str">'key'</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">'value'</span><span class="pun">)</span><span class="pln"><br>&nbsp; gmc</span><span class="pun">.</span><span class="pln">play </span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; assertEquals </span><span class="str">"value"</span><span class="pun">,</span><span class="pln"> mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="str">'key'</span><span class="pun">)</span><span class="pln"><br>&nbsp; </span><span class="pun">}</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h2><a name="A_word_on_equals,_hashCode,_toString">A word on equals, hashCode, toString</a></h2><p><a name="A_word_on_equals,_hashCode,_toString">Gmock provides default implementation for the equals, hashcode and toString method so you don't have to setup expectation for them.  </a></p><p><a name="A_word_on_equals,_hashCode,_toString">If you need to you can setup expectation on those methods which will disable the default implementation. </a></p><p><a name="A_word_on_equals,_hashCode,_toString">You can provide an optional name for your mock which will be used in the toString method with the following syntax: <tt>mock(name("now"))</tt> </a></p>

        <a name="A_word_on_equals,_hashCode,_toString"> </a>
    </div>

</div>

</body>
</html>