# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@instructor = Instructor.create(name: "foo", provider: "github", uid: "1234")
@instructor2 = Instructor.create(name: "bar", provider: "github", uid: "12345")

@tag1 = Tag.create(name: "quiz 1")
@tag2 = Tag.create(name: "quiz 2")
@tag3 = Tag.create(name: "quiz 3")
@tag4 = Tag.create(name: "quiz 4")
@collection1 = @instructor.collections.create(name: "Fall 14")
@collection2 = @instructor.collections.create(name: "Spring 15")
@collection3 = @instructor.collections.create(name: "Spring 14")

@p1 = Problem.new(created_date: '2012-06-09 21:51:55 UTC', is_public: true, text:
               
               "select_multiple do
    text %q{Around 2007, the claim \"Rails doesn\'t scale\"  was attributed to
Twitter engineers, and the fact that Twitter later moved
away from Rails was cited by some as evidence that the claim was true.
Which of the following statements (there may be more than one) describe Raffi
Krikorian\'s (Twitter Director of Engineering) views on this subject?}
    answer \"Rails itself isn't the problem, but the original Ruby VM does have some performance problems that impede scaling for heavy server workloads.\"
    answer \"Rails itself isn't the problem, but the development processes typically used around Rails don't scale well to large teams.\"
    distractor \"If you're building a startup and expect high volume, Raffi Krikorian would advise you to stay away from Ruby and Rails from the start.\"
    answer \"If Twitter had been architected as a service-oriented architecture from the start, they might have stayed on Ruby/Rails somewhat longer than they did.\"
  end"
               
               )
@p1.instructor = @instructor2
@p1.tags << @tag1
@p1.tags << @tag4
@p1.save


@p2 = Problem.new(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:
               
               "select_multiple do

    text %q{Which statements comparing Plan-and-Document (P&D) with
            Agile software engineering processes are true?}

    answer \"The basic types of activities involved in software
            engineering are the same in P&D and Agile methodologies\",
    :explanation => \"""
            True: requirements analysis, design, testing, development,
            deployment/delivery, and maintenance are all part of both
            P&D and Agile, but their interaction over the project
            lifetime differs between P&D and Agile.
            \"""

    distractor \"Because Agile tends to focus on small teams, it cannot
                be used effectively to build large systems.\",
    :explanation => \"""
            False: many Agile-developed small services can be connected
            together to form large services in a Service-Oriented Architecture.
            For example, Amazon.com is architected this way.
            \"""

    answer \"The Waterfall methodology involves the customer much more heavily at
            the beginning and end of the lifecycle, whereas the XP (extreme
            programming) methodology involves the customer throughout
            the lifecycle.\",
    :explanation => \"""
            True: a basic tenet of XP is getting frequent feedback from
            the customer and using it to inform the next iteration of
            work.
            \"""

    answer \"The Spiral methodology combines elements of the waterfall model
            with intermediate prototypes.\"

  end" 
               
               )
@p2.instructor = @instructor
@p2.tags << @tag1
@p2.tags << @tag2
@p2.collections << @collection2
@p2.collections << @collection3
@p2.save


@p3 = Problem.new(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:
               
               "choice_answer :raw => true do
    text 'In an HTML5 document, what would be the best way to apply the same text-styling rules to several pieces of text that are scattered over the page and are part of <i>different types</i> of HTML elements (&lt;p&gt;, &lt;span&gt;, etc.)?'
    distractor 'Make sure all the elements to be styled have a common parent (ancestor) element',
    :explanation => \"Even when this is possible, it isn't enough to be able to selectively pick out just the elements you want.  Indeed, on a legal HTML 5 page, all the elements already have the common ancestor &lt;body&gt;.\"
    distractor 'Give all the elements to be styled the same \"id\" attribute value',
    :explanation => 'The \"id\" attribute value must be unique across all elements on a page.'
    answer 'Give all the elements to be styled the same \"class\" attribute value',
    :explanation => 'Since the same class can be applied to many elements, even if they are of different element types, it provides an easy way to apply a set of CSS style rules to many elements at once.'
    distractor 'Any of the above techniques would work'
  end" 
               
               )
@p3.instructor = @instructor
@p3.tags << @tag3
@p3.tags << @tag4
@p3.collections << @collection1
@p3.collections << @collection3
@p3.save

@p4 = Problem.new(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:
               
               "choice_answer :raw => true do
    text <<EOq1
        Consider the following Ruby class for a student with
        instance variables for first and last name, and an incomplete method for
        returning the student's full name:
<pre>
class Student
  attr_accessor :first, :last
  def full_name
     ____________
  end
 end
</pre>
       Which of the following would be legal ways to fill in the blank
       so that the <tt>full_name</tt> method returns a student's full
       name (first followed by space followed by last)?  You can assume
       first and last name are legal strings, and that '+' can be used to
       concatenate strings.
EOq1

    answer '<tt>@first + \" \" + @last</tt>',
    :explanation => '<tt>@first</tt> and <tt>@last</tt> are instance
        variables, so this statement works.'
    answer '<tt>self.first + \" \" + self.last</tt>',
    :explanation => 'The <tt>first</tt> and <tt>last</tt> methods are
            created by the call to <tt>attr_accessor</tt>.'
    distractor '<tt>Student.first + \" \" + Student.last</tt>',
    :explanation => 'This would be correct if <tt>first</tt> and <tt>last</tt>
            were class (\"static\") methods, but they are instance methods.'
    answer '<tt>\"\#{first} \#{last}\"</tt>',
    :explanation => \"Here <tt>first</tt> and <tt>last</tt> are resolved
            as method calls on <tt>self</tt>, though it's often clearer
            to include <tt>self</tt> explicitly.\"
    distractor '<tt>self.@first + \" \" + self.@last</tt>',
    :explanation => '<tt>a.b</tt> always means \"Call method <tt>b</tt>
            on receiver <tt>a</tt>\", but <tt>@first</tt> cannot be a
            legal Ruby method name.'

  end" 
               
               )
@p4.instructor = @instructor
@p4.tags << @tag3
@p4.tags << @tag4
@p4.collections << @collection1
@p4.collections << @collection3
@p4.save


@p5 = Problem.new(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:
               
               "select_multiple do
    text 'Comparing plan-and-document vs. agile approaches to cost estimation, which statements are TRUE:'
    answer 'Both try to identify and estimate the impact of possible risks',
    :explanation => 'Agile uses risk information to estimate the scope of a customer estimate, whereas P&D uses risk information up-front to adjust the schedule, but both methodologies take account of risk.'
    distractor  'Frequent iterations of the prototype are a risk-reduction tactic that is present in Agile but absent from P&D methodologies',
    :explanation => 'Spiral and RUP incorporate frequent iteration as part of risk reduction.'
    distractor 'In both methodologies, nontechnical risks are more likely to jeopardize the schedule than technical risks.',
    :explanation => 'In both methodologies, neither technical or nontechnical risks are inherently more serious than the other; either type could potentially have a serious impact on the schedule.'
    answer 'Both must deal with customers asking for changes after schedule is in place and project starts'
  end" 
               
               )
@p5.instructor = @instructor
@p5.tags << @tag1
@p5.tags << @tag3
@p5.collections << @collection1
@p5.collections << @collection2
@p5.save

@p6 = Problem.new(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:
               
               "choice_answer :raw => true do
    text <<EOq2
        Consider the following Ruby code:
<pre>
class Student
  attr_reader :first, :last
  def initialize(first, last)
    @first = first
    @last = last
    @full = first + ' ' + last
 end
end
</pre>
       Suppose from OUTSIDE the class we execute <tt>@student = Student.new('Armando','Fox')</tt>.
       Which of the following expressions will return this student's full
       name (first followed by space followed by last)?
EOq2

    answer '<tt>@student.first + " " + @student.last</tt>',
    :explanation => 'This works by using the accessors for first and last.'
    distractor '<tt>@student.full</tt>',
    :explanation => 'There is no accessor method defined for the <tt>@full</tt> instance variable.'
    distractor '<tt>@student.@full</tt>',
    :explanation => '<tt>a.b</tt> always means call method b on object a, but <tt>@full</tt> is
               not a legal method name.'
    distractor '<tt>Student.first + " " + Student.last</tt>',
    :explanation => 'This would be correct if <tt>first</tt> and <tt>last</tt>
            were class (\"static\") methods, but they are instance methods.'
  end" 
               
               )
@p6.instructor = @instructor
@p6.tags << @tag1
@p6.tags << @tag3
@p6.collections << @collection1
@p6.collections << @collection2
@p6.save

@p7 = Problem.new(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:
               
               "select_multiple do
    text 'Which statements are TRUE regarding Rails routes and the resources to which they refer?'
    answer 'In an MVC app, every valid route must eventually trigger a controller action.'
    answer 'One common set of RESTful resource actions are the CRUD actions on models.'
    distractor 'A route always contains one or more wildcard parameters, such as \":id\", to identify the particular resource named in the operation.',
    :explanation => \"Some routes, such as those to list all resources of a given type or create a new resource of a given type, don't require any such identifier.\"
  end" 
               
               )
@p7.instructor = @instructor
@p7.tags << @tag1
@p7.tags << @tag3
@p7.collections << @collection1
@p7.collections << @collection2
@p7.save

@p8 = Problem.new(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:
               
               "choice_answer do
    text \"Which rendering system - Haml or Erb - uses indentation to indicate element nesting?\"
    answer 'Haml'
    distractor 'Erb'
    distractor 'both'
  end" 
               
               )
@p8.instructor = @instructor
@p8.tags << @tag1
@p8.tags << @tag3
@p8.collections << @collection1
@p8.collections << @collection2
@p8.save


@p9 = Problem.new(created_date: '2013-06-09 21:51:55 UTC', is_public: true, text:
               
               "choice_answer do
    text \"Which rendering system - Haml or Erb - allows not only Ruby variables but arbitrary Ruby code to be interpolated into a template?\"
    distractor 'Haml'
    distractor 'Erb'
    answer 'both'
  end" 
               
               )
@p9.instructor = @instructor
@p9.tags << @tag1
@p9.tags << @tag3
@p9.collections << @collection1
@p9.collections << @collection2
@p9.save



