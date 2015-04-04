quiz '' do 
 select_multiple do
    text 'Which statements are TRUE regarding Rails routes and the resources to which they refer?'
    answer 'In an MVC app, every valid route must eventually trigger a controller action.'
    answer 'One common set of RESTful resource actions are the CRUD actions on models.'
    distractor 'A route always contains one or more wildcard parameters, such as ":id", to identify the particular resource named in the operation.',
    :explanation => "Some routes, such as those to list all resources of a given type or create a new resource of a given type, don't require any such identifier."
  end 
 end