a:4:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:4:"
  
";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:103:"
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:7:"Xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:17:"http://xangelo.ca";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:30:"Personal blog of a techno-geek";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"generator";a:1:{i:0;a:5:{s:4:"data";s:13:"posterous.com";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:13:{i:0;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 29 Apr 2011 10:21:00 -0700";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:8:"Lemondoo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:26:"http://xangelo.ca/lemondoo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:26:"http://xangelo.ca/lemondoo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:36568:"
        <p>
	<p>Before I begin I just want to note that this document is a work in progress. It requires version 5.3+ of php as it utilizies anonymous functions and it requires the use of limonade-php v0.5.1</p>

<h2>Get caught up</h2>

<p>If you haven&rsquo;t yet, check out <a href="">Part 1</a> of this tutorial to get setup. I&rsquo;m going to assume you did.</p>

<h3>Step 1: Setup</h3>

<p>First lets copy our &ldquo;hello_world&rdquo; directory and rename it to &ldquo;lemondoo&rdquo;. Then open your index.php file and leave delete everything except for the PHP open/close tags and the include statement.</p>

<p><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><br /></div><div class="line" id="LC3"><span class="k">include</span><span class="p">(</span><span class="s1">&#39;lib/limonade.php&#39;</span><span class="p">);</span> </div><div class="line" id="LC4"><br /></div><div class="line" id="LC5"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<p>Now, rename index.php to api.php</p>

<h3>Step 2: Database!</h3>

<p>Now we get to setup our database. Since each of us have different ways of doing this (I switch between command line and sqlbuddy) I&rsquo;m providing the SQL code that will create our database. If you want you can re-create it using your favourite SQL manager.. or you can just copy and paste the SQL code and execute it. It&rsquo;s nothing too complicated, just a single table called &ldquo;todo&rdquo; in a database named &ldquo;lemondoo&rdquo;. Each row in this table will have</p>

<ol>
<li>a &ldquo;todo_id&rdquo; which is an auto incremented primary key (int)</li>
<li>a &ldquo;todo_title&rdquo; which is the title of this todo item (varchar(100))</li>
<li>a &ldquo;todo_text&rdquo; which is the text of the todo item (text)</li>
<li>a &ldquo;completed&rdquo; flag that is either 0 (not completed) or 1 (completed) (tinyint)</li>
</ol>


<p><div class="data type-sql">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
<span rel="#L9" id="L9">9</span>
<span rel="#L10" id="L10">10</span>
<span rel="#L11" id="L11">11</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="k">CREATE</span> <span class="k">DATABASE</span> <span class="o">`</span><span class="n">lemondoo</span><span class="o">`</span> <span class="k">DEFAULT</span> <span class="n">CHARSET</span> <span class="n">utf8</span><span class="p">;</span></div><div class="line" id="LC2"><br /></div><div class="line" id="LC3"><span class="n">USE</span> <span class="o">`</span><span class="n">lemondoo</span><span class="o">`</span><span class="p">;</span></div><div class="line" id="LC4"><br /></div><div class="line" id="LC5"><span class="k">CREATE</span> <span class="k">TABLE</span> <span class="o">`</span><span class="n">todo</span><span class="o">`</span> <span class="p">(</span></div><div class="line" id="LC6">&nbsp;&nbsp;&nbsp;<span class="o">`</span><span class="n">todo_id</span><span class="o">`</span> <span class="nb">int</span><span class="p">(</span><span class="mi">11</span><span class="p">)</span> <span class="k">not</span> <span class="k">null</span> <span class="n">auto_increment</span><span class="p">,</span></div><div class="line" id="LC7">&nbsp;&nbsp;&nbsp;<span class="o">`</span><span class="n">todo_title</span><span class="o">`</span> <span class="nb">varchar</span><span class="p">(</span><span class="mi">100</span><span class="p">),</span></div><div class="line" id="LC8">&nbsp;&nbsp;&nbsp;<span class="o">`</span><span class="n">todo_text</span><span class="o">`</span> <span class="nb">text</span><span class="p">,</span></div><div class="line" id="LC9">&nbsp;&nbsp;&nbsp;<span class="o">`</span><span class="n">completed</span><span class="o">`</span> <span class="n">tinyint</span><span class="p">(</span><span class="mi">4</span><span class="p">)</span> <span class="k">default</span> <span class="s1">&#39;0&#39;</span><span class="p">,</span></div><div class="line" id="LC10">&nbsp;&nbsp;&nbsp;<span class="k">PRIMARY</span> <span class="k">KEY</span> <span class="p">(</span><span class="o">`</span><span class="n">todo_id</span><span class="o">`</span><span class="p">)</span></div><div class="line" id="LC11"><span class="p">)</span> <span class="n">ENGINE</span><span class="o">=</span><span class="n">InnoDB</span> <span class="k">DEFAULT</span> <span class="n">CHARSET</span><span class="o">=</span><span class="n">utf8</span> <span class="n">AUTO_INCREMENT</span><span class="o">=</span><span class="mi">1</span><span class="p">;</span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<p>At this point, I would go ahead and enter a couple sets of data into our new table. Make sure that you set the completed field to 0.</p>

<h3>Step 3: Design our API</h3>

<p>API design, as far as I am concerned, should be an entire topic of study in itself. Adding REST principles makes it a little easier, but still it is something that should be thought about carefully. Below I&rsquo;ve outlined the REST header, the associated URL and the function that it will call. Notice that we can have two different headers assigned to the same url and each can map to their own function call. What we&rsquo;re going to do is define this route for limonade-php so that it knows what to do depending on what URL we try to access. Note below that when I say :id it means that if you access /anything it will call the appropriate method and also assign &ldquo;anything&rdquo; to the variable &ldquo;id&rdquo;. So if you had /:yes it would assign &ldquo;anything&rdquo; to the variable &ldquo;yes&rdquo;</p>

<table>

<tr>
<th></th>
<th> HEADER </th>
<th> URL </th>
<th> Maps to </th>
</tr>


<tr>
<td></td>
<td> GET   </td>
<td> / </td>
<td> get_todo_list |</td>
</tr>
<tr>
<td></td>
<td> POST </td>
<td> / </td>
<td> add_todo |</td>
</tr>
<tr>
<td></td>
<td> GET </td>
<td> :/id </td>
<td> get_todo(id) |</td>
</tr>
<tr>
<td></td>
<td> POST </td>
<td> :/id </td>
<td> update_todo(id) | </td>
</tr>
<tr>
<td></td>
<td> DELETE </td>
<td> :/id </td>
<td> delete_todo(id) |</td>
</tr>

</table>


<p><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
<span rel="#L9" id="L9">9</span>
<span rel="#L10" id="L10">10</span>
<span rel="#L11" id="L11">11</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><br /></div><div class="line" id="LC3"><span class="k">include</span><span class="p">(</span><span class="s1">&#39;lib/limonade.php&#39;</span><span class="p">);</span> </div><div class="line" id="LC4"><br /></div><div class="line" id="LC5"><span class="nx">dispatch_get</span><span class="p">(</span><span class="s1">&#39;/&#39;</span><span class="p">,</span><span class="s1">&#39;get_todo_list&#39;</span><span class="p">);</span></div><div class="line" id="LC6"><span class="nx">dispatch_post</span><span class="p">(</span><span class="s1">&#39;/&#39;</span><span class="p">,</span><span class="s1">&#39;add_todo&#39;</span><span class="p">);</span></div><div class="line" id="LC7"><span class="nx">dispatch_get</span><span class="p">(</span><span class="s1">&#39;/:id&#39;</span><span class="p">,</span><span class="s1">&#39;get_todo&#39;</span><span class="p">);</span></div><div class="line" id="LC8"><span class="nx">dispatch_put</span><span class="p">(</span><span class="s1">&#39;/:id&#39;</span><span class="p">,</span><span class="s1">&#39;update_todo&#39;</span><span class="p">);</span></div><div class="line" id="LC9"><span class="nx">dispatch_delete</span><span class="p">(</span><span class="s1">&#39;/:id&#39;</span><span class="p">,</span><span class="s1">&#39;delete_todo&#39;</span><span class="p">);</span></div><div class="line" id="LC10"><br /></div><div class="line" id="LC11"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<p>Notice that limonade-php comes with some functions that mimic our Headers. <code>dispatch_get, dispatch_post and dispatch_delete</code> are all built in to limonade-php. Also notice that instead of passing an anonymous function to <code>dispatch__xxx</code> as we did previously, now we are passing a string. This string will be the name of the function that we will be creating. There are many different ways that you can provide &ldquo;callbacks&rdquo; to routes, and I would suggest that you read up on them in the <a href="https://github.com/sofadesign/limonade/blob/master/README.mkd">readme</a></p>

<p>Normally, when I create an application the first thing I&rsquo;ll include is a simple database abstraction class. For the purposes of this application, that is a little overkill, so here&rsquo;s a function that will do everything we need it to. <br /><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
<span rel="#L9" id="L9">9</span>
<span rel="#L10" id="L10">10</span>
<span rel="#L11" id="L11">11</span>
<span rel="#L12" id="L12">12</span>
<span rel="#L13" id="L13">13</span>
<span rel="#L14" id="L14">14</span>
<span rel="#L15" id="L15">15</span>
<span rel="#L16" id="L16">16</span>
<span rel="#L17" id="L17">17</span>
<span rel="#L18" id="L18">18</span>
<span rel="#L19" id="L19">19</span>
<span rel="#L20" id="L20">20</span>
<span rel="#L21" id="L21">21</span>
<span rel="#L22" id="L22">22</span>
<span rel="#L23" id="L23">23</span>
<span rel="#L24" id="L24">24</span>
<span rel="#L25" id="L25">25</span>
<span rel="#L26" id="L26">26</span>
<span rel="#L27" id="L27">27</span>
<span rel="#L28" id="L28">28</span>
<span rel="#L29" id="L29">29</span>
<span rel="#L30" id="L30">30</span>
<span rel="#L31" id="L31">31</span>
<span rel="#L32" id="L32">32</span>
<span rel="#L33" id="L33">33</span>
<span rel="#L34" id="L34">34</span>
<span rel="#L35" id="L35">35</span>
<span rel="#L36" id="L36">36</span>
<span rel="#L37" id="L37">37</span>
<span rel="#L38" id="L38">38</span>
<span rel="#L39" id="L39">39</span>
<span rel="#L40" id="L40">40</span>
<span rel="#L41" id="L41">41</span>
<span rel="#L42" id="L42">42</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span></div><div class="line" id="LC2"><span class="sd">/**</span></div><div class="line" id="LC3"><span class="sd"> * A quick little function to interact with a MySQL database.</span></div><div class="line" id="LC4"><span class="sd"> *</span></div><div class="line" id="LC5"><span class="sd"> * When working with Limonade-php a full-fledged MySQL wrapper seems like</span></div><div class="line" id="LC6"><span class="sd"> * overkill. This method instead accepts any mysql statement and if it works</span></div><div class="line" id="LC7"><span class="sd"> * returns either the result or the number of rows affected. If neither worked,</span></div><div class="line" id="LC8"><span class="sd"> * then it returns false</span></div><div class="line" id="LC9"><span class="sd"> *</span></div><div class="line" id="LC10"><span class="sd"> * @param   string      $sql    the sql statement you want to execute</span></div><div class="line" id="LC11"><span class="sd"> * @param   resource    $c      mysql connect link identifier, if multi-connect</span></div><div class="line" id="LC12"><span class="sd"> *                              otheriwse, you can leave it blank</span></div><div class="line" id="LC13"><span class="sd"> * @return  MIXED       array   the result set if the sql statement was a SELECT</span></div><div class="line" id="LC14"><span class="sd"> *                      integer if the sql statement was INSERT|UPDATE|DELETE</span></div><div class="line" id="LC15"><span class="sd"> *                      bool    if anything went wrong with executing your statement</span></div><div class="line" id="LC16"><span class="sd"> *</span></div><div class="line" id="LC17"><span class="sd"> *</span></div><div class="line" id="LC18"><span class="sd"> * [update|insert|delete]</span></div><div class="line" id="LC19"><span class="sd"> * if(db(&#39;update mytable set myrow = 4 where someotherrow = 3&#39;) !== false) {</span></div><div class="line" id="LC20"><span class="sd"> *  // worked!</span></div><div class="line" id="LC21"><span class="sd"> * }</span></div><div class="line" id="LC22"><span class="sd"> *</span></div><div class="line" id="LC23"><span class="sd"> * [select]</span></div><div class="line" id="LC24"><span class="sd"> * $res = db(&#39;select * from mytable&#39;);</span></div><div class="line" id="LC25"><span class="sd"> */</span></div><div class="line" id="LC26"><span class="k">function</span> <span class="nf">db</span><span class="p">(</span><span class="nv">$sql</span><span class="p">,</span><span class="nv">$c</span> <span class="o">=</span> <span class="k">null</span><span class="p">)</span> <span class="p">{</span></div><div class="line" id="LC27">&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$res</span> <span class="o">=</span> <span class="k">false</span><span class="p">;</span></div><div class="line" id="LC28">&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$q</span> <span class="o">=</span> <span class="p">(</span><span class="nv">$c</span> <span class="o">===</span> <span class="k">null</span><span class="p">)</span><span class="o">?@</span><span class="nb">mysql_query</span><span class="p">(</span><span class="nv">$sql</span><span class="p">)</span><span class="o">:@</span><span class="nb">mysql_query</span><span class="p">(</span><span class="nv">$sql</span><span class="p">,</span><span class="nv">$c</span><span class="p">);</span></div><div class="line" id="LC29">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="nv">$q</span><span class="p">)</span> <span class="p">{</span></div><div class="line" id="LC30">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="nb">strpos</span><span class="p">(</span><span class="nb">strtolower</span><span class="p">(</span><span class="nv">$sql</span><span class="p">),</span><span class="s1">&#39;select&#39;</span><span class="p">)</span> <span class="o">===</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class="line" id="LC31">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$res</span> <span class="o">=</span> <span class="k">array</span><span class="p">();</span></div><div class="line" id="LC32">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">while</span><span class="p">(</span><span class="nv">$r</span> <span class="o">=</span> <span class="nb">mysql_fetch_assoc</span><span class="p">(</span><span class="nv">$q</span><span class="p">))</span> <span class="p">{</span></div><div class="line" id="LC33">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$res</span><span class="p">[]</span> <span class="o">=</span> <span class="nv">$r</span><span class="p">;</span></div><div class="line" id="LC34">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC35">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC36">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">else</span> <span class="p">{</span></div><div class="line" id="LC37">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$res</span> <span class="o">=</span> <span class="p">(</span><span class="nv">$c</span> <span class="o">===</span> <span class="k">null</span><span class="p">)</span><span class="o">?</span><span class="nb">mysql_affected_rows</span><span class="p">()</span><span class="o">:</span><span class="nb">mysql_affected_rows</span><span class="p">(</span><span class="nv">$c</span><span class="p">);</span></div><div class="line" id="LC38">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC39">&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC40">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="nv">$res</span><span class="p">;</span></div><div class="line" id="LC41"><span class="p">}</span></div><div class="line" id="LC42"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div><br />
I&rsquo;m not going to explain it in too much detail, but essentially you pass in a SQL statement and it returns either an array-based resultset, or a true/false depending on if the statement succeeded.</p>

<h3>Step 4: Configuring limonade</h3>

<p><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><span class="k">function</span> <span class="nf">configure</span><span class="p">()</span> <span class="p">{</span></div><div class="line" id="LC3">&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$c</span> <span class="o">=</span> <span class="nb">mysql_connect</span><span class="p">(</span><span class="s1">&#39;localhost&#39;</span><span class="p">,</span><span class="s1">&#39;root&#39;</span><span class="p">,</span><span class="s1">&#39;&#39;</span><span class="p">);</span> </div><div class="line" id="LC4">&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$s</span> <span class="o">=</span> <span class="nb">mysql_select_db</span><span class="p">(</span><span class="s1">&#39;todo&#39;</span><span class="p">,</span><span class="nv">$c</span><span class="p">);</span></div><div class="line" id="LC5"><br /></div><div class="line" id="LC6"><span class="p">}</span></div><div class="line" id="LC7"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<h3>Step 5: Define your functions</h3>

<p><strong>get_todo_list():</strong><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><span class="k">function</span> <span class="nf">get_todo_list</span><span class="p">()</span> <span class="p">{</span></div><div class="line" id="LC3">&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$sql</span> <span class="o">=</span> <span class="s1">&#39;select todo_id, todo_title from todo where completed != 1&#39;</span><span class="p">;</span></div><div class="line" id="LC4">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="nx">json</span><span class="p">(</span><span class="nx">db</span><span class="p">(</span><span class="nv">$sql</span><span class="p">));</span></div><div class="line" id="LC5"><span class="p">}</span></div><div class="line" id="LC6"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<p>Limonade-php abstracts away a lot of this work. Basically our db() method returns a two dimensional array containing all our todo&rsquo;s and then that is converted into JSON using json_encode(). The json() provided by Limonade-php is simply a wrapper for that. Finally we return the JSON that we created. Limonade-php will hold the result until it runs through all it&rsquo;s steps before printing out the JSON with the appropriate headers. If you save api.php and visit it from your browser, you should see a JSON representation of the todo&rsquo;s in our</p>

<p><strong>add_todo():</strong><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
<span rel="#L9" id="L9">9</span>
<span rel="#L10" id="L10">10</span>
<span rel="#L11" id="L11">11</span>
<span rel="#L12" id="L12">12</span>
<span rel="#L13" id="L13">13</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><span class="k">function</span> <span class="nf">add_todo</span><span class="p">()</span> <span class="p">{</span></div><div class="line" id="LC3">&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$todo_title</span> <span class="o">=</span> <span class="nb">mysql_real_escape_string</span><span class="p">(</span><span class="nv">$_POST</span><span class="p">[</span><span class="s1">&#39;todo_title&#39;</span><span class="p">]);</span></div><div class="line" id="LC4">&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$todo_text</span> <span class="o">=</span> <span class="p">(</span><span class="k">empty</span><span class="p">(</span><span class="nv">$_POST</span><span class="p">[</span><span class="s1">&#39;todo_text&#39;</span><span class="p">]))</span><span class="o">?</span><span class="nv">$todo_title</span><span class="o">:</span><span class="nb">mysql_real_escape_string</span><span class="p">(</span><span class="nv">$_POST</span><span class="p">[</span><span class="s1">&#39;todo_text&#39;</span><span class="p">]);</span></div><div class="line" id="LC5"><br /></div><div class="line" id="LC6">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="o">!</span><span class="k">empty</span><span class="p">(</span><span class="nv">$todo_title</span><span class="p">))</span> <span class="p">{</span></div><div class="line" id="LC7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$sql</span> <span class="o">=</span> <span class="s1">&#39;insert into todo (todo_title,todo_text) values (&quot;&#39;</span><span class="o">.</span><span class="nv">$todo_title</span><span class="o">.</span><span class="s1">&#39;&quot;,&quot;&#39;</span><span class="o">.</span><span class="nv">$todo_text</span><span class="o">.</span><span class="s1">&#39;&quot;)&#39;</span><span class="p">;</span></div><div class="line" id="LC8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="nx">db</span><span class="p">(</span><span class="nv">$sql</span><span class="p">))</span> <span class="p">{</span></div><div class="line" id="LC9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="nx">json</span><span class="p">(</span><span class="nx">db</span><span class="p">(</span><span class="s1">&#39;select todo_id from todo order by todo_id desc limit 1&#39;</span><span class="p">));</span></div><div class="line" id="LC10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC11">&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC12"><span class="p">}</span></div><div class="line" id="LC13"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<p>Notice that if the note was successfully inserted we are going to just grab the ID of the note and then return that.</p>

<p><strong>get_todo():</strong>
This method will simply return the details of the todo requested. So accessing /1 will return all the details of the todo who&rsquo;s todo_id is 1. <br /><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span></div><div class="line" id="LC2"><span class="k">function</span> <span class="nf">get_todo</span><span class="p">(</span><span class="nv">$id</span><span class="p">)</span> <span class="p">{</span></div><div class="line" id="LC3">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="nb">is_numeric</span><span class="p">(</span><span class="nv">$id</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="o">!</span><span class="k">empty</span><span class="p">(</span><span class="nv">$id</span><span class="p">))</span> <span class="p">{</span></div><div class="line" id="LC4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$sql</span> <span class="o">=</span> <span class="s1">&#39;select * from todo where todo_id = &#39;</span><span class="o">.</span><span class="nv">$id</span><span class="p">;</span></div><div class="line" id="LC5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="nx">json</span><span class="p">(</span><span class="nx">db</span><span class="p">(</span><span class="nv">$sql</span><span class="p">));</span></div><div class="line" id="LC6">&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC7"><span class="p">}</span></div><div class="line" id="LC8"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<p>Notice that in the definition of our function we pass a single argument called $id. Remember how we defined <code>dispatch_get('/:id','get_todo')</code> earlier? Well now the value of :id is going to be passed to our function. We just do a quick check to make sure that the value passed to our function is valid and then we return the results of that dataset.</p>

<p><strong>update_todo():</strong>
Update todo is going to accept all the fields in our todo table (todo_id, todo_title, todo_text, completed) and updated the database corresponding to todo_id. Then it returns either true or false depending on if the update worked. Since the end user will already have the updated data, there is no need to send anything else back.<br /><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
<span rel="#L9" id="L9">9</span>
<span rel="#L10" id="L10">10</span>
<span rel="#L11" id="L11">11</span>
<span rel="#L12" id="L12">12</span>
<span rel="#L13" id="L13">13</span>
<span rel="#L14" id="L14">14</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><span class="k">function</span> <span class="nf">update_todo</span><span class="p">(</span><span class="nv">$id</span><span class="p">)</span> <span class="p">{</span></div><div class="line" id="LC3">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="nb">is_numeric</span><span class="p">(</span><span class="nv">$id</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="o">!</span><span class="k">empty</span><span class="p">(</span><span class="nv">$id</span><span class="p">))</span> <span class="p">{</span></div><div class="line" id="LC4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$todo_title</span> <span class="o">=</span> <span class="nb">mysql_real_escape_string</span><span class="p">(</span><span class="nv">$_POST</span><span class="p">[</span><span class="s1">&#39;title&#39;</span><span class="p">]);</span></div><div class="line" id="LC5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$todo_text</span> <span class="o">=</span> <span class="p">(</span><span class="k">empty</span><span class="p">(</span><span class="nv">$_POST</span><span class="p">[</span><span class="s1">&#39;todo_text&#39;</span><span class="p">]))</span><span class="o">?</span><span class="nv">$todo_title</span><span class="o">:</span><span class="nb">mysql_real_escape_string</span><span class="p">(</span><span class="nv">$unescaped_string</span><span class="p">);</span></div><div class="line" id="LC6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$completed</span> <span class="o">=</span> <span class="nx">bool</span><span class="p">(</span><span class="nv">$_POST</span><span class="p">[</span><span class="s1">&#39;completed&#39;</span><span class="p">]);</span></div><div class="line" id="LC7"><br /></div><div class="line" id="LC8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="o">!</span><span class="k">empty</span><span class="p">(</span><span class="nv">$todo_title</span><span class="p">))</span> <span class="p">{</span></div><div class="line" id="LC9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$sql</span> <span class="o">=</span> <span class="s1">&#39;update todo set todo_title = &quot;&#39;</span><span class="o">.</span><span class="nv">$todo_title</span><span class="o">.</span><span class="s1">&#39;&quot;, todo_text = &quot;&#39;</span><span class="o">.</span><span class="nv">$todo_text</span><span class="o">.</span><span class="s1">&#39;&quot;, completed = &#39;</span><span class="o">.</span><span class="nv">$completed</span><span class="o">.</span><span class="s1">&#39; where todo_id = &#39;</span><span class="o">.</span><span class="nv">$id</span><span class="p">;</span></div><div class="line" id="LC10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="nx">json</span><span class="p">(</span><span class="nx">db</span><span class="p">(</span><span class="nv">$sql</span><span class="p">));</span></div><div class="line" id="LC11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC12">&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC13"><span class="p">}</span></div><div class="line" id="LC14"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<p><strong>delete_todo():</strong>
Finally, this method will delete any todo. We simply pass it an ID, and then BAM. Deleted.<br /><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><span class="k">function</span> <span class="nf">delete_todo</span><span class="p">(</span><span class="nv">$id</span><span class="p">)</span> <span class="p">{</span></div><div class="line" id="LC3">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="nb">is_numeric</span><span class="p">(</span><span class="nv">$id</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="o">!</span><span class="k">empty</span><span class="p">(</span><span class="nv">$id</span><span class="p">))</span> <span class="p">{</span></div><div class="line" id="LC4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$sql</span> <span class="o">=</span> <span class="s1">&#39;delete from todo where todo_id = &#39;</span><span class="o">.</span><span class="nv">$id</span><span class="p">;</span></div><div class="line" id="LC5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="nx">json</span><span class="p">(</span><span class="nx">db</span><span class="p">(</span><span class="nv">$sql</span><span class="p">));</span></div><div class="line" id="LC6">&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC7"><span class="p">}</span></div><div class="line" id="LC8"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<h3>Summary</h3>

<p>So far, our API has been very simple. We can perform some basic actions on our database by accessing various URL&rsquo;s. However, you will notice that you can not access &ldquo;post&rdquo;, &ldquo;put&rdquo; and &ldquo;delete&rdquo; pages through your browser natively. By default, browsers send a &ldquo;GET&rdquo; request, since you are trying to get the contents of a page. If you fill out a form, you get to do a &ldquo;POST&rdquo; request as well.</p>

<p>In our next section we will be building an HTML/JavaScript/CSS interface to work with our newly created API.</p>
	
</p>

<p><a href="http://xangelo.ca/lemondoo">Permalink</a> 

	| <a href="http://xangelo.ca/lemondoo#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:1;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 14 Apr 2011 13:19:00 -0700";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:29:"MySQL access for Limonade-php";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:47:"http://xangelo.ca/mysql-access-for-limonade-php";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:47:"http://xangelo.ca/mysql-access-for-limonade-php";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:9859:"
        <p>
	<p>When working on the web it often helps to have some kind of database abstraction present. For my Limonade-php projects, I normally end up utilizing a single function that currently ties in to a mysql database. The connection happens before you call the method, but if you pass in a connection resource it will use that resource for the sql statement.</p>

<p><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
<span rel="#L9" id="L9">9</span>
<span rel="#L10" id="L10">10</span>
<span rel="#L11" id="L11">11</span>
<span rel="#L12" id="L12">12</span>
<span rel="#L13" id="L13">13</span>
<span rel="#L14" id="L14">14</span>
<span rel="#L15" id="L15">15</span>
<span rel="#L16" id="L16">16</span>
<span rel="#L17" id="L17">17</span>
<span rel="#L18" id="L18">18</span>
<span rel="#L19" id="L19">19</span>
<span rel="#L20" id="L20">20</span>
<span rel="#L21" id="L21">21</span>
<span rel="#L22" id="L22">22</span>
<span rel="#L23" id="L23">23</span>
<span rel="#L24" id="L24">24</span>
<span rel="#L25" id="L25">25</span>
<span rel="#L26" id="L26">26</span>
<span rel="#L27" id="L27">27</span>
<span rel="#L28" id="L28">28</span>
<span rel="#L29" id="L29">29</span>
<span rel="#L30" id="L30">30</span>
<span rel="#L31" id="L31">31</span>
<span rel="#L32" id="L32">32</span>
<span rel="#L33" id="L33">33</span>
<span rel="#L34" id="L34">34</span>
<span rel="#L35" id="L35">35</span>
<span rel="#L36" id="L36">36</span>
<span rel="#L37" id="L37">37</span>
<span rel="#L38" id="L38">38</span>
<span rel="#L39" id="L39">39</span>
<span rel="#L40" id="L40">40</span>
<span rel="#L41" id="L41">41</span>
<span rel="#L42" id="L42">42</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span></div><div class="line" id="LC2"><span class="sd">/**</span></div><div class="line" id="LC3"><span class="sd"> * A quick little function to interact with a MySQL database.</span></div><div class="line" id="LC4"><span class="sd"> *</span></div><div class="line" id="LC5"><span class="sd"> * When working with Limonade-php a full-fledged MySQL wrapper seems like</span></div><div class="line" id="LC6"><span class="sd"> * overkill. This method instead accepts any mysql statement and if it works</span></div><div class="line" id="LC7"><span class="sd"> * returns either the result or the number of rows affected. If neither worked,</span></div><div class="line" id="LC8"><span class="sd"> * then it returns false</span></div><div class="line" id="LC9"><span class="sd"> *</span></div><div class="line" id="LC10"><span class="sd"> * @param   string      $sql    the sql statement you want to execute</span></div><div class="line" id="LC11"><span class="sd"> * @param   resource    $c      mysql connect link identifier, if multi-connect</span></div><div class="line" id="LC12"><span class="sd"> *                              otheriwse, you can leave it blank</span></div><div class="line" id="LC13"><span class="sd"> * @return  MIXED       array   the result set if the sql statement was a SELECT</span></div><div class="line" id="LC14"><span class="sd"> *                      integer if the sql statement was INSERT|UPDATE|DELETE</span></div><div class="line" id="LC15"><span class="sd"> *                      bool    if anything went wrong with executing your statement</span></div><div class="line" id="LC16"><span class="sd"> *</span></div><div class="line" id="LC17"><span class="sd"> *</span></div><div class="line" id="LC18"><span class="sd"> * [update|insert|delete]</span></div><div class="line" id="LC19"><span class="sd"> * if(db(&#39;update mytable set myrow = 4 where someotherrow = 3&#39;) !== false) {</span></div><div class="line" id="LC20"><span class="sd"> *  // worked!</span></div><div class="line" id="LC21"><span class="sd"> * }</span></div><div class="line" id="LC22"><span class="sd"> *</span></div><div class="line" id="LC23"><span class="sd"> * [select]</span></div><div class="line" id="LC24"><span class="sd"> * $res = db(&#39;select * from mytable&#39;);</span></div><div class="line" id="LC25"><span class="sd"> */</span></div><div class="line" id="LC26"><span class="k">function</span> <span class="nf">db</span><span class="p">(</span><span class="nv">$sql</span><span class="p">,</span><span class="nv">$c</span> <span class="o">=</span> <span class="k">null</span><span class="p">)</span> <span class="p">{</span></div><div class="line" id="LC27">&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$res</span> <span class="o">=</span> <span class="k">false</span><span class="p">;</span></div><div class="line" id="LC28">&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$q</span> <span class="o">=</span> <span class="p">(</span><span class="nv">$c</span> <span class="o">===</span> <span class="k">null</span><span class="p">)</span><span class="o">?@</span><span class="nb">mysql_query</span><span class="p">(</span><span class="nv">$sql</span><span class="p">)</span><span class="o">:@</span><span class="nb">mysql_query</span><span class="p">(</span><span class="nv">$sql</span><span class="p">,</span><span class="nv">$c</span><span class="p">);</span></div><div class="line" id="LC29">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="nv">$q</span><span class="p">)</span> <span class="p">{</span></div><div class="line" id="LC30">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span><span class="p">(</span><span class="nb">strpos</span><span class="p">(</span><span class="nb">strtolower</span><span class="p">(</span><span class="nv">$sql</span><span class="p">),</span><span class="s1">&#39;select&#39;</span><span class="p">)</span> <span class="o">===</span> <span class="m">0</span><span class="p">)</span> <span class="p">{</span></div><div class="line" id="LC31">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$res</span> <span class="o">=</span> <span class="k">array</span><span class="p">();</span></div><div class="line" id="LC32">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">while</span><span class="p">(</span><span class="nv">$r</span> <span class="o">=</span> <span class="nb">mysql_fetch_assoc</span><span class="p">(</span><span class="nv">$q</span><span class="p">))</span> <span class="p">{</span></div><div class="line" id="LC33">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$res</span><span class="p">[]</span> <span class="o">=</span> <span class="nv">$r</span><span class="p">;</span></div><div class="line" id="LC34">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC35">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC36">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">else</span> <span class="p">{</span></div><div class="line" id="LC37">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">$res</span> <span class="o">=</span> <span class="p">(</span><span class="nv">$c</span> <span class="o">===</span> <span class="k">null</span><span class="p">)</span><span class="o">?</span><span class="nb">mysql_affected_rows</span><span class="p">()</span><span class="o">:</span><span class="nb">mysql_affected_rows</span><span class="p">(</span><span class="nv">$c</span><span class="p">);</span></div><div class="line" id="LC38">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC39">&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class="line" id="LC40">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="nv">$res</span><span class="p">;</span></div><div class="line" id="LC41"><span class="p">}</span></div><div class="line" id="LC42"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<p>Line by line explanation:</p>

<p>1-25: Documentation</p>

<p>26: Function declaration, accepts an sql statement and an optional connection resource.</p>

<p>27: We preset <code>$res</code> to <code>false</code> This is so that we can get rid of a bunch of if-statements
28: If there is no connection resource, just execute the sql statement. If there is, use it. (@ surpresses errors)</p>

<p>29: Check to see if our query worked, if it didn&rsquo;t, we just return <code>res</code> which we preset.</p>

<p>30: Checks to see if we tried to execute a &lsquo;SELECT&rsquo; statement.</p>

<p>31: Change <code>$res</code> into an array. Our results will be a nested array since our statement worked!</p>

<p>32-34: Loop through our results and assign them to <code>$res</code>.</p>

<p>36-38: If the sql statement was NOT a &lsquo;SELECT&rsquo;, return the number of affected rows. If a user passed in a connection resource, use that.</p>

<p>40: return <code>$res</code>, which could either be <code>false</code>, <code>array()</code> or <code>int</code> depending on if the query failed, was a select statement, affected the rows.</p>
	
</p>

<p><a href="http://xangelo.ca/mysql-access-for-limonade-php">Permalink</a> 

	| <a href="http://xangelo.ca/mysql-access-for-limonade-php#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:2;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 11 Apr 2011 16:14:00 -0700";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:28:"Introduction to Limonade-php";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:46:"http://xangelo.ca/introduction-to-limonade-php";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:46:"http://xangelo.ca/introduction-to-limonade-php";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:7439:"
        <p>
	<p>Before I begin I just want to note that this document is a work in progress. It requires version 5.3+ of php as it utilizies anonymous functions and it requires the use of limonade-php v0.5.1</p>

<p>As promised, here is the first part of a series of tutorials to get you comfortable with working with a great new framework called Limonade-php. I suggest you read about it <a href="http://www.limonade-php.net/">here</a> because the original authors do a damn good job of describing it. Once you&rsquo;ve read a bit about it and have had your curiosity piqued, feel free to follow along with this quick little introduction.</p>

<h2>Getting started with Limonade-php</h2>

<p>Your first step is to simply download Limonade-php from <a href="https://github.com/sofadesign/limonade/downloads">GitHub</a>. Make sure you grab the latest version (v0.5.1 at the time of writing this) and extract it. You&rsquo;ll want to go into the lib directory and copy limonade.php and the limonade directory. The directory contains some utilities for limonade-php, but is not necessary. Infact, once your application is complete properly, I&rsquo;d suggest you delete this folder and leave just the limonade.php file behind.</p>

<h2>The standard first project</h2>

<p>When it comes to programming, your first project is always Hello, World. So let&rsquo;s not break that tradition. Create a new directory called &ldquo;hello_world&rdquo; and in it create a directory called &ldquo;lib&rdquo;. You can paste in the file and directory you copied earlier. Now let&rsquo;s create a file called &ldquo;index.php&rdquo; and open it up in an editor of your choice.</p>

<h3>Step 1: Setup</h3>

<p><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><br /></div><div class="line" id="LC3"><span class="k">include</span><span class="p">(</span><span class="s1">&#39;lib/limonade.php&#39;</span><span class="p">);</span> </div><div class="line" id="LC4"><br /></div><div class="line" id="LC5"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<p>Simple enough, but if you visit that page in your browser, you&rsquo;ll see that it doesn&rsquo;t really do anything. So we&rsquo;re going to add a bit more code.</p>

<h3>Step 2:</h3>

<p>First we&rsquo;re going to say that whenever a user visits that page using a &ldquo;GET&rdquo; header, we&rsquo;re going to display the text &ldquo;Hello, World!&rdquo;. In a nutshell, GET is one of the four recognized header types for REST implementations. GET is for retrieving information about a resource. For more information about REST, check out <a href="http://tomayko.com/writings/rest-to-my-wife">this post</a> and combine it with <a href="http://en.wikipedia.org/wiki/Representational_State_Transfer">this</a><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
<span rel="#L9" id="L9">9</span>
<span rel="#L10" id="L10">10</span>
<span rel="#L11" id="L11">11</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><br /></div><div class="line" id="LC3"><span class="k">include</span><span class="p">(</span><span class="s1">&#39;lib/limonade.php&#39;</span><span class="p">);</span> </div><div class="line" id="LC4"><br /></div><div class="line" id="LC5"><span class="nx">dispatch_get</span><span class="p">(</span><span class="s1">&#39;/&#39;</span><span class="p">,</span> <span class="k">function</span><span class="p">()</span> <span class="p">{</span></div><div class="line" id="LC6">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="s2">&quot;Hello, World!&quot;</span><span class="p">;</span></div><div class="line" id="LC7"><span class="p">});</span></div><div class="line" id="LC8"><br /></div><div class="line" id="LC9"><span class="nx">run</span><span class="p">();</span></div><div class="line" id="LC10"><br /></div><div class="line" id="LC11"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>

<h3>Did you just pass that function a function as an argument?</h3>

<p>Why yes. Yes I did. It&rsquo;s a new feature of PHP 5.3 that allows for anonymous functions. You&rsquo;ll see the same thing happen in JavaScript all the time, so if you work with that, you should find it familiar. Essentially an anonymous function is just a function without a name. There is no way to call it without assigning it to a variable. So, by passing it to <code>dispatch_get</code> as an argument, it is assigned to a variable within limonade-php.</p>

<p>Finally, on line 9 we add the <code>run();</code> command. This tells limonade-php to start.</p>

<p>Now if you visit index.php in your browser, you&rsquo;ll see the text &ldquo;Hello, World!&rdquo;</p>

<h3>Step 3: Profit</h3>

<p>Now that you&rsquo;ve gotten a taste of how easy it is to build something using limonade-php let me just say, that it really is that easy to build just about anything. Because of limonade-php&rsquo;s adherence to RESTful principles it becomes ridiculously easy to build an API or a dynamic website, or just about anything in between. It even integrates very well with other libraries and components. It allows for rapid prototyping (I created <a href="http://lemontrac.xangelo.ca">this</a> ([source])(<a href="https://github.com/AngeloR/Lemontrac)">https://github.com/AngeloR/Lemontrac)</a> in only a few hours &ndash; including the time it took to learn limonade-php) and it has become an important part of my php toolbox.</p>

<h2>Now what?</h2>

<p>Well, it&rsquo;s all well and good to display &ldquo;Hello, World!&rdquo; but it&rsquo;s kind of useless to everyone who wants to build something useful. It hardly scratches the surface of what is possible with limonade-php. So, to properly show you what you can do with it, let&rsquo;s build a very simple todo application. But with a twist. First we&rsquo;re going to build a todo application API. Then we&rsquo;re going to build a website that consumes this API using JavaScript and jQuery.</p>

<p>Stay tuned for part 2 where we will go into greater detail about building applications using limonade-php.</p>
	
</p>

<p><a href="http://xangelo.ca/introduction-to-limonade-php">Permalink</a> 

	| <a href="http://xangelo.ca/introduction-to-limonade-php#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:3;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 01 Apr 2011 22:23:00 -0700";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:17:"Lemontrac updates";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:35:"http://xangelo.ca/lemontrac-updates";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"http://xangelo.ca/lemontrac-updates";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2567:"
        <p>
	<p>Well it&rsquo;s only been a few days since I released Lemontrac to the public but I&rsquo;ve already got a slew of updates that I am planning for it.</p>

<h2>Roles and ACL</h2>

<p>The biggest of these updates is a complete overhaul of the user management system. The plan is to include role-based access control lists which will work pretty well I think. I thought about it and instead of shipping with pre-defined roles, the only role allowed will be an administrator role which will be able to do whatever they want. It&rsquo;s up to them to create the rest of the roles and assign privileges to other users as they see fit. The more flexible it is, the better.</p>

<h2>Sorting and Filters</h2>

<p>Any data manipulation application should come with some excellent sorting and filters. The basic (alpha/last updated/created time/priority) will be implemented, but I am open to any other sorting ideas that people may have. Being able to easily get to all of these is a must, and so there will be some slight UI changes coming up.</p>

<h2>Bug dependencies ##</h2>

<p>Basically, some bugs appear because of a bunch of other bugs. A bug must be able to be marked as &ldquo;dependent&rdquo; on another bug. If that&rsquo;s the case, that bug can&rsquo;t be closed unless all of its dependencies are resolved.</p>

<h2>Merging Bugs</h2>

<p>Users are probably going to experience the same bugs. Being able to merge bugs (and notify the bug creator of possible duplicates) is a necessity to preserve the integrity of the application.</p>

<h2>Email Notifications ##</h2>

<p>This is something I completely overlooked until it was pointed out to me, but the ability to &ldquo;subscribe&rdquo; to a bug or project and be notified of it through future emails is a must.</p>

<p>You can count these as the features that absolutely have to be in place before Lemontrac can move to version 0.2 assuming that everything with work and switch to another OS don&rsquo;t go terribly, you can expect April to feature version 0.2 and also a brief introduction into working with <a href="http://limonade-php.net">Limonade-php</a>. I&rsquo;d urge you to check out the website that is currently in place as it does have some great <a href="http://www.limonade-php.net/examples.htm">tutorials and examples</a>, but incase you&rsquo;re waiting for one, it is in the works.</p>
	
</p>

<p><a href="http://xangelo.ca/lemontrac-updates">Permalink</a> 

	| <a href="http://xangelo.ca/lemontrac-updates#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:4;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 29 Mar 2011 10:33:00 -0700";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:21:"Lemontrac bug tracker";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:39:"http://xangelo.ca/lemontrac-bug-tracker";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:39:"http://xangelo.ca/lemontrac-bug-tracker";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2613:"
        <p>
	<p>Every year I try and make it my goal to really learn at least one web framework. I don&rsquo;t need to become a master at working with it, but I need to know it enough to consider it one of the &ldquo;tools&rdquo; available to me.</p>

<p>This year I started trying to work with CodeIgniter, but then got sidetracked by various personal projects. That and the fact that most frameworks just feel too bloated to me. They keep trying to add on all these &ldquo;features&rdquo; and as nice as they are, they shouldn&rsquo;t really be part of the CORE framework. They&rsquo;re modules to enhance it. Not to mention that most frameworks have such a weird learning curve that it takes a long time before you&rsquo;re comfortable with it.</p>

<p>That&rsquo;s why I was pleasantly surprised by a new PHP framework I stumbled across called <a href="http://limonade-php.net">Limonade-php</a>. Limonade-php is a &ldquo;micro&rdquo; framework. It&rsquo;s more or less one file with a few resources, a LOT smaller than any other framework I&rsquo;ve seen. But it&rsquo;s so ridiculously amazing that I knew I just had to work with it. Limonade allows you to build RESTful applications pretty much instantly. There&rsquo;s almost ZERO learning curve and things just make sense.</p>

<p>For example, adding a new page is as simple as <code>dispatch_get('/page/route','func_name');</code> But can be made complex by utilizing some handy features to allow for query parameters. <code>dispatch_get('/page/:id/some/:resource','myfunc');</code></p>

<p>Of course being almost 100% RESTful compliant, you have access to methods such as dispatch_get, dispatch_post, dispatch_put, dispatch_delete all of can be mapped to the same path allowing you to REALLY build RESTful applications.</p>

<p>I was so impressed with Limonade-php that about an hour after playing around with it I started writing a tool that I needed for my daily work. It was a very simple bug-tracker allowing for multiple projects, bugs and users. It allows you to color-code projects, which immediately translate into color-coded bugs. And it was all done in a single file that is under 550 lines of code (not counting primarily HTML views and CSS).</p>

<p>So check out <a href="http://limonade-php.net">limonade-php</a> and if you like, take a look at the open-source MIT licensed <a href="https://github.com/AngeloR/Lemontrac">Lemontrac</a>.</p>
	
</p>

<p><a href="http://xangelo.ca/lemontrac-bug-tracker">Permalink</a> 

	| <a href="http://xangelo.ca/lemontrac-bug-tracker#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:5;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 25 Mar 2011 07:41:00 -0700";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:40:"Why writing your database first is wrong";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:58:"http://xangelo.ca/why-writing-your-database-first-is-wrong";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:58:"http://xangelo.ca/why-writing-your-database-first-is-wrong";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3721:"
        <p>
	<p>After you've been programming for a while, one of the first things  that you start doing is working out the database. You decide how your  data should be stored, and you think about the optimal ways you can do  this. You think about what technology would best support your idea, and  then you get to work mapping out the back-end. And when that's all done  you start writing your classes. You write the little pieces first, like  what the user object should look like. Then you build the classes and  objects that would utilize the user object, creating new objects as  necessary. And finally, when you're all done, you start designing the  front-facing portion of your application. Whether it's for the web or  for the desktop, as a programmer this is generally the last step.</p>
<p>And you're doing it all wrong.</p>
<p>Designing an application from the STORAGE point of view is all wrong.  Imagine designing a car based on the garage that you were going to put  it in. Yes your car will always fit in the garage, but you're going to  run into problems. You're probably going to have to make some  concessions on the size of the car. But when you're programming, you get  to design the garage too. So why not build the car to be the best damn  car ever, and then build the garage around that? That way you never need  to compromise and you can be damn sure that the car is always going to  fit.</p>
<p>Now, lets apply this metaphor to programming.</p>
<p>The first step I take when building an application is to decide its  purpose. Is the application meant for non-technical users? Is it meant  for children or adults? Is it going to be maintained by me or other  developers? What's the life expectancy of this application? Are there  any third party applications that need to talk to it, or vice versa?  These questions help us define how we should be building the  application. It imposes some features and necessities while still  allowing us a lot of freedom.</p>
<p>To me, data is the most restrictive part of our application. It's the  only part that we have no say in. The data will always be the data. We  can't adjust it to suit our needs. As programmers we spend so much time  living with things that have no real substance. The code we right can  just as easily be re-written a different way. The database we design  could have been designed a completely different way. But yet we insist  on building our application on things that can shift at will. The Data  is concrete. The data is ALWAYS the data and it can never look like  anything else. It can never change shape.</p>
<p>So we should start with The Data. We should say "what is the best way  to display this data". Designers think this way (the good ones do at  least) and it's time for programmers to think this way too. I'm not  talking about how The Data should look to users, but how The Data should  function in our application. Too often we end up having complicated  queries simply because we forgot that we need to use The Data in a  certain way.</p>
<p>We should model how the data needs to be displayed. Once we have that  mapped out our Data will start to fall into some shapes. We simply  coral those semi-ambiguous shapes into something concrete and now we  have a solid database design that really does model our Data. And  because we built our database on REAL Data, we know that we will always  have a place for The Data and that things are as simplified as possible.</p>
	
</p>

<p><a href="http://xangelo.ca/why-writing-your-database-first-is-wrong">Permalink</a> 

	| <a href="http://xangelo.ca/why-writing-your-database-first-is-wrong#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:6;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 25 Mar 2011 03:00:00 -0700";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:24:"Another Project - jsMUDe";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:40:"http://xangelo.ca/another-project-jsmude";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:40:"http://xangelo.ca/another-project-jsmude";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2615:"
        <p>
	<p>I've been working with JavaScript a lot lately and with NodeJS garnering so much attention, I figured it was time for a new project.</p>
<p>I decided to start working on a Multi User Dungeon style game. You remember those old games where you would connect via telnet and then execute commands like "walk north" or "attack" by entering them into a prompt? Well over the next few months I'm going to be working on my own version of that.</p>
<p>In order to make to make it REALLY accessible, I have of course gone with using JS client side with jQuery to handle events and ajax, but where this is really different from my normal projects is the backend. I'm opting to run NodeJS with Express and DBSlayer. So this game will really be running on almost 100% pure JavaScript. Of course I'll be running a standard MySQL database since it seems to make the most sense for this. I investigated other non-relational database mechanisms, but to be honest, they're not suited for structured inter-related data.&nbsp;</p>
<p>As well, this is the first time I'm hoping to use a vcs to handle my source. I was initially looking at GitHub, since that seems to be the standard nowdays, but I find Git... awkward. SVN seems to make more sense to me so I'll probably end up using that. I might sign up at Beanstalk or Assembla that way I still get the option of keeping my source closed during development. I like the idea of open source, but I can't imagine anyone would be interested in my work while it's still being worked on. Things change very frequently, and nothing remains where it is.</p>
<p>I've been working on it for a few days now and here is the current state of the code:</p>
<p>The core only contains a few objects. game, screen and something called Cobra. Cobra acts as a "command manager". Since MUD's are essentially a bunch of commands, Cobra is the object that registers them and calls them when commands are entered. So what this allows us to do is to define separate "commands" that never pollute the global namespace.</p>
<p>Another feature of Cobra is capture, which allows us to temporarily bypass it. Why? Basically we can create temporary commands that exist as long as we want! Huzzah!</p>
<p>Anyways, I shall keep you all informed as to how this proceeds and maybe even do a quick walkthrough of setting up Node/npm/Express/DBSlayer and MySQL (which is ridiculously easy).</p>
	
</p>

<p><a href="http://xangelo.ca/another-project-jsmude">Permalink</a> 

	| <a href="http://xangelo.ca/another-project-jsmude#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:7;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 08 Mar 2011 10:13:12 -0800";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:26:"URL Shortening with Goo.gl";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:43:"http://xangelo.ca/url-shortening-with-googl";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:43:"http://xangelo.ca/url-shortening-with-googl";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3976:"
        <p>
	<p>Google has been offering their URL shortening service for some time now, but for those of you trying to follow along with the official documentation here:&nbsp;<a href="http://code.google.com/apis/urlshortener/v1/getting_started.html#errors">http://code.google.com/apis/urlshortener/v1/getting_started.html</a>&nbsp;you'll have noticed that it's not quite working. Here's how to get url shortening up and running</p>
<p><div class="data type-php">
    
      <table cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <pre class="line_numbers"><span rel="#L1" id="L1">1</span>
<span rel="#L2" id="L2">2</span>
<span rel="#L3" id="L3">3</span>
<span rel="#L4" id="L4">4</span>
<span rel="#L5" id="L5">5</span>
<span rel="#L6" id="L6">6</span>
<span rel="#L7" id="L7">7</span>
<span rel="#L8" id="L8">8</span>
<span rel="#L9" id="L9">9</span>
<span rel="#L10" id="L10">10</span>
<span rel="#L11" id="L11">11</span>
<span rel="#L12" id="L12">12</span>
<span rel="#L13" id="L13">13</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre /><div class="line" id="LC1"><span class="cp">&lt;?php</span> </div><div class="line" id="LC2"><span class="nv">$longUrl</span> <span class="o">=</span> <span class="s1">&#39;http://facebook.com&#39;</span><span class="p">;</span></div><div class="line" id="LC3"><span class="nv">$ch</span> <span class="o">=</span> <span class="nb">curl_init</span><span class="p">();</span></div><div class="line" id="LC4"><span class="nb">curl_setopt</span><span class="p">(</span><span class="nv">$ch</span><span class="p">,</span> <span class="nx">CURLOPT_RETURNTRANSFER</span><span class="p">,</span> <span class="k">true</span><span class="p">);</span></div><div class="line" id="LC5"><span class="nb">curl_setopt</span><span class="p">(</span><span class="nv">$ch</span><span class="p">,</span> <span class="nx">CURLOPT_URL</span><span class="p">,</span> <span class="s1">&#39;http://goo.gl/api/shorten&#39;</span><span class="p">);</span></div><div class="line" id="LC6"><span class="nb">curl_setopt</span><span class="p">(</span><span class="nv">$ch</span><span class="p">,</span> <span class="nx">CURLOPT_POST</span><span class="p">,</span> <span class="k">true</span><span class="p">);</span></div><div class="line" id="LC7"><span class="nb">curl_setopt</span><span class="p">(</span><span class="nv">$ch</span><span class="p">,</span> <span class="nx">CURLOPT_POSTFIELDS</span><span class="p">,</span> <span class="s1">&#39;security_token=null&amp;url=&#39;</span><span class="o">.</span><span class="nv">$longUrl</span><span class="p">);</span></div><div class="line" id="LC8"><br /></div><div class="line" id="LC9"><span class="nv">$content</span> <span class="o">=</span> <span class="nb">curl_exec</span><span class="p">(</span><span class="nv">$ch</span><span class="p">);</span></div><div class="line" id="LC10"><span class="nb">curl_close</span><span class="p">(</span><span class="nv">$ch</span><span class="p">);</span></div><div class="line" id="LC11"><br /></div><div class="line" id="LC12"><span class="k">echo</span> <span class="nx">json_encode</span><span class="p">(</span><span class="nv">$content</span><span class="p">);</span></div><div class="line" id="LC13"><span class="cp">?&gt;</span><span class="x"></span></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div></p>
<p>If you're getting any errors about curl not being enabled, simply pop open your php.ini file and look for this line: <code>;extension=php_curl.dll</code>&nbsp;Then just delete the ';' at the front. Don't forget to restart your server for the new extension to come into effect.</p>
	
</p>

<p><a href="http://xangelo.ca/url-shortening-with-googl">Permalink</a> 

	| <a href="http://xangelo.ca/url-shortening-with-googl#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:8;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 24 Feb 2011 12:40:00 -0800";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:28:"Carbon Application Framework";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:46:"http://xangelo.ca/carbon-application-framework";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:46:"http://xangelo.ca/carbon-application-framework";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:7296:"
        <p>
	<p>A while ago I mentioned that I was working on a modular PHP MVC framework and I just wanted to let people know where things stand.</p>
<p>The project, I feel, is almost ready to enter some late-phase alpha testing, which it will do for a commercial project in the next couple weeks. Since the code itself is open-source, I jumped at the chance to utilize it in a setting that would really push what the code-base was capable of. So far, I have been pretty impressed.&nbsp;</p>
<p><strong>What is the Carbon application Framework?</strong><br />CAF is essentially a more abstracted framework than something like CodeIgniter or CakePHP. It boils down MVC to some essentials: a router, a manager and some helper classes (like sessions or sql). However, Further abstraction IS necessary. CAF's primary strength is the ability to use ANY PHP class as a "module". Modules are essentially bits of code that are not vital to CAF, but are vital to your application. For example, not every application will require Email support, but some might, so they can simply drop in an Email module to the Module directly and load it via <code> $email = CarbonApp::LoadModule('Email'); </code> and have it available to them.</p>
<p>CAF does involve some work on your part to set up, but the benefit of it is that your system is yours. You know what's in it, you know what it does, but it saves you from having to write it again and again. A lot of people talk about using frameworks so that you're not "reinventing the wheel" [<a href="http://book.cakephp.org/view/880/What-is-CakePHP-Why-Use-it">http://book.cakephp.org/view/880/What-is-CakePHP-Why-Use-it</a>]. After all, the argument goes, someone alread wrote it once, why do it again. However, CAF believes that you should be allowed to reinvent the wheel if you want. Why not? If no one ever re-invented the wheel, we'd all be riding around on wooden wheels. Therefore, by taking this very segmented approach to code we are allowing you to easily pull together pieces of code if you want, or just go ahead and write your own. More comfortable with that database accessing code you wrote? Just use it as a module.</p>
<p>But back to the point of this entry: Before&nbsp;CAF is ready to be released for its first pre-beta download there are a&nbsp;number of things I would like to see modified. That is really what this blog post is about. Feel free to comment or post on your own blog (and link back so I can read it) your thoughts about this, or maybe some features that you would like to see in CAF.</p>
<p><strong>Auto Include / Auto Instantiate</strong><br />In an effort to minimize explicitly using and instantiating classes, I've temporarily tied in a method to automatically handle that. You just specify the using directives and BAM, included and instantiated everywhere. Of course, this isn't the idea situation. Sometimes, you may need to instantiate a set of classes whenever a certain controller is requested, other times, you may need the same set of classes whenever any controller is requested. To properly implement this functionality, I think I will need to pull the current code from index.php and replace it with something else.<code>$AutoInitClasses = CarbonApp::GetInstance();


$Router = new Router(true);
$Router-&gt;AutoInitClasses($AutoInitClasses);
$Router-&gt;Process();</code></p>
<p>As you can see, SOMETHING is wrong here when the router is instantiating classes. However, the reason for this is so that auto instantiated classes are available through $Controller-&gt;class_name right away. Like I said, this was a temporary hack to ensure that classes were available to the router.. but what about classes that need to be loaded for all models? or views? Clearly, the solution here is to modify the base class for models and views to allow these classes to appear within. But how to GET those auto-instantiated classes into their respective base classes becomes an issue. Since the Controller loads views and models, it will need to pass the necessary initiated classes. But, since the Controller may require classes of its own instantiated and Router manages instantiating the Controller, Router needs to pass the necessary instantiated classes.</p>
<p><strong>Using<br /></strong>Currently there is a function within the framework called using, which works almost like an import or include. Except that it stores the included files and paths within an associative array. In this way, we get a require_once style include, but it SHOULD be faster than require_once. In fact, because of HOW it's implemented, we don't even need to search through the array to see if it exists. More or less, the code is below <code>static $cache_2;


if(!is_array($cache_2)) {
&nbsp;&nbsp; &nbsp;$cache_2 = array();
}


if($cache_2[$file]) {
&nbsp;&nbsp; return;
}


if(file_exists($file)) {
&nbsp;&nbsp; &nbsp;$cache_2[$file] = true;
&nbsp;&nbsp; &nbsp;include($file);
}
else {
&nbsp;&nbsp; &nbsp;die($file.' does not exist');
}</code></p>
<p>What I would like to do is tuck away the using mechanism into its own class which can then be dealt with on its own. However, what would the benefits of that be? I rather like the ability to have using('path.to.myfile'); from anywhere. It's short and descriptive enough, and it doesn't too much.. so maybe I should leave it as is?</p>
<p><strong>Error Handling<br /></strong>One of the bigger things missing from CAF is any sort of error handling. Http errors (404,403 etc) are essentially displayed as is, although there are work arounds. What I think would be nice would be to have a built in Controller and View that just handles major errors. That way if we encounter any issues we can just spit out a generic page. But then we run into yet another problem.. what if the user is using some kind of templating engine? I don't want to bypass their engine and display my own formatted page. Maybe I could bypass their view by displaying a missing page error temporarily while redirecting the visitor back to a user-defined page.&nbsp;</p>
<p><strong>Better Database Support<br /></strong>During development of the framework, my primary db has been MySQL. In fact, I haven't really had access to anything else. Because of that the database support included is simple and utilizes a "collections" interface. You run whatever query you want, the results are wrapped up nicely in a Collection object and each Row is its own object as well. Like I said, this works fine for JUST MySQL. I have included a very basic class called IDatabase which is essentially an interface to ensure that support for future database engines do not break the code for people who only need the MySQL support for now. No there is no mysqli support, but that should be coming soon.&nbsp;</p>
<p>Something that I would like to do is to move the database out from the Core and include it as a donwloadable module. It's true that a lot of websites will definitely need the SQL system, but in this method if you want to be able to use your own DB classes you can.&nbsp;</p>
<p>&nbsp;</p>
	
</p>

<p><a href="http://xangelo.ca/carbon-application-framework">Permalink</a> 

	| <a href="http://xangelo.ca/carbon-application-framework#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:9;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 04 Feb 2011 09:00:00 -0800";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:19:"Moving to Posterous";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:37:"http://xangelo.ca/moving-to-posterous";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:37:"http://xangelo.ca/moving-to-posterous";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2075:"
        <p>
	<p>Over the coming weeks I will be transitioning my blog away from a self-hosted WordPress solution and to Posterous. One of the biggest reasons is simply the way that Posterous can take whatever I email to it and figure out exactly what needs to be done. If I send a bunch of pictures, Posterous can create a gallery. Sending a video? Posterous will transcode it for me. Think of Posterous as what could have happened to WordPress before they got bogged down trying to be WordPress.</p>
<p>One thing that I really like is the fact that Posterous can auto-post content pretty much anywhere. Between Facebook and twitter, and even syncing to my WordPress blog so that regardless of whether you update your bookmarks, you won't be missing out on any content.&nbsp;</p>
<p>Linking up with Google Analytics is also a snap and I'd urge you to take a look at everything Posterous offers if you're interested in starting a new blog.&nbsp;</p>
<p>Now, I have nothing but good things to say about the time I spent with a self hosted WordPress blog, but the time has come for me to move on and try out newer and better things. Will I still be using Posterous in a few months? I don't know. I may even move back to my old WordPress blog - only time will tell.</p>
<p>For some time though, my posts will be appearing at both <a href="http://xangelo.ca">http://xangelo.ca</a> and <a href="http://wheremy.feethavebeen.com">http://wheremy.feethavebeen.com</a> but eventually, the WordPress installation will fade away and <a href="http://wheremy.feethavebeen.com">http://wheremy.feethavebeen.com</a> will redirect you to my new internet home.</p>
<p>(I also love the default interface for everything. Admin panels, blog theme.. just everything. It's crisp, clean and functional without sacrificing anything.)</p>
<p><a href="http://posterous.com">http://posterous.com</a></p>
	
</p>

<p><a href="http://xangelo.ca/moving-to-posterous">Permalink</a> 

	| <a href="http://xangelo.ca/moving-to-posterous#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:10;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 03 Feb 2011 02:00:00 -0800";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:15:"CRTC Over-ruled";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:33:"http://xangelo.ca/crtc-over-ruled";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"http://xangelo.ca/crtc-over-ruled";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1860:"
        <p>
	<p>A few days after the <a href="http://xangelo.posterous.com/2011/01/the-end-of-streaming">controversial ruling</a> about UBB last week, Industry Minister Tony Clement has come out to say "<a href="http://www.ctv.ca/CTVNews/QPeriod/20110201/crtc-internet-usage-110201/">Hells no</a>." Well... what he actually said is that the CRTC better go back to the drawing board or be prepared to have their new ruling over ruled. If you're a techno-geek in Canada, definitely following along to what he's saying:&nbsp;<a href="http://twitter.com/TonyClement_MP">http://twitter.com/TonyClement_MP</a></p>
<p>Well Canada, it looks like our smaller ISP's will be able to stick around after all.</p>
<p>One thing I will note though, is that the very idea of UBB being imposed upon smaller telecom providers makes sense. What doesn't make sense is the fact that the CRTC provided ludicrous rates and forced them with, what seems like, no public input. Well, unless you could Bell Canada "public input". If this had been an ongoing discussion where everyday users were allowed to weigh in I think UBB being pushed to smaller telecom providers could have worked out.&nbsp;</p>
<p>I understand that companies like Bell need the money to build better infrastructure.. but if that's the case, lets see some cold hard facts. Bell Canada, albeit a private company, should be forced to provide detailed documentation outlining the current state of the infrastructure as well as their proposed improvements. If we can get them to stick by a yearly goal or pay hefty yearly fines if they don't, UBB at 50% as was originally requested by TekSavvy doesn't seem too outrageous...</p>
	
</p>

<p><a href="http://xangelo.ca/crtc-over-ruled">Permalink</a> 

	| <a href="http://xangelo.ca/crtc-over-ruled#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:11;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 31 Jan 2011 19:37:00 -0800";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:20:"The End of Streaming";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:46:"http://xangelo.ca/2011/01/the-end-of-streaming";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:46:"http://xangelo.ca/2011/01/the-end-of-streaming";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:6137:"
        <p>
	<p>Update: Tony Clement says they're scrapping the ruling:&nbsp;<a href="http://xangelo.ca/crtc-over-ruled">http://xangelo.ca/crtc-over-ruled</a></p>
<p>Thanks to new regulation put it place by the CRTC right before the weekend, Canada has effectively shut down ALL streaming services and simultaneously increasing profits for telecom providers. And here's how they did it.</p>
<p><strong>First a bit of facts</strong> <br />In Canada, there are only two major telecom providers. Bell, which provides DSL service (among standard phone/tv options) and Rogers which provides cable internet (tv as well). All other telecom providers actual pay for the use of Rogers and Bell's lines. That is to say, Rogers and Bell charge providers like TekSavvy and Acanet a fee so that they can use the physical lines that Rogers and Bell lay down for internet service. The third telecom, Cogeco, is NOT a major service provider. Instead, they only exist to prevent a monopoly in the telecom industry. There are certain geographical regions outlined by the government where Cogeco is the only telecom provider.</p>
<p><strong>Bandwidth Caps<br /></strong> Since about 2007, Canada has enforced what is known as Bandwidth caps. These caps are essentially usage limits. So you may pay 36$ a month to Bell for a bandwidth cap of 25GB. At this point, every month you are allowed to use 25 gigabytes of bandwidth. Going over results in additional charges being incurred.</p>
<p><strong>Usage Based Billing</strong> <br />Usage Based Billing is what was previously referred to as "additional charges". According to UBB, there is a price attributed to each gigabyte, which seems to be decided entirely by providers. So Bell Canada may decide that a gigabyte is 3$, or they may decide a gigabyte is 2$, OR they may even choose to disregard UBB entirely. Currently, both major providers DO enforce UBB. So, with reference to Bandwidth caps, this means that if you use 30GB, your first 25GB is covered by your monthly payment. The other 5 gigabytes are charged based on usage fees set by the ISP.</p>
<p>Up until this ruling, ISP's have NOT been able to charge resellers (companies like TekSavvy and Acanet) Usage based fees. Because of this, these providers have been able to offer services that Bell Canada claims it can not compete with. Let me clarify that. Bell Canada, claims it can not compete with small telecom providers who pay Bell for use of their systems. So Bell Canada gets to impose UBB fees on smaller telecoms at a 15% discounted rate. So if Bell Canada decides that it's per gigabyte fee is 2$, TekSavvy (as an example) will have to pay 1.70$ to users.   So what does this mean for you and me? Well Bell Canada has established a way to drive smaller providers out of the market. However, the major ISP's have left themselves a loophole. They are free to waive all UBB charges for their own customers. One can easily imagine Bell Canada waiving these fees, while charging TekSavvy and Acanet huge UBB fees until these smaller companies have to shut down. Then Bell is free to bring UBB back in, in full force.</p>
<p>But small ISP's like TekSavvy are not the only ones who are affected. WE are affected. Everyone is affected, even the guy who claims this doesn't affect him because he never goes near his limit. With the internet, comes a certain level of reliability. The INTERNET itself will never go down. But Bell Canada, with the help of our government has effectively regulated our access to it. At a whim, ISP's are now free to dictate how much of the internet we are allowed to access, based on our income.   Not to mention companies that RELY on the internet, that WE rely on. Youtube, as an example, streams videos in high definition. Now, with high UBB fees in effect, you can't watch too many videos on Youtube. Netflix, a leading movie provider in the United States of America has finally started to make its push into Canada. However, high UBB fees may cause this excellent service that rivals traditional tv&nbsp;to be pushed out of Canada entirely. As a side note, isn't it strange that Bell also own's CTV? Which is considered competition for services like Netflix and Hulu.</p>
<p><strong>So What Now?</strong></p>
<p>Canadian Internet consortium OpenMedia is launching an <a href="http://openmedia.ca/meter">effort to bring attention</a> to this newest ruling by the CRTC. If you are Canadian and want to speak out against this, head over to their "Stop The Metering" website and sign the online petition.   Get in touch with your MP and MPP! Your MPP may not care as much, but your MP definitely will. His job is DIRECTLY influenced by the number of people who vote for him in your area. Send him an email or call in and let them you do not agree with this.   Let other people know. <a href="http://openmedia.ca/">OpenMedia </a>is appealing people through <a href="http://www.facebook.com/notes/openmediaca/stop-the-meter-on-your-internet-use/455248704798">Facebook</a> and <a href="http://act.ly/2kw">Twitter</a>. Share the links with your friends. Talk to your co-workers. The more people KNOW about this, the better chance we have of actually influencing a change.   Some more Information:</p>
<p><a href="http://arstechnica.com/tech-policy/news/2011/01/canada-gets-first-bitter-dose-of-metered-internet-billing.ars">http://arstechnica.com/tech-policy/news/2011/01/canada-gets-first-bitter-dose-of-metered-internet-billing.ars</a></p>
<p><a href="http://arstechnica.com/tech-policy/news/2011/01/canada-gets-first-bitter-dose-of-metered-internet-billing.ars"></a> <a href="http://www.teksavvynews.com/">http://www.teksavvynews.com/</a></p>
<p><a href="http://stopusagebasedbilling.wordpress.com/">http://stopusagebasedbilling.wordpress.com/</a></p>
<p><a href="http://openmedia.ca/">http://openmedia.ca/</a></p>
<p><a href="http://openmedia.ca/meter">http://openmedia.ca/meter</a></p>
	
</p>

<p><a href="http://xangelo.ca/2011/01/the-end-of-streaming">Permalink</a> 

	| <a href="http://xangelo.ca/2011/01/the-end-of-streaming#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}i:12;a:6:{s:4:"data";s:47:"
      
      
      
      
      
      
    ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 19 Jan 2011 18:37:00 -0800";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:65:"Why Google's support of WebM changes nothing, unless you're Apple";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:88:"http://xangelo.ca/2011/01/why-googles-support-of-webm-changes-nothing-unless-youre-apple";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:88:"http://xangelo.ca/2011/01/why-googles-support-of-webm-changes-nothing-unless-youre-apple";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2374:"
        <p>
	<p>A few days ago the news was leaked that Google would no longer be supporting H.264 in future versions of Google Chrome. The Internet responded with shouts about how Google was locking things down. Blogs everywhere were weighing in on Googles decision. But most of them seemed to blow things out of proportion, and here's why.  Google is, contrary to belief, NOT dropping support for H.264. Yep, you read that right. People who wish to encode their video in H.264 for the web can continue to do that. I repeat: <strong>there is no need for content publishers to encode their content multiple times</strong>. Instead, what they need to do is modify their delivery.</p>
<p>Google is actually dropping support of H.264 in their HTML5 &lt;video&gt; element. That means that using Chrome will natively support WebM technology using the &lt;video&gt; tag, but through plugins (flash) they will still be able to play H.264 video.  But here's the REAL kicker. Firefox, which owns approximately 43% of the browser market, isn't going to be supporting native H.264 either. And Opera is throwing their 3% in with them too. Together, this group makes up a significant portion of the browserscape. But what they are committing to is not to allow WebM to dominate the internet. Rather, they are allowing an open source media format to replace a proprietary one. WebM is completely free of charge, as opposed to H.264 video which enforces "patent licensing royalties".</p>
<p>So what actually changes? Content providers simply need to decide if they want to push their content through a flash plugin so it can be viewed everywhere, or the native &lt;video&gt; element, so it can be viewed on the iPod and iPad.   And suddenly, we can see why the sudden hub-bub. If 3/4 major browsers decide to support WebM within the &lt;video&gt; tag... What does Apple do? It needs to either support WebM within the &lt;video&gt; tag, start supporting flash or continue to lock down their device. And personally, I can't see apple being very supportive of this open source initiative.</p>
	
</p>

<p><a href="http://xangelo.ca/2011/01/why-googles-support-of-webm-changes-nothing-unless-youre-apple">Permalink</a> 

	| <a href="http://xangelo.ca/2011/01/why-googles-support-of-webm-changes-nothing-unless-youre-apple#comment">Leave a comment&nbsp;&nbsp;&raquo;</a>

</p>
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:33:"http://posterous.com/help/rss/1.0";a:1:{s:6:"author";a:1:{i:0;a:6:{s:4:"data";s:61:"
        
        
        
        
        
        
      ";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:33:"http://posterous.com/help/rss/1.0";a:6:{s:9:"userImage";a:1:{i:0;a:5:{s:4:"data";s:61:"http://files.posterous.com/user_profile_pics/1002223/cave.jpg";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:10:"profileUrl";a:1:{i:0;a:5:{s:4:"data";s:40:"http://posterous.com/people/3sIOWEIotWBH";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:9:"firstName";a:1:{i:0;a:5:{s:4:"data";s:6:"Angelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"lastName";a:1:{i:0;a:5:{s:4:"data";s:9:"Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"nickName";a:1:{i:0;a:5:{s:4:"data";s:7:"xangelo";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"displayName";a:1:{i:0;a:5:{s:4:"data";s:16:"Angelo Rodrigues";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}s:27:"http://www.w3.org/2005/Atom";a:1:{s:4:"link";a:3:{i:0;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:3:{s:4:"type";s:16:"application/json";s:3:"rel";s:37:"http://api.friendfeed.com/2008/03#sup";s:4:"href";s:45:"http://posterous.com/api/sup_update#ba0024dff";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:1;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:2:{s:3:"rel";s:4:"self";s:4:"href";s:25:"http://xangelo.ca/rss.xml";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}i:2;a:5:{s:4:"data";s:0:"";s:7:"attribs";a:1:{s:0:"";a:2:{s:3:"rel";s:3:"hub";s:4:"href";s:31:"http://posterous.superfeedr.com";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:18:{s:3:"via";s:28:"1.1 varnish, 1.1 ERTSRVFWL01";s:10:"connection";s:5:"close";s:16:"proxy-connection";s:5:"close";s:14:"content-length";s:6:"100337";s:3:"age";s:4:"1435";s:4:"date";s:29:"Mon, 09 May 2011 17:55:55 GMT";s:12:"content-type";s:24:"text/html; charset=utf-8";s:4:"etag";s:34:""881e9821fd221d7eb337728b321a065d"";s:6:"server";s:12:"nginx/0.7.65";s:6:"status";s:6:"200 OK";s:19:"x-posteroushostname";s:19:"app18.posterous.com";s:8:"x-sup-id";s:45:"http://posterous.com/api/sup_update#ba0024dff";s:9:"x-runtime";s:4:"2602";s:8:"x-gitsha";s:40:"9152f3f494085674358fef703ea96a9a45545fa2";s:13:"cache-control";s:35:"private, max-age=0, must-revalidate";s:6:"pragma";s:8:"no-cache";s:9:"x-varnish";s:21:"2442054411 2441581765";s:7:"x-cache";s:3:"HIT";}s:5:"build";s:14:"20110509175553";}