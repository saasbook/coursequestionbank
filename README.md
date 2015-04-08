#Course Question Bank - CS 169 Project

Entry interview with client. Basic problem, what client is clooking for:
http://youtu.be/Y6461sJu4ik

#Instructions to run Sunspot Solr
1. Make sure you have JDK 8 installed
2. Start solr server by running 
	<pre>bundle exec sunspot-solr start</pre>
If you want to run tests, then stop the current solr server by running 
<pre>bundle exec sunspot-solr stop</pre>
and start it again at the test port:
<pre>bundle exec sunspot-solr start -p 8981</pre>
3. Reindex the db with
 <pre>rake sunspot:solr:reindex</pre>

