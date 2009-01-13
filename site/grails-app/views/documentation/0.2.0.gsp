<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Gmock: Documentation 0.2.0</title>
    <meta name="layout" content="main"/>
</head>


<body>

<div class="container">

    <div class="span-24 source">

        <h1><a name="Introduction">Introduction</a></h1><p><a name="Introduction">Gmock is a mocking framework for the Groovy language.</a></p><p><a name="Introduction">Gmock is all about simple syntax and readability of your tests so you spend less time learning the framework and more writing code. To use Gmock just drop the gmock jar file in your classpath and make sure you also have junit.</a></p><p><a name="Introduction">This documention describe the version 0.2 of Gmock.</a></p><h1><a name="Getting_Started">Getting Started</a></h1><pre class="prettyprint"><a name="Getting_Started"><span class="kwd">import</span><span class="pln">org</span><span class="pun">.</span><span class="pln">gmock</span><span class="pun">.</span><span class="typ">GMockTestCase</span><span class="pln"><br><br></span><span class="kwd">class</span><span class="pln"></span><span class="typ">LoaderTest</span><span class="pln"></span><span class="kwd">extends</span><span class="pln"></span><span class="typ">GMockTestCase</span><span class="pln"></span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp;</span><span class="kwd">void</span><span class="pln">testLoader</span><span class="pun">(){</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp;</span><span class="kwd">def</span><span class="pln">mockLoader</span><span class="pun">=</span><span class="pln">mock</span><span class="pun">()</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp; mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="str">'key'</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">'value'</span><span class="pun">)</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp; play</span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; assertEquals</span><span class="str">"value"</span><span class="pun">,</span><span class="pln">mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="str">'key'</span><span class="pun">)</span><span class="pln"><br>&nbsp; &nbsp; &nbsp; &nbsp;</span><span class="pun">}</span><span class="pln"><br>&nbsp; &nbsp;</span><span class="pun">}</span><span class="pln"><br></span><span class="pun">}</span><span class="pln">&nbsp;</span></a></pre><ul><li><a name="Getting_Started">First extends the <tt>GMockTestCase</tt></a></li><li><a name="Getting_Started">Create mock object using the <tt>mock()</tt> method</a></li><li><a name="Getting_Started">Setup expectation by calling the method you expect on your mock</a></li><li><a name="Getting_Started">Run the code you are testing within the <tt>play</tt> closure</a></li></ul><h1><a name="Cookbook">Cookbook</a></h1><h2><a name="Expectation_and_Play_mode">Expectation and Play mode</a></h2><p><a name="Expectation_and_Play_mode">Mock object are created using the <tt>mock()</tt> method available in <tt>GMockTestCase</tt>. By default mock object will record method call and generate expectation.</a></p><p><a name="Expectation_and_Play_mode">The code under test should run through the <tt>play</tt> closure.</a></p><pre class="prettyprint"><a name="Expectation_and_Play_mode"><span class="kwd">void</span><span class="pln">testBasic</span><span class="pun">(){</span><span class="pln"><br>&nbsp;</span><span class="kwd">def</span><span class="pln">aMock</span><span class="pun">=</span><span class="pln">mock</span><span class="pun">()</span><span class="pln"><br>&nbsp;</span><span class="com">// setup expectation</span><span class="pln"><br>&nbsp; play</span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp;</span><span class="com">// run your code</span><span class="pln"><br>&nbsp;</span><span class="pun">}</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h2><a name="Mock_method_call">Mock method call</a></h2><p><a name="Mock_method_call">Method call expectation are created when calling method on Mock. Return value can be setup using the <tt>returns</tt> keyword.</a></p><pre class="prettyprint"><a name="Mock_method_call"><span class="kwd">def</span><span class="pln">loader</span><span class="pun">=</span><span class="pln">mock</span><span class="pun">()</span><span class="pln"><br>loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"fruit"</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"apple"</span><span class="pun">)</span><span class="pln"><br>play</span><span class="pun">{</span><span class="pln"><br>&nbsp; assertEquals</span><span class="str">"apple"</span><span class="pun">,</span><span class="pln">loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"fruit"</span><span class="pun">)</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Mock_method_call">Exception can be setup using the <tt>raises</tt> keyword.</a></p><pre class="prettyprint"><a name="Mock_method_call"><span class="kwd">def</span><span class="pln">loader</span><span class="pun">=</span><span class="pln">mock</span><span class="pun">()</span><span class="pln"><br>loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"throw exception"</span><span class="pun">).</span><span class="pln">raises</span><span class="pun">(</span><span class="kwd">new</span><span class="pln"></span><span class="typ">RuntimeException</span><span class="pun">(</span><span class="str">"an exception"</span><span class="pun">))</span><span class="pln"><br>play</span><span class="pun">{</span><span class="pln"><br>&nbsp;</span><span class="kwd">try</span><span class="pln"></span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"throw exception"</span><span class="pun">)</span><span class="pln"><br>&nbsp;</span><span class="pun">}</span><span class="pln"></span><span class="kwd">catch</span><span class="pln"></span><span class="pun">(</span><span class="typ">RuntimeException</span><span class="pln">e</span><span class="pun">){</span><span class="pln"><br>&nbsp; &nbsp; assertEquals</span><span class="str">"an exception"</span><span class="pun">,</span><span class="pln">e</span><span class="pun">.</span><span class="pln">message<br>&nbsp;</span><span class="pun">}</span><span class="pln"><br></span><span class="pun">}</span></a></pre><p><a name="Mock_method_call">If you don't care how many times a method is called or not called at all you can stubbed it.</a></p><pre class="prettyprint"><a name="Mock_method_call"><span class="kwd">def</span><span class="pln">loader</span><span class="pun">=</span><span class="pln">mock</span><span class="pun">()</span><span class="pln"><br>loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"fruit"</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"apple"</span><span class="pun">).</span><span class="pln">stub</span><span class="pun">()</span><span class="pln"><br>play</span><span class="pun">{</span><span class="pln"><br>&nbsp; assertEquals</span><span class="str">"apple"</span><span class="pun">,</span><span class="pln">loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"fruit"</span><span class="pun">)</span><span class="pln"><br>&nbsp; assertEquals</span><span class="str">"apple"</span><span class="pun">,</span><span class="pln">loader</span><span class="pun">.</span><span class="pln">put</span><span class="pun">(</span><span class="str">"fruit"</span><span class="pun">)</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h2><a name="Mock_constructor_call">Mock constructor call</a></h2><p><a name="Mock_constructor_call">Constructor call are mocked using the following syntax:</a></p><pre class="prettyprint"><a name="Mock_constructor_call"><span class="kwd">def</span><span class="pln">mockFile</span><span class="pun">=</span><span class="pln">mock</span><span class="pun">(</span><span class="typ">File</span><span class="pun">,</span><span class="pln"></span><span class="kwd">constructor</span><span class="pun">:</span><span class="pln"></span><span class="pun">[</span><span class="str">"/a/path/file.txt"</span><span class="pun">])</span></a></pre><p><a name="Mock_constructor_call">This would match: <tt>new File("/a/path/file.txt")</tt>. The mockFile can then be used to setup further expectation.</a></p><p><a name="Mock_constructor_call">Here is the full picture:</a></p><pre class="prettyprint"><a name="Mock_constructor_call"><span class="kwd">def</span><span class="pln">mockFile</span><span class="pun">=</span><span class="pln">mock</span><span class="pun">(</span><span class="typ">File</span><span class="pun">,</span><span class="pln"></span><span class="kwd">constructor</span><span class="pun">:</span><span class="pln"></span><span class="pun">[</span><span class="str">"/a/path/file.txt"</span><span class="pun">])</span><span class="pln"><br>mockFile</span><span class="pun">.</span><span class="pln">getName</span><span class="pun">().</span><span class="pln">returns</span><span class="pun">(</span><span class="str">"file.txt"</span><span class="pun">)</span><span class="pln"><br>play</span><span class="pun">{</span><span class="pln"><br>&nbsp;</span><span class="kwd">def</span><span class="pln">file</span><span class="pun">=</span><span class="pln"></span><span class="kwd">new</span><span class="pln"></span><span class="typ">File</span><span class="pun">(</span><span class="str">"/a/path/file.txt"</span><span class="pun">)</span><span class="pln"><br>&nbsp; assertEquals</span><span class="str">"file.txt"</span><span class="pun">,</span><span class="pln">file</span><span class="pun">.</span><span class="pln">getName</span><span class="pun">()</span><span class="pln"><br></span><span class="pun">}</span></a></pre><h2><a name="Not_extending_the_GMockTestCase">Not extending the GMockTestCase</a></h2><p><a name="Not_extending_the_GMockTestCase">If you don't want or can't extends the <tt>GMockTestCase</tt> in your test you can use the GMockController.</a></p><p><a name="Not_extending_the_GMockTestCase">In the beginning of your test create a new <tt>GMockController</tt>. You then can use its <tt>mock()</tt> method an <tt>play</tt> closure as a usual Gmock test.</a></p><pre class="prettyprint"><a name="Not_extending_the_GMockTestCase"><span class="kwd">void</span><span class="pln">testController</span><span class="pun">(){</span><span class="pln"><br>&nbsp;</span><span class="kwd">def</span><span class="pln">gmc</span><span class="pun">=</span><span class="pln"></span><span class="kwd">new</span><span class="pln"></span><span class="typ">GMockController</span><span class="pun">()</span><span class="pln"><br>&nbsp;</span><span class="kwd">def</span><span class="pln">mockLoader</span><span class="pun">=</span><span class="pln">gmc</span><span class="pun">.</span><span class="pln">mock</span><span class="pun">()</span><span class="pln"><br>&nbsp; mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="str">'key'</span><span class="pun">).</span><span class="pln">returns</span><span class="pun">(</span><span class="str">'value'</span><span class="pun">)</span><span class="pln"><br>&nbsp; gmc</span><span class="pun">.</span><span class="pln">play</span><span class="pun">{</span><span class="pln"><br>&nbsp; &nbsp; assertEquals</span><span class="str">"value"</span><span class="pun">,</span><span class="pln">mockLoader</span><span class="pun">.</span><span class="pln">load</span><span class="pun">(</span><span class="str">'key'</span><span class="pun">)</span><span class="pln"><br>&nbsp;</span><span class="pun">}</span><span class="pln"><br></span><span class="pun">}</span></a></pre>

        <a name="Not_extending_the_GMockTestCase"></a>

    </div>

</div>

</body>
</html>