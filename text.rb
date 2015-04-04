quiz '' do 
 select_multiple do

    text %q{Which statements comparing Plan-and-Document (P&D) with
            Agile software engineering processes are true?}

    answer "The basic types of activities involved in software
            engineering are the same in P&D and Agile methodologies",
    :explanation => "
            True: requirements analysis, design, testing, development,
            deployment/delivery, and maintenance are all part of both
            P&D and Agile, but their interaction over the project
            lifetime differs between P&D and Agile.
            "

    distractor "Because Agile tends to focus on small teams, it cannot
                be used effectively to build large systems.",
    :explanation => "
            False: many Agile-developed small services can be connected
            together to form large services in a Service-Oriented Architecture.
            For example, Amazon.com is architected this way.
            "

    answer "The Waterfall methodology involves the customer much more heavily at
            the beginning and end of the lifecycle, whereas the XP (extreme
            programming) methodology involves the customer throughout
            the lifecycle.",
    :explanation => "
            True: a basic tenet of XP is getting frequent feedback from
            the customer and using it to inform the next iteration of
            work.
            "

    answer "The Spiral methodology combines elements of the waterfall model
            with intermediate prototypes."

  end 
 end
