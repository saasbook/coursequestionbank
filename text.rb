quiz '' do 
   choice_answer :randomize => true do
    text "An HTTP request must consist of both a(n) ----- and a(n) -----"
    distractor "CRUD action, database"
    distractor "header, cookie", :explanation => 'A header is part of the request, but a cookie is not necessarily included unless the server previously specified one.'
    distractor "URL, wildcard", :explanation => 'A URL is necessary, but not a wildcard.'
    answer "URI, HTTP request method", :explanation => "The URI alone isn't enough--the same URI used with two different methods can cause two different actions."
  end
 
 end